import 'package:ai_lab/core/constant/app_size.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class GenderSelectionField extends StatelessWidget {
  final String selectedGender;
  final Function(String) onChanged;

  const GenderSelectionField({
    super.key,
    required this.selectedGender,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final scale = AppSize.scale(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "gender_selection".tr(),
          style: TextStyle(
            fontSize: 12 * scale,
            color: Colors.grey,
            letterSpacing: 1 * scale,
          ),
        ),
        SizedBox(height: 8 * scale),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16 * scale),
          decoration: BoxDecoration(
            color: const Color(0xFF1E2023),
            borderRadius: BorderRadius.circular(16 * scale),
          ),
          child: DropdownButtonFormField<String>(
            initialValue: selectedGender,
            dropdownColor: const Color(0xFF1E2023),
            style: TextStyle(
              color: Colors.white,
              fontSize: 14 * scale,
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
            items: [
              DropdownMenuItem(
                value: "Male",
                child: Text(
                  "gender_male".tr(),
                  style: TextStyle(fontSize: 14 * scale),
                ),
              ),
              DropdownMenuItem(
                value: "Female",
                child: Text(
                  "gender_female".tr(),
                  style: TextStyle(fontSize: 14 * scale),
                ),
              ),
              DropdownMenuItem(
                value: "Non-binary",
                child: Text(
                  "gender_other".tr(),
                  style: TextStyle(fontSize: 14 * scale),
                ),
              ),
              DropdownMenuItem(
                value: "Decline to specify",
                child: Text(
                  "decline_to_specify".tr(),
                  style: TextStyle(fontSize: 14 * scale),
                ),
              ),
            ],
            onChanged: (value) {
              if (value != null) {
                onChanged(value);
              }
            },
          ),
        ),
      ],
    );
  }
}