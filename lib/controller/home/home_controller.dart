//
//
// import 'dart:async';
// import 'dart:io';
//
// import 'package:ai_lab/controller/home/home_provider.dart';
// import 'package:ai_lab/controller/home/home_state.dart';
// import 'package:ai_lab/models/home/lab_report_models.dart';
// import 'package:ai_lab/screens/HomeScreen/Home/home_screen.dart';
// import 'package:ai_lab/screens/HomeScreen/chat/chat_screen.dart';
// import 'package:ai_lab/screens/HomeScreen/profile/profile.dart';
// import 'package:ai_lab/screens/HomeScreen/report/cbc_report_screen.dart';
// import 'package:ai_lab/screens/HomeScreen/report/report_screen.dart';
// import 'package:ai_lab/screens/HomeScreen/report/all_reports_page.dart';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:image_picker/image_picker.dart';
//
// class HomeController extends Notifier<HomeState> {
//   final ImagePicker _picker = ImagePicker();
//   Timer? _pollingTimer;
//   int _pollAttempts = 0;
//
//   // كل 7 ثواني × 25 محاولة ≈ 3 دقائق قبل ما نعتبرها timeout
//   static const int _maxPollAttempts = 15;
//
//   @override
//   HomeState build() {
//     // مهم: نلغي أي polling شغال لو الـ Notifier انبنى من جديد
//     ref.onDispose(() {
//       _pollingTimer?.cancel();
//     });
//     return const HomeState();
//   }
//
//   final List<Widget> pages = [
//     const HomeScreen(),            // 0 - DASHBOARD
//     const AllReportsPage(),        // 1 - TESTS
//     const CBCReportScreen(),       // 2 - APPOINTMENTS
//     const BloodCountReportPage(),  // 3 - REPORTS
//     const PatientProfilePage(),    // 4 - SETTINGS
//     const ChatScreen(),            // 5 - CHAT  ← الأخير
//   ];
//
//   void changePage(int index) {
//     state = state.copyWith(currentIndex: index);
//   }
//
//   // ─── اختيار صورة من الكاميرا أو المعرض ───
//   Future<void> pickImage(ImageSource source) async {
//     try {
//       final XFile? picked = await _picker.pickImage(
//         source: source,
//         imageQuality: 85,
//         maxWidth: 2000,
//       );
//       if (picked != null) {
//         state = state.copyWith(
//           selectedImage: File(picked.path),
//           status: HomeStatus.initial,
//           clearError: true,
//         );
//       }
//     } catch (e, st) {
//       debugPrint("PickImage Error: $e");
//       debugPrint("StackTrace: $st");
//       state = state.copyWith(
//         status: HomeStatus.error,
//         errorMessage:
//         "تعذر فتح ${source == ImageSource.camera ? 'الكاميرا' : 'المعرض'}: $e",
//       );
//     }
//   }
//
//   // ─── إلغاء اختيار الصورة (رجوع لزر Upload) ───
//   void removeImage() {
//     _pollingTimer?.cancel();
//     state = const HomeState(); // يرجع كل شي لحالته الافتراضية
//   }
//
//   // ─── يستخدمها report_details_screen: صورة تقرير قديم (نزّلناها محلياً) ───
//   // بترسل نفس مسار الـ analyzeImage العادي، بس بتحط الصورة بالـ state أول
//   Future<void> analyzeExistingImage(File image) async {
//     print("____________________________________");
//     print(image.path.toString());
//     print("____________________________________");
//
//     state = state.copyWith(
//       selectedImage: image,
//       status: HomeStatus.initial,
//       clearError: true,
//       clearJobId: true,
//     );
//     await analyzeImage();
//   }
//
//   // ─── الخطوة 1: رفع الصورة، السيرفر بيرجع job_id فوراً ───
//   Future<void> analyzeImage() async {
//     if (state.selectedImage == null) return;
//
//     state = state.copyWith(status: HomeStatus.uploading, clearError: true);
//
//     final result = await ref.read(homeDataProvider).postData(
//       image: state.selectedImage!,
//     );
//
//     result.fold(
//           (failure) {
//         state = state.copyWith(
//           status: HomeStatus.error,
//           errorMessage: "فشل رفع الصورة، حاول مرة أخرى",
//         );
//       },
//           (data) {
//         final String? jobId = (data is Map) ? data['job_id']?.toString() : null;
//
//         if (jobId == null || jobId.isEmpty) {
//           state = state.copyWith(
//             status: HomeStatus.error,
//             errorMessage: "لم يتم استلام رقم العملية من السيرفر",
//           );
//           return;
//         }
//
//         state = state.copyWith(status: HomeStatus.analyzing, jobId: jobId);
//         _startPolling(jobId);
//       },
//     );
//   }
//
//   // ─── الخطوة 2: كل 7 ثواني نسأل السيرفر خلص التحليل ولا لسا ───
//   void _startPolling(String jobId) {
//     _pollingTimer?.cancel();
//     _pollingTimer = null; // ✅ تأكيد إضافي
//
//     _pollAttempts = 0;
//     _pollingTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
//       _checkResult(jobId);
//     });
//   }
//
//   Future<void> _checkResult(String jobId) async {
//     // إذا المستخدم غيّر الصورة أو خرج من الحالة، منوقف الطلب
//     if (state.jobId != jobId) {
//       _pollingTimer?.cancel();
//       return;
//     }
//
//     _pollAttempts++;
//     if (_pollAttempts > _maxPollAttempts) {
//       _pollingTimer?.cancel();
//       // ✅ تحقق إضافي: بس لو لسا هاد الـ job هو الحالي
//       if (state.jobId == jobId) {
//         state = state.copyWith(
//           status: HomeStatus.error,
//           errorMessage: "استغرق التحليل وقتاً أطول من المتوقع. حاول رفع الصورة مرة أخرى.",
//         );
//       }
//       return;
//     }
//
//     final result = await ref.read(homeDataProvider).checkResult(jobId);
//
//     // ✅✅ التحقق الأهم: بعد الـ await، تأكد الـ job لسا هو الحالي
//     // (ممكن يكون تبدّل بين ما بلشنا الطلب وما رجعنا الجواب)
//     if (state.jobId != jobId) {
//       return; // تجاهل الرد، صار في job أحدث
//     }
//
//     result.fold(
//           (failure) {
//         debugPrint("Check result failed, retrying in 7s...");
//       },
//           (response) {
//         final dynamic rawBody = response.data ?? response;
//         if (rawBody is! Map) return;
//
//         final jobStatus = LabJobStatus.fromJson(Map<String, dynamic>.from(rawBody));
//
//         if (jobStatus.isFailed) {
//           _pollingTimer?.cancel();
//           state = state.copyWith(
//             status: HomeStatus.error,
//             errorMessage: "فشل تحليل الصورة بالسيرفر",
//           );
//           return;
//         }
//
//         if (jobStatus.isDone && jobStatus.result != null) {
//           _pollingTimer?.cancel();
//           state = state.copyWith(
//             status: HomeStatus.ready,
//             analysisResult: jobStatus.result,
//           );
//         }
//       },
//     );
//   }
//
//
//
//
//
//
//
//
//   // ─── يضغط "اذهب لمشاهدة النتائج" ───
//   // حالياً منرجع الصفحة لوضعها الأصلي (زر Upload)، والانتقال لصفحة
//   // النتيجة نفسها منضيفه لاحقاً حسب ما حكينا
//   void goToResults() {
//     _pollingTimer?.cancel();
//     state = const HomeState();
//   }
//
//
//
//
//   Future<void> fetchAllReports({bool forceRefresh = false}) async {
//     // إذا البيانات موجودة أصلاً ومش forceRefresh → ما تعمل شيء
//     if (!forceRefresh &&
//         state.reportsStatus == ReportsListStatus.loaded &&
//         state.reports.isNotEmpty) {
//       return;
//     }
//
//     // إذا عم يحمّل أصلاً، منتجاهل الطلب المكرر
//     if (state.reportsStatus == ReportsListStatus.loading) return;
//
//     state = state.copyWith(
//       reportsStatus: ReportsListStatus.loading,
//       clearReportsError: true,
//     );
//
//     final result = await ref.read(homeDataProvider).getAllReports();
//
//     result.fold(
//           (failure) {
//         state = state.copyWith(
//           reportsStatus: ReportsListStatus.error,
//           reportsErrorMessage: "تعذر تحميل التقارير، تأكد من الاتصال",
//         );
//       },
//           (response) {
//         final dynamic rawBody = response.data ?? response;
//         if (rawBody is! Map) {
//           state = state.copyWith(
//             reportsStatus: ReportsListStatus.error,
//             reportsErrorMessage: "شكل البيانات القادمة من السيرفر غير متوقع",
//           );
//           return;
//         }
//
//         final parsed =
//         LabReportsResponse.fromJson(Map<String, dynamic>.from(rawBody));
//
//         state = state.copyWith(
//           reportsStatus: ReportsListStatus.loaded,
//           reports: parsed.results,
//         );
//       },
//     );
//   }
//   // ─── جلب كل التقارير (تستخدمها AllReportsPage) ───
//   Future<void> fetchAllReports1() async {
//     // إذا عم يحمّل أصلاً، منتجاهل الطلب المكرر
//     if (state.reportsStatus == ReportsListStatus.loading) return;
//
//     state = state.copyWith(
//       reportsStatus: ReportsListStatus.loading,
//       clearReportsError: true,
//     );
//
//     final result = await ref.read(homeDataProvider).getAllReports();
//
//     result.fold(
//           (failure) {
//         state = state.copyWith(
//           reportsStatus: ReportsListStatus.error,
//           reportsErrorMessage: "تعذر تحميل التقارير، تأكد من الاتصال",
//         );
//       },
//           (response) {
//         final dynamic rawBody = response.data ?? response;
//         if (rawBody is! Map) {
//           state = state.copyWith(
//             reportsStatus: ReportsListStatus.error,
//             reportsErrorMessage: "شكل البيانات القادمة من السيرفر غير متوقع",
//           );
//           return;
//         }
//
//         final parsed =
//         LabReportsResponse.fromJson(Map<String, dynamic>.from(rawBody));
//
//         state = state.copyWith(
//           reportsStatus: ReportsListStatus.loaded,
//           reports: parsed.results,
//         );
//       },
//     );
//   }
// }
//

