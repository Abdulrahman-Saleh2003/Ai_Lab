import 'package:ai_lab/core/constant/app_color.dart';
import 'package:flutter/material.dart';







class BuildQueueItem extends StatelessWidget {
  const BuildQueueItem({
    super.key,
    required this.vialId,
    required this.test,
    required this.status,
    required this.isActive,
  });

  final String vialId;
  final String test;
  final String status;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.height < 680 || size.width < 360;

    return Container(
      padding: EdgeInsets.all(isSmallScreen ? 12 : 14),
      decoration: BoxDecoration(
        color: const Color(0xFF282A2D),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,   // ← هذا هو المفتاح
        children: [
          // Icon
          Container(
            width: isSmallScreen ? 42 : 48,
            height: isSmallScreen ? 42 : 48,
            decoration: BoxDecoration(
              color: isActive
                  ? const Color(0xFF00D2FF).withValues(alpha: 0.1)
                  : Colors.grey.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.inventory_2,
              color: isActive ? AppMyColor.blueColor : AppMyColor.whiteApp,
              size: isSmallScreen ? 22 : 26,
            ),
          ),
          const SizedBox(width: 12),

          // Text Content
          Expanded(
            child: Column(
              children: [
                Text(
                  'Vial ID: $vialId',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: isSmallScreen ? 11 : 12,
                    color: isActive ? AppMyColor.blueColor : AppMyColor.whiteApp,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                const SizedBox(height: 3),
                Text(
                  test,
                  style: TextStyle(
                    fontSize: isSmallScreen ? 10.5 : 10,
                    color:  AppMyColor.whiteApp,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          // Status Badge
          Flexible(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: isSmallScreen ? 8 : 10,
                vertical: isSmallScreen ? 4 : 5,
              ),
              decoration: BoxDecoration(
                color: isActive
                    ? const Color(0xFF00D2FF).withValues(alpha:0.2)
                    : Colors.grey.withValues(alpha:0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                status.toUpperCase(),
                style: TextStyle(
                  fontSize: isSmallScreen ? 9.5 : 10,
                  fontWeight: FontWeight.bold,
                  color: isActive ? AppMyColor.blueColor :  AppMyColor.whiteApp,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
// class BuildQueueItem extends StatelessWidget {
//   const BuildQueueItem({super.key, required this.vialId, required this.test, required this.status, required this.isActive});
//
//  final  String vialId;
//   final    String test;
//   final   String status;
//   final   bool isActive;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(14),
//       decoration: BoxDecoration(
//         color: const Color(0xFF282A2D),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Row(
//         children: [
//           // Icon
//           Container(
//             width: 48,
//             height: 48,
//             decoration: BoxDecoration(
//               color: isActive
//                   ? const Color(0xFF00D2FF).withValues(alpha: 0.1)
//                   : Colors.grey.withValues(alpha: 0.1),
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Icon(
//               Icons.inventory_2,
//               color: isActive ? AppMyColor.blueColor : AppMyColor.whiteApp,
//             ),
//           ),
//           const SizedBox(width: 12),
//
//           // Text Content - Expanded
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Vial ID: $vialId',
//                   style:  TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 14,
//                     color: isActive ?  AppMyColor.blueColor  :AppMyColor.whiteApp,
//                   ),
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 const SizedBox(height: 2),
//                 Text(
//                   test,
//                   style: TextStyle(
//                     fontSize: 12,
//                     color: Colors.white70,
//                   ),
//                   overflow: TextOverflow.ellipsis,
//                   maxLines: 1,
//                 ),
//               ],
//             ),
//           ),
//
//           const SizedBox(width: 8),
//
//           Flexible(
//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//               decoration: BoxDecoration(
//                 color: isActive
//                     ? const Color(0xFF00D2FF).withValues(alpha:0.2)
//                     : Colors.grey.withValues(alpha:0.2),
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Text(
//                 status.toUpperCase(),
//                 style: TextStyle(
//                   fontSize: 10,
//                   fontWeight: FontWeight.bold,
//                   color: isActive ? AppMyColor.blueColor  : Colors.grey,
//                 ),
//                 overflow: TextOverflow.ellipsis,
//                 maxLines: 1,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
