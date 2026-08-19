// import 'package:flutter/material.dart';
//
// class GenderSelectionField extends StatelessWidget {
//   final String selectedGender;
//   final Function(String) onChanged;
//
//   const GenderSelectionField({
//     super.key,
//     required this.selectedGender,
//     required this.onChanged,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           "Gender Selection",
//           style: TextStyle(
//             fontSize: 12,
//             color: Colors.grey,
//             letterSpacing: 1,
//           ),
//         ),
//         const SizedBox(height: 8),
//         Container(
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           decoration: BoxDecoration(
//             color: const Color(0xFF1E2023),
//             borderRadius: BorderRadius.circular(16),
//           ),
//           child: DropdownButtonFormField<String>(
//             value: selectedGender,
//             dropdownColor: const Color(0xFF1E2023),
//             style: const TextStyle(color: Colors.white),
//             decoration: const InputDecoration(
//               border: InputBorder.none,
//             ),
//             items: const [
//               DropdownMenuItem(value: "Male", child: Text("Male")),
//               DropdownMenuItem(value: "Female", child: Text("Female")),
//               DropdownMenuItem(value: "Non-binary", child: Text("Non-binary")),
//               DropdownMenuItem(
//                 value: "Decline to specify",
//                 child: Text("Decline to specify"),
//               ),
//             ],
//             onChanged: (value) {
//               if (value != null) {
//                 onChanged(value);
//               }
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }

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
    final size = MediaQuery.sizeOf(context);
    final scale = size.width / 375;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Gender Selection",
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
            value: selectedGender,

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
                  "Male",
                  style: TextStyle(fontSize: 14 * scale),
                ),
              ),

              DropdownMenuItem(
                value: "Female",
                child: Text(
                  "Female",
                  style: TextStyle(fontSize: 14 * scale),
                ),
              ),

              DropdownMenuItem(
                value: "Non-binary",
                child: Text(
                  "Non-binary",
                  style: TextStyle(fontSize: 14 * scale),
                ),
              ),

              DropdownMenuItem(
                value: "Decline to specify",
                child: Text(
                  "Decline to specify",
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