// ####################
///todo  //claude.ai/
// ##############



import 'dart:async';
import 'dart:io';

import 'package:ai_lab/controller/home/home_provider.dart';
import 'package:ai_lab/controller/home/home_state.dart';
import 'package:ai_lab/models/home/lab_report_models.dart';
import 'package:ai_lab/screens/HomeScreen/Home/home_screen.dart';
import 'package:ai_lab/screens/HomeScreen/chat/chat_screen.dart';
import 'package:ai_lab/screens/HomeScreen/profile/profile.dart';
import 'package:ai_lab/screens/HomeScreen/report/cbc_report_screen.dart';
import 'package:ai_lab/screens/HomeScreen/report/report_screen.dart';
import 'package:ai_lab/screens/HomeScreen/report/all_reports_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class HomeController extends Notifier<HomeState> {
  final ImagePicker _picker = ImagePicker();
  Timer? _pollingTimer;
  int _pollAttempts = 0;

  // ✅ جديد: Timer + عدّاد محاولات مستقلين لكل تقرير بالقائمة (مفتاحهم reportId)
  final Map<String, Timer> _reportPollingTimers = {};
  final Map<String, int> _reportPollAttempts = {};

  // كل 10 ثواني × 15 محاولة ≈ 2.5 دقيقة قبل ما نعتبرها timeout
  static const int _maxPollAttempts = 15;

  @override
  HomeState build() {
    ref.onDispose(() {
      _pollingTimer?.cancel();
      // ✅ إلغاء كل تايمرز التقارير المفتوحة عند تدمير الـ Notifier
      for (final timer in _reportPollingTimers.values) {
        timer.cancel();
      }
      _reportPollingTimers.clear();
    });
    return const HomeState();
  }

  final List<Widget> pages = [
    const HomeScreen(),
    const AllReportsPage(),
    const CBCReportScreen(),
    const BloodCountReportPage(),
    const PatientProfilePage(),
    const ChatScreen(),
  ];

  void changePage(int index) {
    state = state.copyWith(currentIndex: index);
  }

  // ─── اختيار صورة من الكاميرا أو المعرض (الهوم) ───
  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? picked = await _picker.pickImage(
        source: source,
        imageQuality: 85,
        maxWidth: 2000,
      );
      if (picked != null) {
        state = state.copyWith(
          selectedImage: File(picked.path),
          status: HomeStatus.initial,
          clearError: true,
        );
      }
    } catch (e, st) {
      debugPrint("PickImage Error: $e");
      debugPrint("StackTrace: $st");
      state = state.copyWith(
        status: HomeStatus.error,
        errorMessage:
        "تعذر فتح ${source == ImageSource.camera ? 'الكاميرا' : 'المعرض'}: $e",
      );
    }
  }

  void removeImage() {
    _pollingTimer?.cancel();
    state = const HomeState();
  }

  Future<void> analyzeExistingImage(File image) async {
    state = state.copyWith(
      selectedImage: image,
      status: HomeStatus.initial,
      clearError: true,
      clearJobId: true,
    );
    await analyzeImage();
  }

  Future<void> analyzeImage() async {
    if (state.selectedImage == null) return;

    state = state.copyWith(status: HomeStatus.uploading, clearError: true);

    final result = await ref.read(homeDataProvider).postData(
      image: state.selectedImage!,
    );

    result.fold(
          (failure) {
        state = state.copyWith(
          status: HomeStatus.error,
          errorMessage: "فشل رفع الصورة، حاول مرة أخرى",
        );
      },
          (data) {
        final String? jobId = (data is Map) ? data['job_id']?.toString() : null;

        if (jobId == null || jobId.isEmpty) {
          state = state.copyWith(
            status: HomeStatus.error,
            errorMessage: "لم يتم استلام رقم العملية من السيرفر",
          );
          return;
        }

        state = state.copyWith(status: HomeStatus.analyzing, jobId: jobId);
        _startPolling(jobId);
      },
    );
  }

  void _startPolling(String jobId) {
    _pollingTimer?.cancel();
    _pollingTimer = null;
    _pollAttempts = 0;
    _pollingTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      _checkResult(jobId);
    });
  }

  Future<void> _checkResult(String jobId) async {
    if (state.jobId != jobId) {
      _pollingTimer?.cancel();
      return;
    }

    _pollAttempts++;
    if (_pollAttempts > _maxPollAttempts) {
      _pollingTimer?.cancel();
      if (state.jobId == jobId) {
        state = state.copyWith(
          status: HomeStatus.error,
          errorMessage: "استغرق التحليل وقتاً أطول من المتوقع. حاول رفع الصورة مرة أخرى.",
        );
      }
      return;
    }

    final result = await ref.read(homeDataProvider).checkResult(jobId);

    if (state.jobId != jobId) return;

    result.fold(
          (failure) {
        debugPrint("Check result failed, retrying in 10s...");
      },
          (response) {
        final dynamic rawBody = response.data ?? response;
        if (rawBody is! Map) return;

        final jobStatus = LabJobStatus.fromJson(Map<String, dynamic>.from(rawBody));

        if (jobStatus.isFailed) {
          _pollingTimer?.cancel();
          state = state.copyWith(
            status: HomeStatus.error,
            errorMessage: "فشل تحليل الصورة بالسيرفر",
          );
          return;
        }

        if (jobStatus.isDone && jobStatus.result != null) {
          _pollingTimer?.cancel();
          state = state.copyWith(
            status: HomeStatus.ready,
            analysisResult: jobStatus.result,
          );
        }
      },
    );
  }

  void goToResults() {
    _pollingTimer?.cancel();
    state = const HomeState();
  }

  // ═══════════════════════════════════════════════════════════
  // ✅ جديد: منطق تحليل تقرير محدد جوا قائمة "كل التحاليل"
  // (بدون الانتقال لصفحة تانية — كل شي بنفس البطاقة)
  // ═══════════════════════════════════════════════════════════

  /// يفتح/يسكّر عرض نتائج تقرير محدد بنفس البطاقة
  void toggleReportExpanded(String reportId) {
    final updated = Set<String>.from(state.expandedReportIds);
    if (updated.contains(reportId)) {
      updated.remove(reportId);
    } else {
      updated.add(reportId);
    }
    state = state.copyWith(expandedReportIds: updated);
  }

  void _updateReportAnalysis(String reportId, ReportAnalysisState newState) {
    final updated = Map<String, ReportAnalysisState>.from(state.reportAnalysis);
    updated[reportId] = newState;
    state = state.copyWith(reportAnalysis: updated);
  }

  /// ينزّل صورة التقرير من السيرفر لملف مؤقت محلي (نفس منطق ReportDetailsScreen سابقاً)
  Future<File?> _downloadImageToTempFile(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final tempDir =
        await Directory.systemTemp.createTemp('lab_report_analyze_');
        final file = File('${tempDir.path}/report_image.jpg');
        await file.writeAsBytes(response.bodyBytes);
        return file;
      }
    } catch (e, st) {
      debugPrint("Download report image error: $e");
      debugPrint("STACK: $st");
    }
    return null;
  }

  /// ✅ يبدأ تحليل تقرير محدد من القائمة: تنزيل الصورة → رفعها → polling
  Future<void> analyzeReportInList(LabReportItem report) async {
    final imageUrl = report.fullImageUrl;
    if (imageUrl == null) return;

    final reportId = report.reportId;

    _updateReportAnalysis(
      reportId,
      const ReportAnalysisState(status: ReportAnalysisStatus.downloading),
    );

    final file = await _downloadImageToTempFile(imageUrl);

    if (file == null) {
      _updateReportAnalysis(
        reportId,
        const ReportAnalysisState(
          status: ReportAnalysisStatus.error,
          errorMessage: "تعذر تحميل صورة التقرير، حاول مرة أخرى",
        ),
      );
      return;
    }

    _updateReportAnalysis(
      reportId,
      const ReportAnalysisState(status: ReportAnalysisStatus.uploading),
    );

    final result = await ref.read(homeDataProvider).postData(image: file);

    result.fold(
          (failure) {
        _updateReportAnalysis(
          reportId,
          const ReportAnalysisState(
            status: ReportAnalysisStatus.error,
            errorMessage: "فشل رفع الصورة، حاول مرة أخرى",
          ),
        );
      },
          (data) {
        final String? jobId = (data is Map) ? data['job_id']?.toString() : null;

        if (jobId == null || jobId.isEmpty) {
          _updateReportAnalysis(
            reportId,
            const ReportAnalysisState(
              status: ReportAnalysisStatus.error,
              errorMessage: "لم يتم استلام رقم العملية من السيرفر",
            ),
          );
          return;
        }

        _updateReportAnalysis(
          reportId,
          ReportAnalysisState(status: ReportAnalysisStatus.analyzing, jobId: jobId),
        );
        _startReportPolling(reportId, jobId);
      },
    );
  }

  void _startReportPolling(String reportId, String jobId) {
    _reportPollingTimers[reportId]?.cancel();
    _reportPollAttempts[reportId] = 0;
    _reportPollingTimers[reportId] =
        Timer.periodic(const Duration(seconds: 10), (timer) {
          _checkReportResult(reportId, jobId);
        });
  }

  Future<void> _checkReportResult(String reportId, String jobId) async {
    // ─── حماية من Race Condition (نفس منطق الـ polling الرئيسي) ───
    final current = state.reportAnalysis[reportId];
    if (current == null || current.jobId != jobId) {
      _reportPollingTimers[reportId]?.cancel();
      _reportPollingTimers.remove(reportId);
      return;
    }

    final attempts = (_reportPollAttempts[reportId] ?? 0) + 1;
    _reportPollAttempts[reportId] = attempts;

    if (attempts > _maxPollAttempts) {
      _reportPollingTimers[reportId]?.cancel();
      _reportPollingTimers.remove(reportId);
      _updateReportAnalysis(
        reportId,
        const ReportAnalysisState(
          status: ReportAnalysisStatus.error,
          errorMessage: "استغرق التحليل وقتاً أطول من المتوقع. حاول مرة أخرى.",
        ),
      );
      return;
    }

    final result = await ref.read(homeDataProvider).checkResult(jobId);

    // ✅ تحقق بعد الـ await كمان
    final latest = state.reportAnalysis[reportId];
    if (latest == null || latest.jobId != jobId) return;

    result.fold(
          (failure) {
        debugPrint("Check result failed for report $reportId, retrying...");
      },
          (response) {
        final dynamic rawBody = response.data ?? response;
        if (rawBody is! Map) return;

        final jobStatus = LabJobStatus.fromJson(Map<String, dynamic>.from(rawBody));

        if (jobStatus.isFailed) {
          _reportPollingTimers[reportId]?.cancel();
          _reportPollingTimers.remove(reportId);
          _updateReportAnalysis(
            reportId,
            const ReportAnalysisState(
              status: ReportAnalysisStatus.error,
              errorMessage: "فشل تحليل الصورة بالسيرفر",
            ),
          );
          return;
        }

        if (jobStatus.isDone && jobStatus.result != null) {
          _reportPollingTimers[reportId]?.cancel();
          _reportPollingTimers.remove(reportId);
          _reportPollAttempts.remove(reportId);

          // ✅ حدّث التقرير المطابق بالقائمة: صار محلل + خزّن النتيجة
          final updatedReports = state.reports.map((r) {
            if (r.reportId != reportId) return r;
            return r.copyWith(isAnalyzed: true, aiResult: jobStatus.result);
          }).toList();



          // ######################
          /// todo // تعديل 2 كلاود
          // ######################
          // ✅ فتح البطاقة تلقائياً لعرض النتائج فور جهوزيتها
          // final newExpanded = Set<String>.from(state.expandedReportIds)
          //   ..add(reportId);

          // state = state.copyWith(
          //   reports: updatedReports,
          //   expandedReportIds: newExpanded,
          // );

          // ######################
          /// todo // تعديل 2 كلاود
          // ######################


          state = state.copyWith(
            reports: updatedReports,
            // expandedReportIds: newExpanded,  ← احذف هاد السطر كمان
          );
          _updateReportAnalysis(
            reportId,
            const ReportAnalysisState(status: ReportAnalysisStatus.ready),
          );
        }
      },
    );
  }

  // ─── جلب كل التقارير (تستخدمها AllReportsPage) ───
  Future<void> fetchAllReports({bool forceRefresh = false}) async {
    if (!forceRefresh &&
        state.reportsStatus == ReportsListStatus.loaded &&
        state.reports.isNotEmpty) {
      return;
    }

    if (state.reportsStatus == ReportsListStatus.loading) return;

    state = state.copyWith(
      reportsStatus: ReportsListStatus.loading,
      clearReportsError: true,
    );

    final result = await ref.read(homeDataProvider).getAllReports();

    result.fold(
          (failure) {
        state = state.copyWith(
          reportsStatus: ReportsListStatus.error,
          reportsErrorMessage: "تعذر تحميل التقارير، تأكد من الاتصال",
        );
      },
          (response) {
        final dynamic rawBody = response.data ?? response;
        if (rawBody is! Map) {
          state = state.copyWith(
            reportsStatus: ReportsListStatus.error,
            reportsErrorMessage: "شكل البيانات القادمة من السيرفر غير متوقع",
          );
          return;
        }

        final parsed =
        LabReportsResponse.fromJson(Map<String, dynamic>.from(rawBody));

        state = state.copyWith(
          reportsStatus: ReportsListStatus.loaded,
          reports: parsed.results,
        );
      },
    );
  }
}