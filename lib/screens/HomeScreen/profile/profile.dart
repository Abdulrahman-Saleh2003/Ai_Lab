import 'package:ai_lab/controller/Profile/profile_provider.dart';
import 'package:ai_lab/controller/Profile/profile_state.dart';
import 'package:ai_lab/core/constant/app_size.dart';
import 'package:ai_lab/core/providers/app_providers.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class PatientProfilePage extends ConsumerWidget {
  const PatientProfilePage({super.key});

  static const _bg = Color(0xFF111317);
  static const _surface = Color(0xFF1A1C1F);
  static const _surfaceHighest = Color(0xFF333538);
  static const _onSurface = Color(0xFFE2E2E6);
  static const _onSurfaceVar = Color(0xFFBBC9CF);
  static const _primary = Color(0xFF00D2FF);
  static const _onPrimary = Color(0xFF003543);
  static const _secondary = Color(0xFFEDB1FF);
  static const _error = Color(0xFFFFB4AB);
  static const _outline = Color(0xFF859399);
  static const _outlineVar = Color(0xFF3C494E);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scale = AppSize.scale(context);
    final profileState = ref.watch(profileProvider);
    final profile = profileState.profile;

    final isDark = ref.watch(themeProvider) == ThemeMode.dark;
    final isEnglish = ref.watch(localeProvider).languageCode == 'en';

    return Scaffold(
      backgroundColor: _bg,
      extendBody: true,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(
          20 * scale,
          80 * scale,
          20 * scale,
          120 * scale,
        ),
        child: Column(
          children: [
            _buildProfileHeader(scale, profile),
            SizedBox(height: 32 * scale),
            _buildInfoGrid(profile),
            SizedBox(height: 32 * scale),
            _buildSettingsSection(
              context,
              ref,
              scale: scale,
              isDark: isDark,
              isEnglish: isEnglish,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(double scale, PatientProfile profile) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: 132 * scale.clamp(0.9, 1.2),
              height: 132 * scale.clamp(0.9, 1.2),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [_primary, _secondary, _primary],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              padding: const EdgeInsets.all(3),
              child: Container(
                decoration: const BoxDecoration(shape: BoxShape.circle, color: _bg),
                padding: const EdgeInsets.all(3),
                child: ClipOval(
                  child: Image.network(
                    profile.avatarUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) => const Icon(
                      Icons.person,
                      size: 60,
                      color: _primary,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 4,
              right: 4,
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  width: 36 * scale,
                  height: 36 * scale,
                  decoration: BoxDecoration(
                    color: _primary,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: _primary.withValues(alpha: 0.4),
                        blurRadius: 10,
                      )
                    ],
                  ),
                  child: const Icon(Icons.edit, color: _onPrimary, size: 18),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 20 * scale),
        Text(
          profile.name,
          style: TextStyle(
            fontSize: 28 * scale.clamp(0.9, 1.15),
            fontWeight: FontWeight.w700,
            color: _onSurface,
          ),
        ),
        SizedBox(height: 4 * scale),
        Text(
          '${'patient_id'.tr()}: ${profile.patientId}',
          style: TextStyle(
            color: _onSurfaceVar,
            fontSize: 14 * scale.clamp(0.9, 1.1),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoGrid(PatientProfile profile) {
    return Column(
      children: [
        _InfoCard(
          icon: Icons.calendar_today_outlined,
          iconColor: _primary,
          label: 'age'.tr(),
          value: profile.age,
        ),
        const SizedBox(height: 12),
        _InfoCard(
          icon: Icons.person_pin_outlined,
          iconColor: _secondary,
          label: 'gender'.tr(),
          value: profile.gender,
        ),
        const SizedBox(height: 12),
        _InfoCard(
          icon: Icons.alternate_email_rounded,
          iconColor: _primary,
          label: 'email_address'.tr(),
          value: profile.email,
          fullWidth: true,
        ),
      ],
    );
  }

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
          padding: const EdgeInsets.only(left: 4, bottom: 16),
          child: Text(
            'account_preferences'.tr().toUpperCase(),
            style: const TextStyle(
              color: _onSurfaceVar,
              fontSize: 11,
              fontWeight: FontWeight.w600,
              letterSpacing: 2.5,
            ),
          ),
        ),

        // Language
        _buildGlassCard(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    const Icon(Icons.language_outlined, color: _primary),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        'change_language'.tr(),
                        style: const TextStyle(
                          color: _onSurface,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              _buildToggleButtons(
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
            ],
          ),
        ),

        const SizedBox(height: 12),

        // Theme
        _buildGlassCard(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    const Icon(Icons.contrast_outlined, color: _secondary),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        'switch_theme'.tr(),
                        style: const TextStyle(
                          color: _onSurface,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              _buildToggleButtons(
                leftIcon: Icons.dark_mode,
                rightIcon: Icons.light_mode_outlined,
                isLeftActive: isDark,
                onLeftTap: () => ref.read(themeProvider.notifier).setDark(),
                onRightTap: () => ref.read(themeProvider.notifier).setLight(),
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),

        _buildGlassCard(
          onTap: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    const Icon(Icons.lock_person_outlined, color: _onSurfaceVar),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        'security_privacy'.tr(),
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: _onSurface,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded, color: _outline),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // Logout Button
        TextButton(
          onPressed: () async {
            await ref.read(profileProvider.notifier).logout();
            if (context.mounted) {
              context.go('/login');
            }
          },
          style: TextButton.styleFrom(
            minimumSize: const Size(double.infinity, 56),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.logout_rounded, color: _error),
              const SizedBox(width: 8),
              Text(
                'log_out'.tr(),
                style: const TextStyle(
                  color: _error,
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGlassCard({required Widget child, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        decoration: BoxDecoration(
          color: _surface.withValues(alpha: 0.7),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _primary.withValues(alpha: 0.08)),
          boxShadow: [
            BoxShadow(
              color: _primary.withValues(alpha: 0.03),
              blurRadius: 20,
            )
          ],
        ),
        child: child,
      ),
    );
  }

  Widget _buildToggleButtons({
    String? leftLabel,
    String? rightLabel,
    IconData? leftIcon,
    IconData? rightIcon,
    required bool isLeftActive,
    required VoidCallback onLeftTap,
    required VoidCallback onRightTap,
  }) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: _surfaceHighest,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        children: [
          _toggleBtn(
            label: leftLabel,
            icon: leftIcon,
            isActive: isLeftActive,
            onTap: onLeftTap,
          ),
          _toggleBtn(
            label: rightLabel,
            icon: rightIcon,
            isActive: !isLeftActive,
            onTap: onRightTap,
          ),
        ],
      ),
    );
  }

  Widget _toggleBtn({
    String? label,
    IconData? icon,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 40,
        height: 32,
        decoration: BoxDecoration(
          color: isActive ? _primary : Colors.transparent,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(
          child: icon != null
              ? Icon(
                  icon,
                  size: 18,
                  color: isActive ? _onPrimary : _outlineVar,
                )
              : Text(
                  label ?? '',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: isActive ? _onPrimary : _outlineVar,
                  ),
                ),
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label, value;
  final bool fullWidth;

  const _InfoCard({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
    this.fullWidth = false,
  });

  static const _surface = Color(0xFF1A1C1F);
  static const _primary = Color(0xFF00D2FF);
  static const _onSurface = Color(0xFFE2E2E6);
  static const _onSurfaceVar = Color(0xFFBBC9CF);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: fullWidth ? double.infinity : null,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: _surface.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _primary.withValues(alpha: 0.08)),
        boxShadow: [
          BoxShadow(
            color: _primary.withValues(alpha: 0.04),
            blurRadius: 20,
          )
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label.toUpperCase(),
                  style: const TextStyle(
                    color: _onSurfaceVar,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    color: _onSurface,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
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
