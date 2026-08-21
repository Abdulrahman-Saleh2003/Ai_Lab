import 'dart:convert';
import 'package:ai_lab/core/shared/cache_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// معالج إشعارات الخلفية عندما يكون التطبيق مغلقاً أو في الخلفية (Background Isolate)
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  try {
    await Firebase.initializeApp();
    await CacheHelper.init();

    debugPrint('🔔 [FCM Background] Received message: ${message.messageId}');
    debugPrint('🔔 [FCM Background] Data payload: ${message.data}');

    // في حال كانت الرسالة تحتوي على نتيجة فحص OCR مكتمل
    final data = message.data;
    final reportId = data['report_id']?.toString();
    if (reportId != null && reportId.isNotEmpty) {
      if (data.containsKey('ocr_result') || data.containsKey('ai_result')) {
        final rawResult = data['ocr_result'] ?? data['ai_result'];
        Map<String, dynamic>? parsedMap;
        if (rawResult is String) {
          try {
            parsedMap = jsonDecode(rawResult);
          } catch (_) {}
        } else if (rawResult is Map) {
          parsedMap = Map<String, dynamic>.from(rawResult);
        }

        if (parsedMap != null) {
          await CacheHelper.cacheReportAnalysis(reportId, parsedMap);
          debugPrint('✅ [FCM Background] OCR result cached for report: $reportId');
        }
      }
    }
  } catch (e) {
    debugPrint('❌ [FCM Background Handler Error]: $e');
  }
}

class FCMService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  static const AndroidNotificationChannel _channel = AndroidNotificationChannel(
    'ocr_analysis_channel',
    'OCR Lab Analysis Notifications',
    description: 'Notifications for completed medical lab analysis and reports',
    importance: Importance.max,
    playSound: true,
    enableVibration: true,
  );

  /// تهيئة خدمة الـ FCM والإشعارات المحلية
  static Future<void> initialize({
    Function(String? reportId)? onNotificationClicked,
  }) async {
    // 1. تسجيل معالج الخلفية
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    // 2. طلب صلاحيات الإشعارات (Android 13+ و iOS)
    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );

    debugPrint('🔔 [FCM] Notification authorization status: ${settings.authorizationStatus}');

    // 3. تهيئة قناة الإشعارات للأندرويد
    await _localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_channel);

    // 4. تهيئة إعدادات الإشعارات المحلية
    const initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/launcher_icon');
    const initializationSettingsDarwin = DarwinInitializationSettings();
    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    await _localNotifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (response) {
        final payload = response.payload;
        if (payload != null && payload.isNotEmpty) {
          onNotificationClicked?.call(payload);
        }
      },
    );

    // 5. إعداد إشعارات الواجهة الأمامية (Foreground Presentation)
    await _messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    // 6. الاستماع للإشعارات عندما يكون التطبيق مفتوحاً (Foreground)
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('🔔 [FCM Foreground] Title: ${message.notification?.title}');
      debugPrint('🔔 [FCM Foreground] Body: ${message.notification?.body}');

      final notification = message.notification;
      final android = message.notification?.android;

      if (notification != null) {
        _localNotifications.show(
          notification.hashCode,
          notification.title ?? 'اكتمال تحليل التقرير',
          notification.body ?? 'نتائج التحليل الطبي أصبحت جاهزة للعرض',
          NotificationDetails(
            android: AndroidNotificationDetails(
              _channel.id,
              _channel.name,
              channelDescription: _channel.description,
              importance: Importance.max,
              priority: Priority.high,
              icon: android?.smallIcon ?? '@mipmap/launcher_icon',
              playSound: true,
              enableVibration: true,
            ),
          ),
          payload: message.data['report_id']?.toString(),
        );
      }
    });

    // 7. التعامل مع فتح الإشعار عندما يكون التطبيق في الخلفية
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      final reportId = message.data['report_id']?.toString();
      if (reportId != null && reportId.isNotEmpty) {
        onNotificationClicked?.call(reportId);
      }
    });

    // 8. التعامل مع فتح الإشعار عندما كان التطبيق مغلقاً تماماً (Terminated)
    final initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      final reportId = initialMessage.data['report_id']?.toString();
      if (reportId != null && reportId.isNotEmpty) {
        onNotificationClicked?.call(reportId);
      }
    }

    // 9. جلب رمز الجهاز (FCM Device Token) وتخزينه
    await fetchAndSaveFCMToken();

    // 10. مراقبة تحديث الرمز
    _messaging.onTokenRefresh.listen((newToken) async {
      debugPrint('🔔 [FCM] Token refreshed: $newToken');
      await CacheHelper.putUserFCMToken(fCMToken: newToken);
    });
  }

  /// جلب رمز الجهاز وحفظه محلياً
  static Future<String?> fetchAndSaveFCMToken() async {
    try {
      final token = await _messaging.getToken();
      if (token != null) {
        debugPrint('🔑 [FCM Token]: $token');
        await CacheHelper.putUserFCMToken(fCMToken: token);
      }
      return token;
    } catch (e) {
      debugPrint('❌ [FCM Get Token Error]: $e');
      return null;
    }
  }
}
