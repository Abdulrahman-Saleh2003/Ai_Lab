import 'package:flutter/material.dart';

class WeightSlider extends StatelessWidget {
  final double weight;
  final Function(double) onChanged;

  const WeightSlider({
    super.key,
    required this.weight,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final scale = size.width / 375;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 🏷️ Label
        Text(
          "Biological Weight (kg)",
          style: TextStyle(
            fontSize: 12 * scale,
            color: Colors.white,
            letterSpacing: 1 * scale,
          ),
        ),

        SizedBox(height: 12 * scale),

        Row(
          children: [
            // 🎚️ Slider
            Expanded(
              child: Slider(
                value: weight,
                min: 30,
                max: 300,
                activeColor: const Color(0xFF00D2FF),
                inactiveColor: Colors.grey.withOpacity(0.3),
                onChanged: onChanged,
              ),
            ),

            SizedBox(width: 12 * scale),

            // 📦 Value Box
            Container(
              width: 70 * scale,
              padding: EdgeInsets.symmetric(
                vertical: 8 * scale,
                horizontal: 12 * scale,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFF1E2023),
                borderRadius: BorderRadius.circular(12 * scale),
              ),

              child: Text(
                "${weight.toStringAsFixed(1)} kg",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14 * scale,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF00D2FF),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}


// import 'package:flutter/material.dart';
//
// class WeightSlider extends StatelessWidget {
//   final double weight;
//   final Function(double) onChanged;
//
//   const WeightSlider({
//     super.key,
//     required this.weight,
//     required this.onChanged,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           "Biological Weight (kg)",
//           style: TextStyle(
//             fontSize: 12,
//             color: Colors.grey,
//             letterSpacing: 1,
//           ),
//         ),
//         const SizedBox(height: 12),
//         Row(
//           children: [
//             Expanded(
//               child: Slider(
//                 value: weight,
//                 min: 30,
//                 max: 300,
//                 activeColor: const Color(0xFF00D2FF),
//                 inactiveColor: Colors.grey.withOpacity(0.3),
//                 onChanged: onChanged,   // تمرير الدالة مباشرة
//               ),
//             ),
//             Container(
//               width: 70,
//               padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
//               decoration: BoxDecoration(
//                 color: const Color(0xFF1E2023),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Text(
//                 "${weight.toStringAsFixed(1)} kg",
//                 style: const TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                   color: Color(0xFF00D2FF),
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }