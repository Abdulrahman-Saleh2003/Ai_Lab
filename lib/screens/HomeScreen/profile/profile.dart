import 'dart:ui' as ui;
import 'package:ai_lab/controller/Profile/profile_provider.dart';
import 'package:ai_lab/controller/Profile/profile_state.dart';
import 'package:ai_lab/core/constant/app_size.dart';
import 'package:ai_lab/core/providers/app_providers.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class PatientProfilePage extends ConsumerStatefulWidget {
  const PatientProfilePage({super.key});

  @override
  ConsumerState<PatientProfilePage> createState() => _PatientProfilePageState();
}

class _PatientProfilePageState extends ConsumerState<PatientProfilePage> {
  static const _bg = Color(0xFF111317);
  static const _surface = Color(0xFF1A1C1F);
  static const _surfaceHighest = Color(0xFF2E3238);
  static const _onSurface = Color(0xFFE2E2E6);
  static const _onSurfaceVar = Color(0xFFBBC9CF);
  static const _primary = Color(0xFF00D2FF);
  static const _onPrimary = Color(0xFF003543);
  static const _secondary = Color(0xFFEDB1FF);
  static const _error = Color(0xFFFFB4AB);
  static const _outlineVar = Color(0xFF3C494E);

  bool _aiNotificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    final scale = AppSize.scale(context);
    final profileState = ref.watch(profileProvider);
    final profile = profileState.profile;

    final isDark = ref.watch(themeProvider) == ThemeMode.dark;
    final isEnglish = ref.watch(localeProvider).languageCode == 'en';

