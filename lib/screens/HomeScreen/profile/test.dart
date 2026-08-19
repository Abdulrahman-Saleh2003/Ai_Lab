//
//
// class PatientRegistrationScreen extends ConsumerWidget {
//   const PatientRegistrationScreen({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final state = ref.watch(patientRegistrationProvider);
//     final controller = ref.read(patientRegistrationProvider.notifier);
//
//     return Scaffold(
//       backgroundColor: const Color(0xFF111317),
//       body: Stack(
//         children: [
//           // Background Glows
//           Positioned(
//             top: -150,
//             right: -100,
//             child: Container(
//               width: 500,
//               height: 500,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 gradient: RadialGradient(
//                   colors: [const Color(0xFF00D2FF).withOpacity(0.12), Colors.transparent],
//                 ),
//               ),
//             ),
//           ),
//           Positioned(
//             bottom: -150,
//             left: -100,
//             child: Container(
//               width: 500,
//               height: 500,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 gradient: RadialGradient(
//                   colors: [const Color(0xFFEDB1FF).withOpacity(0.10), Colors.transparent],
//                 ),
//               ),
//             ),
//           ),
//
//           SafeArea(
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
//               child: Form(
//                 key: controller.formKey,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const RegistrationHeader(),
//                     const SizedBox(height: 40),
//
//                     const Text(
//                       "INITIALIZE",
//                       style: TextStyle(
//                         fontFamily: 'SpaceGrotesk',
//                         fontSize: 38,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                         letterSpacing: 1,
//                       ),
//                     ),
//                     const Text(
//                       "NODE",
//                       style: TextStyle(
//                         fontFamily: 'SpaceGrotesk',
//                         fontSize: 42,
//                         fontWeight: FontWeight.bold,
//                         color: Color(0xFF00D2FF),
//                         letterSpacing: 2,
//                       ),
//                     ),
//
//                     const SizedBox(height: 8),
//                     const Text(
//                       "Synchronize your biological profile with our distributed clinical laboratory network.",
//                       style: TextStyle(fontSize: 15, color: Colors.grey, height: 1.5),
//                     ),
//
//                     const SizedBox(height: 40),
//
//                     // Form Card
//                     Container(
//                       padding: const EdgeInsets.all(28),
//                       decoration: BoxDecoration(
//                         color: const Color(0xFF1A1C1F),
//                         borderRadius: BorderRadius.circular(24),
//                         border: Border.all(color: Colors.white.withOpacity(0.08)),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.4),
//                             blurRadius: 30,
//                             offset: const Offset(0, 10),
//                           ),
//                         ],
//                       ),
//                       child: Column(
//                         children: [
//                           CustomInputField(
//
//                             label: "Patient Phone Number",
//                             hint: "000-000-0000",
//                             icon: Icons.phone,
//                             inputType: InputType.phone,
//                             controller: controller.phoneController,
//                             selectedCountryCode: controller.countryCode,
//                             onCountryChanged: controller.changeCountryCode,
//                           ),
//
//                           const SizedBox(height: 24),
//
//                           CustomInputField(
//                             label: "Patient Email",
//                             hint: "synapse@labsync.io",
//                             icon: Icons.email_outlined,
//                             inputType: InputType.email,
//                             controller: controller.emailController,
//                             validator: (value) => value?.isEmpty == true ? 'Email is required' : null,
//                           ),
//
//                           const SizedBox(height: 24),
//
//                           CustomInputField(
//                             label: "National ID",
//                             hint: "ID-XXXX-XXXX",
//                             icon: Icons.badge_outlined,
//                             inputType: InputType.nationalId,
//                             controller: controller.nationalIdController,
//                           ),
//
//                           const SizedBox(height: 24),
//
//                           CustomInputField(
//                             label: "Access Cipher",
//                             hint: "••••••••••••",
//                             icon: Icons.lock_outline,
//                             inputType: InputType.password,
//                             controller: controller.passwordController,
//                             // isPassword: true,
//                             isPasswordVisible: controller.isPasswordVisible,
//                             onTogglePassword: controller.togglePasswordVisibility,
//                             validator: (value) {
//                               if (value == null || value.isEmpty) return 'Password is required';
//                               if (value.length < 6) return 'Minimum 6 characters';
//                               return null;
//                             },
//                           ),
//
//                           const SizedBox(height: 24),
//
//                           GenderSelectionField(
//                             selectedGender: state.selectedGender,
//                             onChanged: controller.changeGender,
//                           ),
//
//                           const SizedBox(height: 32),
//
//                           WeightSlider(
//                             weight: state.weight,
//                             onChanged: controller.changeWeight,
//                           ),
//
//                           const SizedBox(height: 40),
//
//                           InitializeButton(
//                             // onPressed: () => controller.register(context),
//                             onPressed: () => controller.goToHome(context),
//                             isLoading: state.isLoading,
//                           ),
//                           const SizedBox(height: 20),
//                           LoginRedirectText(
//                             // onTap: () => context.go('/login'),
//
//                           ),
//
//
//
//                         ],
//                       ),
//                     ),
//
//                     const SizedBox(height: 40),
//
//                     Center(
//                       child: RichText(
//                         text: const TextSpan(
//                           style: TextStyle(fontSize: 14, color: Colors.grey),
//                           children: [
//                             TextSpan(text: "Existing node detected? "),
//                             TextSpan(
//                               text: "Access Terminal",
//                               style: TextStyle(
//                                 color: Color(0xFFEDB1FF),
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
