// import 'package:flutter/material.dart';
//
// class BuildLegendItem extends StatelessWidget {
//   const BuildLegendItem({super.key, required this.color, required this.label});
//
//   final Color color;
//   final String label;
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Container(
//           width: 12,
//           height: 12,
//           decoration: BoxDecoration(
//             color: color,
//             borderRadius: BorderRadius.circular(3),
//           ),
//         ),
//         const SizedBox(width: 8),
//         Text(
//           label,
//           style: const TextStyle(fontSize: 13, color: Colors.grey),
//         ),
//       ],
//     );
//   }
// }
import 'package:flutter/material.dart';

class BuildLegendItem extends StatelessWidget {
  const BuildLegendItem({
    super.key,
    required this.color,
    required this.label,
  });

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    final scale = size.width / 375;

    return Row(
      children: [
        Container(
          width: 11 * scale,
          height: 11 * scale,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3 * scale),
          ),
        ),

        SizedBox(width: 4 * scale),

        Text(
          label,
          style: TextStyle(
            fontSize: 11 * scale,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}