    return Scaffold(
      backgroundColor: _bg,
      extendBody: true,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.fromLTRB(
          20 * scale,
          60 * scale,
          20 * scale,
          120 * scale,
        ),
        child: Column(
          children: [
            _buildProfileHeader(context, scale, profile),
            SizedBox(height: 24 * scale),
            _buildInfoGrid(context, profile, scale),
            SizedBox(height: 28 * scale),
            _buildAiEngineStatusCard(context, scale),
            SizedBox(height: 24 * scale),
            _buildSettingsSection(
              context,
              ref,
              scale: scale,
              isDark: isDark,
              isEnglish: isEnglish,
            ),
            SizedBox(height: 24 * scale),
            _buildSecurityAndInfoSection(context, scale),
            SizedBox(height: 28 * scale),
            _buildLogoutButton(context, ref, scale),
            SizedBox(height: 16 * scale),
            _buildAppVersionFooter(scale),
          ],
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────
  // 1. PROFILE HEADER
  // ─────────────────────────────────────────────────────────────
  Widget _buildProfileHeader(
      BuildContext context, double scale, PatientProfile profile) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            // Ambient Aura Glow
            Container(
              width: 140 * scale,
              height: 140 * scale,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: _primary.withValues(alpha: 0.25),
                    blurRadius: 36,
                    spreadRadius: 2,
                  ),
                  BoxShadow(
                    color: _secondary.withValues(alpha: 0.15),
                    blurRadius: 48,
                    spreadRadius: 4,
                  ),
                ],
              ),
            ),
            // Glowing Gradient Border
            Container(
              width: 126 * scale,
              height: 126 * scale,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [_primary, _secondary, _primary],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              padding: const EdgeInsets.all(3.5),
              child: Container(
                decoration:
                    const BoxDecoration(shape: BoxShape.circle, color: _bg),
                padding: const EdgeInsets.all(3.5),
                child: ClipOval(
                  child: Image.network(
                    profile.avatarUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) => Container(
                      color: _surfaceHighest,
                      child: const Icon(
                        Icons.person_rounded,
                        size: 56,
                        color: _primary,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Edit Avatar Button
            Positioned(
              bottom: 2,
              right: (isRtl(context) ? null : 4),
              left: (isRtl(context) ? 4 : null),
              child: Container(
                width: 34 * scale,
                height: 34 * scale,
                decoration: BoxDecoration(
                  color: _primary,
                  shape: BoxShape.circle,
                  border: Border.all(color: _bg, width: 2.5),
                  boxShadow: [
                    BoxShadow(
                      color: _primary.withValues(alpha: 0.5),
                      blurRadius: 10,
                    )
                  ],
                ),
                child: const Icon(Icons.edit_rounded,
                    color: _onPrimary, size: 16),
              ),
            ),
          ],
        ),
        SizedBox(height: 16 * scale),
        // Patient Name & Verified Badge
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                profile.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 22 * scale,
                  fontWeight: FontWeight.bold,
                  color: _onSurface,
                  letterSpacing: 0.3,
                ),
              ),
            ),
            const SizedBox(width: 6),
            const Icon(Icons.verified_rounded, color: _primary, size: 20),
          ],
        ),
        SizedBox(height: 6 * scale),
        // Patient ID Chip with Copy Action
        GestureDetector(
          onTap: () {
            Clipboard.setData(ClipboardData(text: profile.patientId));
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    const Icon(Icons.check_circle_outline,
                        color: Colors.black, size: 18),
                    const SizedBox(width: 8),
                    Text(
                      "تم نسخ رقم المريض بنجاح",
                      style: const TextStyle(
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                backgroundColor: _primary,
                behavior: SnackBarBehavior.floating,
                duration: const Duration(seconds: 2),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            decoration: BoxDecoration(
              color: _surfaceHighest.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: _primary.withValues(alpha: 0.25)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${'patient_id'.tr()}: ${profile.patientId}',
                  style: const TextStyle(
                    fontFamily: 'SpaceGrotesk',
                    color: _primary,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(width: 6),
                const Icon(Icons.copy_rounded, color: _primary, size: 13),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ─────────────────────────────────────────────────────────────
  // 2. PATIENT INFO GRID (AGE, GENDER, EMAIL)
  // ─────────────────────────────────────────────────────────────
  Widget _buildInfoGrid(
      BuildContext context, PatientProfile profile, double scale) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _InfoTile(
                icon: Icons.calendar_today_rounded,
                iconColor: _primary,
                label: 'age'.tr(),
                value: profile.age,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _InfoTile(
                icon: Icons.person_outline_rounded,
                iconColor: _secondary,
                label: 'gender'.tr(),
                value: profile.gender,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _InfoTile(
          icon: Icons.alternate_email_rounded,
          iconColor: const Color(0xFF70FFB8),
          label: 'email_address'.tr(),
          value: profile.email,
          fullWidth: true,
        ),
      ],
    );
  }

  // ─────────────────────────────────────────────────────────────
  // 3. AI ENGINE STATUS CARD
  // ─────────────────────────────────────────────────────────────
  Widget _buildAiEngineStatusCard(BuildContext context, double scale) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF1E2833),
            _surface.withValues(alpha: 0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _primary.withValues(alpha: 0.25)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _primary.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.auto_awesome, color: _primary, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "AI Medical RAG Engine",
                  style: TextStyle(
                    fontFamily: 'SpaceGrotesk',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  "LLaMA 3 + OCR Vision Pipeline",
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 11.5,
                    color: _onSurfaceVar,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: const Color(0xFF00E676).withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                  color: const Color(0xFF00E676).withValues(alpha: 0.4)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 7,
                  height: 7,
                  decoration: const BoxDecoration(
                    color: Color(0xFF00E676),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                const Text(
                  "Active",
                  style: TextStyle(
                    fontFamily: 'SpaceGrotesk',
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF00E676),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────
  // 4. SETTINGS & PREFERENCES SECTION
  // ─────────────────────────────────────────────────────────────
  Widget _buildSettingsSection(
    BuildContext context,
    WidgetRef ref, {
    required double scale,
    required bool isDark,
    required bool isEnglish,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          child: Text(
            'account_preferences'.tr().toUpperCase(),
            style: const TextStyle(
              fontFamily: 'SpaceGrotesk',
              color: _onSurfaceVar,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 2,
            ),
          ),
        ),
        const SizedBox(height: 8),

        // Language Setting
        _buildSettingCard(
          icon: Icons.language_rounded,
          iconColor: _primary,
          title: 'change_language'.tr(),
          trailing: _buildSegmentedToggle(
            leftLabel: 'EN',
            rightLabel: 'AR',
            isLeftActive: isEnglish,
            onLeftTap: () {
              ref.read(localeProvider.notifier).setEnglish();
              context.setLocale(const Locale('en'));
            },
            onRightTap: () {
              ref.read(localeProvider.notifier).setArabic();
              context.setLocale(const Locale('ar'));
            },
          ),
        ),

        const SizedBox(height: 12),

        // Theme Setting
        _buildSettingCard(
          icon: Icons.dark_mode_outlined,
          iconColor: _secondary,
          title: 'switch_theme'.tr(),
          trailing: _buildSegmentedToggle(
            leftIcon: Icons.dark_mode_rounded,
            rightIcon: Icons.light_mode_rounded,
            isLeftActive: isDark,
            onLeftTap: () => ref.read(themeProvider.notifier).setDark(),
            onRightTap: () => ref.read(themeProvider.notifier).setLight(),
          ),
        ),

        const SizedBox(height: 12),

        // AI Notifications Setting
        _buildSettingCard(
          icon: Icons.notifications_active_outlined,
          iconColor: const Color(0xFFFFD54F),
          title: "تنبيهات اكتمال الفحص بالذكاء الاصطناعي",
          trailing: Switch.adaptive(
            value: _aiNotificationsEnabled,
            activeThumbColor: _primary,
            activeTrackColor: _primary.withValues(alpha: 0.3),
            inactiveThumbColor: _onSurfaceVar,
            inactiveTrackColor: _surfaceHighest,
            onChanged: (val) {
              setState(() {
                _aiNotificationsEnabled = val;
              });
            },
          ),
        ),
      ],
    );
  }

  // ─────────────────────────────────────────────────────────────
  // 5. SECURITY & INFO SECTION
  // ─────────────────────────────────────────────────────────────
  Widget _buildSecurityAndInfoSection(BuildContext context, double scale) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          child: Text(
            "الأمان والنظام".toUpperCase(),
            style: const TextStyle(
              fontFamily: 'SpaceGrotesk',
              color: _onSurfaceVar,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 2,
            ),
          ),
        ),
        const SizedBox(height: 8),
        _buildSettingCard(
          icon: Icons.shield_outlined,
          iconColor: _primary,
          title: 'security_privacy'.tr(),
          onTap: () {
            _showPrivacyDialog(context);
          },
          trailing: const Icon(Icons.chevron_right_rounded,
              color: _onSurfaceVar, size: 22),
        ),
        const SizedBox(height: 12),
        _buildSettingCard(
          icon: Icons.medical_information_outlined,
          iconColor: const Color(0xFF81D4FA),
          title: "إخلاء المسؤولية الطبية السريرية",
          onTap: () {
            _showDisclaimerDialog(context);
          },
          trailing: const Icon(Icons.chevron_right_rounded,
              color: _onSurfaceVar, size: 22),
        ),
      ],
    );
  }

  // ─────────────────────────────────────────────────────────────
  // 6. LOGOUT BUTTON WITH CONFIRMATION
  // ─────────────────────────────────────────────────────────────
  Widget _buildLogoutButton(
      BuildContext context, WidgetRef ref, double scale) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: _error.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _error.withValues(alpha: 0.25)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => _confirmLogout(context, ref),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.logout_rounded, color: _error, size: 20),
                const SizedBox(width: 10),
                Text(
                  'log_out'.tr(),
                  style: const TextStyle(
                    fontFamily: 'Cairo',
                    color: _error,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────
  // 7. FOOTER VERSION
  // ─────────────────────────────────────────────────────────────
  Widget _buildAppVersionFooter(double scale) {
    return Column(
      children: [
        Text(
          "AI Lab Diagnostics Platform",
          style: TextStyle(
            fontFamily: 'SpaceGrotesk',
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: _onSurfaceVar.withValues(alpha: 0.7),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          "Version 1.0.0 (Build 90) • All Rights Reserved",
          style: TextStyle(
            fontFamily: 'SpaceGrotesk',
            fontSize: 10.5,
            color: _outlineVar,
          ),
        ),
      ],
    );
  }

  // ─────────────────────────────────────────────────────────────
  // HELPER WIDGETS
  // ─────────────────────────────────────────────────────────────
  Widget _buildSettingCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required Widget trailing,
    VoidCallback? onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: _surface.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _outlineVar.withValues(alpha: 0.4)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: iconColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: iconColor, size: 20),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontFamily: 'Cairo',
                      color: _onSurface,
                      fontWeight: FontWeight.w600,
                      fontSize: 13.5,
                    ),
                  ),
                ),
                trailing,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSegmentedToggle({
    String? leftLabel,
    String? rightLabel,
    IconData? leftIcon,
    IconData? rightIcon,
    required bool isLeftActive,
    required VoidCallback onLeftTap,
    required VoidCallback onRightTap,
  }) {
    return Container(
      padding: const EdgeInsets.all(3.5),
      decoration: BoxDecoration(
        color: _surfaceHighest,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _segmentItem(
            label: leftLabel,
            icon: leftIcon,
            isActive: isLeftActive,
            onTap: onLeftTap,
          ),
          _segmentItem(
            label: rightLabel,
            icon: rightIcon,
            isActive: !isLeftActive,
            onTap: onRightTap,
          ),
        ],
      ),
    );
  }

  Widget _segmentItem({
    String? label,
    IconData? icon,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: isActive ? _primary : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: _primary.withValues(alpha: 0.35),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Center(
          child: icon != null
              ? Icon(
                  icon,
                  size: 16,
                  color: isActive ? _onPrimary : _onSurfaceVar,
                )
              : Text(
                  label ?? '',
                  style: TextStyle(
                    fontFamily: 'SpaceGrotesk',
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: isActive ? _onPrimary : _onSurfaceVar,
                  ),
                ),
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────
  // DIALOGS
  // ─────────────────────────────────────────────────────────────
  void _confirmLogout(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: _surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: _outlineVar),
        ),
        title: Row(
          children: [
            const Icon(Icons.logout_rounded, color: _error, size: 22),
            const SizedBox(width: 8),
            Text(
              'log_out'.tr(),
              style: const TextStyle(
                fontFamily: 'Cairo',
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ],
        ),
        content: const Text(
          "هل أنت متأكد من رغبتك في تسجيل الخروج من حسابك؟",
          style: TextStyle(
            fontFamily: 'Cairo',
            color: _onSurfaceVar,
            fontSize: 13.5,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text(
              "إلغاء",
              style: TextStyle(fontFamily: 'Cairo', color: _onSurfaceVar),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.of(ctx).pop();
              await ref.read(profileProvider.notifier).logout();
              if (context.mounted) {
                context.go('/login');
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: _error,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text(
              "تسجيل الخروج",
              style: TextStyle(
                fontFamily: 'Cairo',
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showPrivacyDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: _surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.shield_rounded, color: _primary, size: 24),
                const SizedBox(width: 10),
                const Text(
                  "الأمان والخصوصية الطبية",
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              "جميع بيانات تحاليلك الطبية وصورك الشخصية مشفرة بالكامل وتخضع لمعايير HIPAA و GDPR للسرية الطبية. لا تتم مشاركة نتائجك مع أي طرف ثالث دون إذن مسبق منك.",
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 13,
                height: 1.6,
                color: _onSurfaceVar,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.of(ctx).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primary,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text(
                  "حسناً، فهمت ذلك",
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDisclaimerDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: _surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.warning_amber_rounded,
                    color: Colors.amber, size: 24),
                const SizedBox(width: 10),
                const Text(
                  "إخلاء المسؤولية الطبية",
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              "هذا التطبيق هو أداة ذكاء اصطناعي مساعدة لتحليل ومقارنة التقارير المخبرية وليست بديلاً عن الاستشارة الطبية السريرية المباشرة من الطبيب المختص.",
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 13,
                height: 1.6,
                color: _onSurfaceVar,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.of(ctx).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primary,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text(
                  "إغلاق",
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool isRtl(BuildContext context) {
    return Directionality.of(context) == ui.TextDirection.rtl;
  }
}

// ─────────────────────────────────────────────────────────────
// INFO TILE
// ─────────────────────────────────────────────────────────────
class _InfoTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;
  final bool fullWidth;

  const _InfoTile({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
    this.fullWidth = false,
  });

  static const _surface = Color(0xFF1A1C1F);
  static const _onSurface = Color(0xFFE2E2E6);
  static const _onSurfaceVar = Color(0xFFBBC9CF);
  static const _outlineVar = Color(0xFF3C494E);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: fullWidth ? double.infinity : null,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _surface.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _outlineVar.withValues(alpha: 0.4)),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label.toUpperCase(),
                  style: const TextStyle(
                    fontFamily: 'Cairo',
                    color: _onSurfaceVar,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontFamily: 'Cairo',
                    color: _onSurface,
                    fontSize: 14.5,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
