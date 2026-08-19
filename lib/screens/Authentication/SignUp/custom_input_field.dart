// import 'package:country_code_picker/country_code_picker.dart';
// import 'package:flutter/material.dart';
//
// enum InputType { email, phone, text, nationalId, password }
//
// class CustomInputField extends StatelessWidget {
//   final String label;
//   final String hint;
//   final IconData? icon;
//   final InputType inputType;
//   final TextEditingController controller;
//   final String? Function(String?)? validator;
//   final String? selectedCountryCode;
//   final Function(String)? onCountryChanged;
//   final bool isPasswordVisible;
//   final VoidCallback? onTogglePassword;
//
//   const CustomInputField({
//     super.key,
//     required this.label,
//     required this.hint,
//     this.icon,
//     this.inputType = InputType.text,
//     required this.controller,
//     this.validator,
//     this.selectedCountryCode,
//     this.onCountryChanged,
//     this.isPasswordVisible = false,
//     this.onTogglePassword,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: const TextStyle(
//             fontSize: 12,
//             fontWeight: FontWeight.w600,
//             letterSpacing: 1,
//             color: Colors.white,
//           ),
//         ),
//         const SizedBox(height: 8),
//
//         Container(
//           decoration: BoxDecoration(
//             color: const Color(0xFF1E2023),
//             borderRadius: BorderRadius.circular(16),
//           ),
//           child: inputType == InputType.phone
//               // ? _buildPhoneInput()
//               // : _buildNormalInput(),
//
//
//               ? PhoneInputField(
//     controller: controller,
//     selectedCountryCode: selectedCountryCode ?? '+966',
//     onCountryChanged: onCountryChanged ?? (_) {},
//     validator: validator,
//     )
//         : NormalInputField(
//     hint: hint,
//     icon: icon,
//     isPassword: inputType == InputType.password,
//     isPasswordVisible: isPasswordVisible,
//     onTogglePassword: onTogglePassword,
//     controller: controller,
//     validator: validator,
//     keyboardType: _getKeyboardType(inputType),
//     ),
//         ),
//       ],
//     );
//   }
//
//
//   TextInputType _getKeyboardType(InputType type) {
//     switch (type) {
//       case InputType.email:
//         return TextInputType.emailAddress;
//       case InputType.phone:
//         return TextInputType.phone;
//       default:
//         return TextInputType.text;
//     }}}
//
//
//
// class PhoneInputField extends StatelessWidget {
//   final TextEditingController controller;
//   final String selectedCountryCode;
//   final Function(String) onCountryChanged;
//   final String? Function(String?)? validator;
//
//   const PhoneInputField({
//     super.key,
//     required this.controller,
//     required this.selectedCountryCode,
//     required this.onCountryChanged,
//     this.validator,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         CountryCodePicker(
//           onChanged: (country) {
//             onCountryChanged(country.dialCode ?? '+966');
//           },
//           initialSelection: selectedCountryCode,
//           favorite: const ['SA', 'EG', 'AE', 'US'],
//           showCountryOnly: false,
//           showOnlyCountryWhenClosed: false,
//           alignLeft: false,
//           textStyle: const TextStyle(color: Colors.white),
//           dialogTextStyle: const TextStyle(color: Colors.white),
//         ),
//         Expanded(
//           child: TextFormField(
//             controller: controller,
//             keyboardType: TextInputType.phone,
//             style: const TextStyle(color: Colors.white),
//             validator: validator,
//             decoration: const InputDecoration(
//               hintText: '501234567',
//               hintStyle: TextStyle(color: Colors.grey),
//               border: InputBorder.none,
//               contentPadding: EdgeInsets.symmetric(vertical: 16),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
// class NormalInputField extends StatelessWidget {
//   final String hint;
//   final IconData? icon;
//   final bool isPassword;
//   final bool isPasswordVisible;
//   final VoidCallback? onTogglePassword;
//   final TextEditingController controller;
//   final String? Function(String?)? validator;
//   final TextInputType? keyboardType;
//
//   const NormalInputField({
//     super.key,
//     required this.hint,
//     this.icon,
//     this.isPassword = false,
//     this.isPasswordVisible = false,
//     this.onTogglePassword,
//     required this.controller,
//     this.validator,
//     this.keyboardType,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       controller: controller,
//       obscureText: isPassword && !isPasswordVisible,
//       keyboardType: keyboardType,
//       style: const TextStyle(color: Colors.white),
//       validator: validator,
//       decoration: InputDecoration(
//         hintText: hint,
//         hintStyle: const TextStyle(color: Colors.grey),
//         prefixIcon: icon != null ? Icon(icon, color: Colors.grey) : null,
//         suffixIcon: isPassword
//             ? IconButton(
//           icon: Icon(
//             isPasswordVisible ? Icons.visibility : Icons.visibility_off,
//             color: Colors.grey,
//           ),
//           onPressed: onTogglePassword,
//         )
//             : null,
//         border: InputBorder.none,
//         contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
//       ),
//     );
//   }
// }

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';

