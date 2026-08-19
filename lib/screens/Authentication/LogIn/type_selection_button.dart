import 'package:ai_lab/core/constant/app_color.dart';
import 'package:flutter/material.dart';
//
// class TypeSelectionButton extends StatelessWidget {
//   final String text;
//   final IconData icon;
//   final bool isSelected;
//   final VoidCallback onTap;
//
//   const TypeSelectionButton({
//     super.key,
//     required this.text,
//     required this.icon,
//     required this.isSelected,
//     required this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: GestureDetector(
//         onTap: onTap,
//         child: Container(
//           padding: const EdgeInsets.symmetric(vertical: 14),
//           decoration: BoxDecoration(
//             color: isSelected ? AppMyColor.blueColor:  AppMyColor.darkCharcoal ,
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(
//                 icon,
//                 color: isSelected ?AppMyColor.blackApp  : AppMyColor.whiteApp,
//                 size: 20,
//               ),
//               const SizedBox(width: 8),
//               Text(
//                 text,
//                 style: TextStyle(
//                   color: isSelected ? AppMyColor.blackApp : AppMyColor.whiteApp,
//                   fontWeight: FontWeight.w600,
//                   fontSize: 15,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


class TypeSelectionButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final bool isSelected;
  final VoidCallback? onTap;   // ← صارت nullable

  const TypeSelectionButton({
    super.key,
    required this.text,
    required this.icon,
    required this.isSelected,
    this.onTap,                // ← شلت required
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,          // GestureDetector يقبل null بدون مشاكل
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: isSelected ? AppMyColor.blueColor : AppMyColor.darkCharcoal,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isSelected ? AppMyColor.blackApp : AppMyColor.whiteApp,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                text,
                style: TextStyle(
                  color: isSelected ? AppMyColor.blackApp : AppMyColor.whiteApp,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}