// import 'package:flutter/material.dart';
//
//
// class PatientProfile {
//   final String name;
//   final String patientId;
//   final String age;
//   final String gender;
//   final String email;
//   final String avatarUrl;
//
//   const PatientProfile({
//     required this.name,
//     required this.patientId,
//     required this.age,
//     required this.gender,
//     required this.email,
//     required this.avatarUrl,
//   });
// }
//
//
// class PatientProfilePage extends StatefulWidget {
//   const PatientProfilePage({super.key});
//
//   @override
//   State<PatientProfilePage> createState() => _PatientProfilePageState();
// }
//
// class _PatientProfilePageState extends State<PatientProfilePage> {
//   // ── Design Tokens ──────────────────────────
//   static const _bg             = Color(0xFF111317);
//   static const _surface        = Color(0xFF1A1C1F);
//   static const _surfaceHigh    = Color(0xFF282A2D);
//   static const _surfaceHighest = Color(0xFF333538);
//   static const _onSurface      = Color(0xFFE2E2E6);
//   static const _onSurfaceVar   = Color(0xFFBBC9CF);
//   static const _primary        = Color(0xFF00D2FF);
//   static const _onPrimary      = Color(0xFF003543);
//   static const _secondary      = Color(0xFFEDB1FF);
//   static const _secondaryCont  = Color(0xFF6E208C);
//   static const _error          = Color(0xFFFFB4AB);
//   static const _errorCont      = Color(0xFF93000A);
//   static const _outline        = Color(0xFF859399);
//   static const _outlineVar     = Color(0xFF3C494E);
//
//   bool _isEnglish = true;
//   bool _isDark    = true;
//
//   // ── Sample Data ────────────────────────────
//   final PatientProfile _profile = const PatientProfile(
//     name: 'Ahmed Mohammed',
//     patientId: '#LS-8829-X',
//     age: '28 Years',
//     gender: 'Male',
//     email: 'ahmed.m@email.com',
//     avatarUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuChIah-LYn2BD2fZMC_hbGBuFcLVZ1MhJTUWSgcVuQzcANlG_L4WoZ7x7lTqqu4No6eeUOmMrFDD2GxEuynMjidAUKXR3dcraJuZ11NNUapjK2a1_QZio5Fsjs74BGr0CtHVGHZMaWLun7-bbkAcV4tO5sVFCP2IuLcSJAyT0tSYfV1v2tyksTwDIKUojrGTUX3ZoFHbHk39hmPc186lORIb4T5gVHCs2qksjyjK6WCI1AKlZJUiu_uqJvuErZ9pwQHO_cNtkWwMxl-',
//   );
//
//   // ── Build ──────────────────────────────────
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: _bg,
//       extendBody: true,
//       body: _buildBody(),
//     );
//   }
//
//   Widget _buildBody() {
//
//     return SingleChildScrollView(
//       padding: const EdgeInsets.fromLTRB(20, 80, 20, 120),
//       child: Column(
//         children: [
//           _buildProfileHeader(),
//           const SizedBox(height: 32),
//           _buildInfoGrid(),
//           const SizedBox(height: 32),
//           _buildSettingsSection(),
//         ],
//       ),
//     );
//   }
//
//   // ── Profile Header ─────────────────────────
//   Widget _buildProfileHeader() {
//     return Column(
//       children: [
//         Stack(
//           children: [
//             // Avatar with gradient ring
//             Container(
//               width: 132,
//               height: 132,
//               decoration: const BoxDecoration(
//                 shape: BoxShape.circle,
//                 gradient: LinearGradient(
//                   colors: [_primary, _secondary, _primary],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//               ),
//               padding: const EdgeInsets.all(3),
//               child: Container(
//                 decoration: const BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: _bg,
//                 ),
//                 padding: const EdgeInsets.all(3),
//                 child: ClipOval(
//                   child: Image.network(
//                     _profile.avatarUrl,
//                     fit: BoxFit.cover,
//                     errorBuilder: (_, __, ___) => const Icon(
//                       Icons.person,
//                       size: 60,
//                       color: _primary,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             // Edit button
//             Positioned(
//               bottom: 4,
//               right: 4,
//               child: GestureDetector(
//                 onTap: () {},
//                 child: Container(
//                   width: 36,
//                   height: 36,
//                   decoration: BoxDecoration(
//                     color: _primary,
//                     shape: BoxShape.circle,
//                     boxShadow: [
//                       BoxShadow(
//                         color: _primary.withValues(alpha: 0.4),
//                         blurRadius: 10,
//                       ),
//                     ],
//                   ),
//                   child: const Icon(Icons.edit, color: _onPrimary, size: 18),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 20),
//         Text(
//           _profile.name,
//           style: const TextStyle(
//             fontSize: 28,
//             fontWeight: FontWeight.w700,
//             color: _onSurface,
//           ),
//         ),
//         const SizedBox(height: 4),
//         Text(
//           'Patient ID: ${_profile.patientId}',
//           style: const TextStyle(
//             color: _onSurfaceVar,
//             fontSize: 14,
//             fontWeight: FontWeight.w500,
//             letterSpacing: 0.5,
//           ),
//         ),
//       ],
//     );
//   }
//
//   // ── Info Grid ──────────────────────────────
//   Widget _buildInfoGrid() {
//     return Column(
//       children: [
//         const SizedBox(height: 12),
//         _InfoCard(
//           icon: Icons.calendar_today_outlined,
//           iconColor: _primary,
//           label: 'Age',
//           value: _profile.age,
//         ),
//
//         const SizedBox(height: 12),
//         _InfoCard(
//           icon: Icons.person_pin_outlined,
//           iconColor: _secondary,
//           label: 'Gender',
//           value: _profile.gender,
//         ),
//         const SizedBox(height: 12),
//         _InfoCard(
//           icon: Icons.alternate_email_rounded,
//           iconColor: _primary,
//           label: 'Email Address',
//           value: _profile.email,
//           fullWidth: true,
//         ),
//       ],
//     );
//   }
//
//   // ── Settings Section ───────────────────────
//   Widget _buildSettingsSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Padding(
//           padding: EdgeInsets.only(left: 4, bottom: 16),
//           child: Text(
//             'ACCOUNT PREFERENCES',
//             style: TextStyle(
//               color: _onSurfaceVar,
//               fontSize: 11,
//               fontWeight: FontWeight.w600,
//               letterSpacing: 2.5,
//             ),
//           ),
//         ),
//
//         // Language Toggle
//         _buildGlassCard(
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 children: [
//                   const Icon(Icons.language_outlined, color: _primary),
//                   const SizedBox(width: 16),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: const [
//                       Text('Change Language',
//                           style: TextStyle(
//                               color: _onSurface, fontWeight: FontWeight.w700)),
//                       Text('تغيير اللغة',
//                           style:
//                           TextStyle(color: _onSurfaceVar, fontSize: 13)),
//                     ],
//                   ),
//                 ],
//               ),
//               _buildToggleButtons(
//                 leftLabel: 'EN',
//                 rightLabel: 'AR',
//                 isLeftActive: _isEnglish,
//                 onLeftTap: () => setState(() => _isEnglish = true),
//                 onRightTap: () => setState(() => _isEnglish = false),
//               ),
//             ],
//           ),
//         ),
//
//         const SizedBox(height: 12),
//
//         // Theme Toggle
//         _buildGlassCard(
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 children: [
//                   const Icon(Icons.contrast_outlined, color: _secondary),
//                   const SizedBox(width: 16),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: const [
//                       Text('Switch Theme',
//                           style: TextStyle(
//                               color: _onSurface, fontWeight: FontWeight.w700)),
//                       Text('تبديل الثيم',
//                           style:
//                           TextStyle(color: _onSurfaceVar, fontSize: 13)),
//                     ],
//                   ),
//                 ],
//               ),
//               _buildToggleButtons(
//                 leftIcon: Icons.dark_mode,
//                 rightIcon: Icons.light_mode_outlined,
//                 isLeftActive: _isDark,
//                 onLeftTap: () => setState(() => _isDark = true),
//                 onRightTap: () => setState(() => _isDark = false),
//               ),
//             ],
//           ),
//         ),
//
//         const SizedBox(height: 12),
//
//         // Security & Privacy
//         _buildGlassCard(
//           onTap: () {},
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: const [
//               Row(
//                 children: [
//                   Icon(Icons.lock_person_outlined, color: _onSurfaceVar),
//                   SizedBox(width: 16),
//                   Text('Security & Privacy',
//                       style: TextStyle(
//                           color: _onSurface, fontWeight: FontWeight.w700)),
//                 ],
//               ),
//               Icon(Icons.chevron_right_rounded, color: _outline),
//             ],
//           ),
//         ),
//
//         const SizedBox(height: 8),
//
//         // Logout
//         TextButton(
//           onPressed: () {},
//           style: TextButton.styleFrom(
//             minimumSize: const Size(double.infinity, 56),
//             shape:
//             RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: const [
//               Icon(Icons.logout_rounded, color: _error),
//               SizedBox(width: 8),
//               Text('Log Out',
//                   style: TextStyle(
//                       color: _error,
//                       fontWeight: FontWeight.w700,
//                       fontSize: 15)),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   // ── Glass Card Helper ──────────────────────
//   Widget _buildGlassCard({required Widget child, VoidCallback? onTap}) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
//         decoration: BoxDecoration(
//           color: _surface.withValues(alpha: 0.7),
//           borderRadius: BorderRadius.circular(16),
//           border: Border.all(
//             color: _primary.withValues(alpha: 0.08),
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: _primary.withValues(alpha: 0.03),
//               blurRadius: 20,
//             ),
//           ],
//         ),
//         child: child,
//       ),
//     );
//   }
//
//   // ── Toggle Buttons Helper ──────────────────
//   Widget _buildToggleButtons({
//     String? leftLabel,
//     String? rightLabel,
//     IconData? leftIcon,
//     IconData? rightIcon,
//     required bool isLeftActive,
//     required VoidCallback onLeftTap,
//     required VoidCallback onRightTap,
//   }) {
//     return Container(
//       padding: const EdgeInsets.all(4),
//       decoration: BoxDecoration(
//         color: _surfaceHighest,
//         borderRadius: BorderRadius.circular(50),
//       ),
//       child: Row(
//         children: [
//           _toggleBtn(
//             label: leftLabel,
//             icon: leftIcon,
//             isActive: isLeftActive,
//             onTap: onLeftTap,
//           ),
//           _toggleBtn(
//             label: rightLabel,
//             icon: rightIcon,
//             isActive: !isLeftActive,
//             onTap: onRightTap,
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _toggleBtn({
//     String? label,
//     IconData? icon,
//     required bool isActive,
//     required VoidCallback onTap,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 200),
//         width: 40,
//         height: 32,
//         decoration: BoxDecoration(
//           color: isActive ? _primary : Colors.transparent,
//           borderRadius: BorderRadius.circular(50),
//         ),
//         child: Center(
//           child: icon != null
//               ? Icon(icon,
//               size: 18, color: isActive ? _onPrimary : _outlineVar)
//               : Text(
//             label ?? '',
//             style: TextStyle(
//               fontSize: 10,
//               fontWeight: FontWeight.w800,
//               color: isActive ? _onPrimary : _outlineVar,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   // ── Bottom Nav ─────────────────────────────
// }
//
// // ─────────────────────────────────────────────
// //  INFO CARD WIDGET
// // ─────────────────────────────────────────────
// class _InfoCard extends StatelessWidget {
//   final IconData icon;
//   final Color iconColor;
//   final String label;
//   final String value;
//   final bool fullWidth;
//
//   const _InfoCard({
//     required this.icon,
//     required this.iconColor,
//     required this.label,
//     required this.value,
//     this.fullWidth = false,
//   });
//
//   static const _surface   = Color(0xFF1A1C1F);
//   static const _primary   = Color(0xFF00D2FF);
//   static const _onSurface = Color(0xFFE2E2E6);
//   static const _onSurfaceVar = Color(0xFFBBC9CF);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: fullWidth ? double.infinity : null,
//       padding: const EdgeInsets.all(18),
//       decoration: BoxDecoration(
//         color: _surface.withValues(alpha: 0.7),
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: _primary.withValues(alpha: 0.08)),
//         boxShadow: [
//           BoxShadow(
//             color: _primary.withValues(alpha: 0.04),
//             blurRadius: 20,
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           Container(
//             width: 48,
//             height: 48,
//             decoration: BoxDecoration(
//               color: iconColor.withValues(alpha: 0.10),
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Icon(icon, color: iconColor, size: 24),
//           ),
//           const SizedBox(width: 16),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   label.toUpperCase(),
//                   style: const TextStyle(
//                     color: _onSurfaceVar,
//                     fontSize: 10,
//                     fontWeight: FontWeight.w600,
//                     letterSpacing: 2,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   value,
//                   style: const TextStyle(
//                     color: _onSurface,
//                     fontSize: 18,
//                     fontWeight: FontWeight.w700,
//                   ),
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:ai_lab/core/providers/app_providers.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class PatientProfile {
  final String name, patientId, age, gender, email, avatarUrl;
  const PatientProfile({
    required this.name, required this.patientId, required this.age,
    required this.gender, required this.email, required this.avatarUrl,
  });
}

// ── ConsumerStatefulWidget ─────────────────────
class PatientProfilePage extends ConsumerStatefulWidget {
  const PatientProfilePage({super.key});
  @override
  ConsumerState<PatientProfilePage> createState() => _PatientProfilePageState();
}

class _PatientProfilePageState extends ConsumerState<PatientProfilePage> {
  static const _bg             = Color(0xFF111317);
  static const _surface        = Color(0xFF1A1C1F);
  static const _surfaceHighest = Color(0xFF333538);
  static const _onSurface      = Color(0xFFE2E2E6);
  static const _onSurfaceVar   = Color(0xFFBBC9CF);
  static const _primary        = Color(0xFF00D2FF);
  static const _onPrimary      = Color(0xFF003543);
  static const _secondary      = Color(0xFFEDB1FF);
  static const _error          = Color(0xFFFFB4AB);
  static const _outline        = Color(0xFF859399);
  static const _outlineVar     = Color(0xFF3C494E);

  final PatientProfile _profile =  PatientProfile(
    name: 'Ahmed Mohammed', patientId: '#LS-8829-X',
    age: '28 Years', gender: 'Male', email: 'ahmed.m@email.com',
    avatarUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuChIah-LYn2BD2fZMC_hbGBuFcLVZ1MhJTUWSgcVuQzcANlG_L4WoZ7x7lTqqu4No6eeUOmMrFDD2GxEuynMjidAUKXR3dcraJuZ11NNUapjK2a1_QZio5Fsjs74BGr0CtHVGHZMaWLun7-bbkAcV4tO5sVFCP2IuLcSJAyT0tSYfV1v2tyksTwDIKUojrGTUX3ZoFHbHk39hmPc186lORIb4T5gVHCs2qksjyjK6WCI1AKlZJUiu_uqJvuErZ9pwQHO_cNtkWwMxl-',
  );

  @override
  Widget build(BuildContext context) {
    // ✅ بنقرأ من Riverpod مباشرة
    final isDark    = ref.watch(themeProvider) == ThemeMode.dark;
    final isEnglish = ref.watch(localeProvider).languageCode == 'en';

    return Scaffold(
      backgroundColor: _bg,
      extendBody: true,
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 80, 20, 120),
        child: Column(children: [
          _buildProfileHeader(),
          const SizedBox(height: 32),
          _buildInfoGrid(),
          const SizedBox(height: 32),
          _buildSettingsSection(isDark: isDark, isEnglish: isEnglish),
        ]),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Column(children: [
      Stack(children: [
        Container(
          width: 132, height: 132,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [_primary, _secondary, _primary],
              begin: Alignment.topLeft, end: Alignment.bottomRight,
            ),
          ),
          padding: const EdgeInsets.all(3),
          child: Container(
            decoration: const BoxDecoration(shape: BoxShape.circle, color: _bg),
            padding: const EdgeInsets.all(3),
            child: ClipOval(
              child: Image.network(_profile.avatarUrl, fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                  const Icon(Icons.person, size: 60, color: _primary)),
            ),
          ),
        ),
        Positioned(
          bottom: 4, right: 4,
          child: GestureDetector(
            onTap: () {},
            child: Container(
              width: 36, height: 36,
              decoration: BoxDecoration(
                color: _primary, shape: BoxShape.circle,
                boxShadow: [BoxShadow(
                    color: _primary.withValues(alpha: 0.4), blurRadius: 10)],
              ),
              child: const Icon(Icons.edit, color: _onPrimary, size: 18),
            ),
          ),
        ),
      ]),
      const SizedBox(height: 20),
      Text(_profile.name,
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: _onSurface)),
      const SizedBox(height: 4),
      Text('Patient ID: ${_profile.patientId}',
          style: const TextStyle(color: _onSurfaceVar, fontSize: 14)),
    ]);
  }

  Widget _buildInfoGrid() {
    return Column(children: [
      _InfoCard(icon: Icons.calendar_today_outlined, iconColor: _primary,
          label: 'age'.tr(), value: _profile.age),
      const SizedBox(height: 12),
      _InfoCard(icon: Icons.person_pin_outlined, iconColor: _secondary,
          label: 'gender'.tr(), value: _profile.gender),
      const SizedBox(height: 12),
      _InfoCard(icon: Icons.alternate_email_rounded, iconColor: _primary,
          label: 'email_address'.tr(), value: _profile.email, fullWidth: true),
    ]);
  }

  Widget _buildSettingsSection({required bool isDark, required bool isEnglish}) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Padding(
        padding: EdgeInsets.only(left: 4, bottom: 16),
        child: Text('ACCOUNT PREFERENCES', style: TextStyle(
            color: _onSurfaceVar, fontSize: 11,
            fontWeight: FontWeight.w600, letterSpacing: 2.5)),
      ),

      // Language
      _buildGlassCard(child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Row(children: [
            Icon(Icons.language_outlined, color: _primary),
            SizedBox(width: 16),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Change Language', style: TextStyle(color: _onSurface, fontWeight: FontWeight.w700)),
              Text('تغيير اللغة', style: TextStyle(color: _onSurfaceVar, fontSize: 13)),
            ]),
          ]),


          // _buildToggleButtons(
          //   leftLabel: 'EN', rightLabel: 'AR',
          //   isLeftActive: isEnglish,
          //   // ✅ Riverpod
          //   onLeftTap:  () => ref.read(localeProvider.notifier).setEnglish(),
          //   onRightTap: () => ref.read(localeProvider.notifier).setArabic(),
          // ),

          // Language Toggle
          _buildToggleButtons(
            leftLabel: 'EN',
            rightLabel: 'AR',
            isLeftActive: isEnglish,

            // ✅ هون تضيف context.setLocale
            onLeftTap: () {
              ref.read(localeProvider.notifier).setEnglish();
              context.setLocale(const Locale('en')); // ← easy_localization
            },
            onRightTap: () {
              ref.read(localeProvider.notifier).setArabic();
              context.setLocale(const Locale('ar')); // ← easy_localization
            },
          ),
        ],
      )),

      const SizedBox(height: 12),

      // Theme
      _buildGlassCard(child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Row(children: [
            Icon(Icons.contrast_outlined, color: _secondary),
            SizedBox(width: 16),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Switch Theme', style: TextStyle(color: _onSurface, fontWeight: FontWeight.w700)),
              Text('تبديل الثيم', style: TextStyle(color: _onSurfaceVar, fontSize: 13)),
            ]),
          ]),
          _buildToggleButtons(
            leftIcon: Icons.dark_mode, rightIcon: Icons.light_mode_outlined,
            isLeftActive: isDark,
            // ✅ Riverpod
            onLeftTap:  () => ref.read(themeProvider.notifier).setDark(),
            onRightTap: () => ref.read(themeProvider.notifier).setLight(),
          ),
        ],
      )),

      const SizedBox(height: 12),

      _buildGlassCard(
        onTap: () {},
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(children: [
              Icon(Icons.lock_person_outlined, color: _onSurfaceVar),
              SizedBox(width: 16),
              Text('Security & Privacy',
                  style: TextStyle(color: _onSurface, fontWeight: FontWeight.w700)),
            ]),
            Icon(Icons.chevron_right_rounded, color: _outline),
          ],
        ),
      ),

      const SizedBox(height: 8),

      // ✅ Logout — Riverpod يمسح التوكن، GoRouter يحول تلقائياً
      TextButton(
        onPressed: () async {
          await ref.read(authProvider.notifier).logout();
          if (mounted) context.go('/login');
        },
        style: TextButton.styleFrom(
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(Icons.logout_rounded, color: _error),
          SizedBox(width: 8),
          Text('Log Out', style: TextStyle(color: _error, fontWeight: FontWeight.w700, fontSize: 15)),
        ]),
      ),
    ]);
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
          boxShadow: [BoxShadow(color: _primary.withValues(alpha: 0.03), blurRadius: 20)],
        ),
        child: child,
      ),
    );
  }

  Widget _buildToggleButtons({
    String? leftLabel, String? rightLabel,
    IconData? leftIcon, IconData? rightIcon,
    required bool isLeftActive,
    required VoidCallback onLeftTap, required VoidCallback onRightTap,
  }) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(color: _surfaceHighest, borderRadius: BorderRadius.circular(50)),
      child: Row(children: [
        _toggleBtn(label: leftLabel,  icon: leftIcon,  isActive: isLeftActive,  onTap: onLeftTap),
        _toggleBtn(label: rightLabel, icon: rightIcon, isActive: !isLeftActive, onTap: onRightTap),
      ]),
    );
  }

  Widget _toggleBtn({String? label, IconData? icon, required bool isActive, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 40, height: 32,
        decoration: BoxDecoration(
          color: isActive ? _primary : Colors.transparent,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(
          child: icon != null
              ? Icon(icon, size: 18, color: isActive ? _onPrimary : _outlineVar)
              : Text(label ?? '', style: TextStyle(
              fontSize: 10, fontWeight: FontWeight.w800,
              color: isActive ? _onPrimary : _outlineVar)),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
class _InfoCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label, value;
  final bool fullWidth;

  const _InfoCard({
    required this.icon, required this.iconColor,
    required this.label, required this.value, this.fullWidth = false,
  });

  static const _surface      = Color(0xFF1A1C1F);
  static const _primary      = Color(0xFF00D2FF);
  static const _onSurface    = Color(0xFFE2E2E6);
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
        boxShadow: [BoxShadow(color: _primary.withValues(alpha: 0.04), blurRadius: 20)],
      ),
      child: Row(children: [
        Container(
          width: 48, height: 48,
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: iconColor, size: 24),
        ),
        const SizedBox(width: 16),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(label.toUpperCase(), style: const TextStyle(
              color: _onSurfaceVar, fontSize: 10,
              fontWeight: FontWeight.w600, letterSpacing: 2)),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(
              color: _onSurface, fontSize: 18, fontWeight: FontWeight.w700),
              overflow: TextOverflow.ellipsis),
        ])),
      ]),
    );
  }
}