enum InputType { email, phone, text, nationalId, password }

class CustomInputField extends StatelessWidget {
  final String label;
  final String hint;
  final IconData? icon;
  final InputType inputType;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String? selectedCountryCode;
  final Function(String)? onCountryChanged;
  final bool isPasswordVisible;
  final VoidCallback? onTogglePassword;

  const CustomInputField({
    super.key,
    required this.label,
    required this.hint,
    this.icon,
    this.inputType = InputType.text,
    required this.controller,
    this.validator,
    this.selectedCountryCode,
    this.onCountryChanged,
    this.isPasswordVisible = false,
    this.onTogglePassword,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final scale = size.width / 375;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12 * scale,
            fontWeight: FontWeight.w600,
            letterSpacing: 1 * scale,
            color: Colors.white,
          ),
        ),

        SizedBox(height: 8 * scale),

        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1E2023),
            borderRadius: BorderRadius.circular(16 * scale),
          ),

          child: inputType == InputType.phone
              ? PhoneInputField(
            controller: controller,
            selectedCountryCode: selectedCountryCode ?? '+966',
            onCountryChanged: onCountryChanged ?? (_) {},
            validator: validator,
          )
              : NormalInputField(
            hint: hint,
            icon: icon,
            isPassword: inputType == InputType.password,
            isPasswordVisible: isPasswordVisible,
            onTogglePassword: onTogglePassword,
            controller: controller,
            validator: validator,
            keyboardType: _getKeyboardType(inputType),
          ),
        ),
      ],
    );
  }

  TextInputType _getKeyboardType(InputType type) {
    switch (type) {
      case InputType.email:
        return TextInputType.emailAddress;
      case InputType.phone:
        return TextInputType.phone;
      default:
        return TextInputType.text;
    }
  }
}

class PhoneInputField extends StatelessWidget {
  final TextEditingController controller;
  final String selectedCountryCode;
  final Function(String) onCountryChanged;
  final String? Function(String?)? validator;

  const PhoneInputField({
    super.key,
    required this.controller,
    required this.selectedCountryCode,
    required this.onCountryChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final scale = size.width / 375;

    return Row(
      children: [
        CountryCodePicker(
          onChanged: (country) {
            onCountryChanged(country.dialCode ?? '+966');
          },
          initialSelection: selectedCountryCode,
          favorite: const ['SA', 'EG', 'AE', 'US'],
          showCountryOnly: false,
          showOnlyCountryWhenClosed: false,
          alignLeft: false,
          textStyle: TextStyle(
            color: Colors.white,
            fontSize: 14 * scale,
          ),
          dialogTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 14 * scale,
          ),
        ),

        Expanded(
          child: TextFormField(
            controller: controller,
            keyboardType: TextInputType.phone,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14 * scale,
            ),
            validator: validator,
            decoration: InputDecoration(
              hintText: '501234567',
              hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: 14 * scale,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                vertical: 16 * scale,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class NormalInputField extends StatelessWidget {
  final String hint;
  final IconData? icon;
  final bool isPassword;
  final bool isPasswordVisible;
  final VoidCallback? onTogglePassword;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;

  const NormalInputField({
    super.key,
    required this.hint,
    this.icon,
    this.isPassword = false,
    this.isPasswordVisible = false,
    this.onTogglePassword,
    required this.controller,
    this.validator,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final scale = size.width / 375;

    return TextFormField(
      controller: controller,
      obscureText: isPassword && !isPasswordVisible,
      keyboardType: keyboardType,
      style: TextStyle(
        color: Colors.white,
        fontSize: 14 * scale,
      ),
      validator: validator,

      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 14 * scale,
        ),

        prefixIcon: icon != null
            ? Icon(icon, color: Colors.grey, size: 20 * scale)
            : null,

        suffixIcon: isPassword
            ? IconButton(
          icon: Icon(
            isPasswordVisible
                ? Icons.visibility
                : Icons.visibility_off,
            color: Colors.grey,
            size: 20 * scale,
          ),
          onPressed: onTogglePassword,
        )
            : null,

        border: InputBorder.none,

        contentPadding: EdgeInsets.symmetric(
          vertical: 18 * scale,
          horizontal: 16 * scale,
        ),
      ),
    );
  }
}