import 'package:ai_lab/core/constant/app_color.dart';
import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
class CustomPhoneField extends StatelessWidget {
  final TextEditingController controller;
  final String selectedCountryCode;
  final Function(String code) onCountryChanged;
  final String? Function(String?)? validator;

  const CustomPhoneField({
    super.key,
    required this.controller,
    required this.selectedCountryCode,
    required this.onCountryChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Phone Number',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
            color: AppMyColor.whiteApp,
          ),
        ),
        const SizedBox(height: 8),

        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1E2023),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              CountryCodePicker(
                onChanged: (country) {
                  onCountryChanged(country.dialCode ?? '+966');
                },
                initialSelection: selectedCountryCode,
                favorite: const ['SA', 'EG', 'AE'],
                showCountryOnly: false,
                showOnlyCountryWhenClosed: false,
                alignLeft: false,
                textStyle: const TextStyle(color: AppMyColor.whiteApp),
                dialogTextStyle: const TextStyle(color: AppMyColor.whiteApp),
              ),

              Expanded(
                child: TextFormField(
                  controller: controller,
                  keyboardType: TextInputType.phone,
                  style: const TextStyle(color: AppMyColor.whiteApp),
                  validator: validator,
                  decoration: const InputDecoration(
                    hintText: '501234567',
                    hintStyle: TextStyle(color: AppMyColor.greyApp),
                    border: InputBorder.none,
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}