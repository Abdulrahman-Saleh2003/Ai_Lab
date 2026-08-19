import 'package:ai_lab/OnBoarding/View/widget.dart';
import 'package:ai_lab/core/constant/app_color.dart';



class BuildLiveFeedCard extends StatelessWidget {
  const BuildLiveFeedCard({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.height < 680; // للشاشات الصغيرة

    return Container(
      decoration: BoxDecoration(
        color: AppMyColor.charcoalBlack,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: AppMyColor.blueColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'LIVE LABORATORY FEED',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: isSmallScreen ? 11 : 12,
                            letterSpacing: 2,
                            color: Colors.white,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'CAM_042',
                  style: TextStyle(
                    color: AppMyColor.blueColor,
                    fontSize: isSmallScreen ? 11 : 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          // Image Area
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(16)),
              child: Stack(
                children: [
                  Image.asset(
                    AppImageAsset.onboarding,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[900],
                        child: const Center(
                          child: Icon(Icons.image_not_supported,
                              color: Colors.grey, size: 50),
                        ),
                      );
                    },
                  ),

                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black54],
                      ),
                    ),
                  ),

                  // Overlay Data - أكثر مرونة
                  Positioned(
                    top: isSmallScreen ? 12 : 16,
                    left: isSmallScreen ? 12 : 16,
                    right: isSmallScreen ? 12 : 16, // مهم جداً
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BuildScanOverlay(
                          icon: Icons.qr_code_2,
                          title: 'Scanning Vial',
                          value: '#VX-992-04',
                          color: AppMyColor.blueColor,
                        ),
                        const SizedBox(height: 12),
                        BuildScanOverlay(
                          icon: Icons.biotech,
                          title: 'Molecular Integrity',
                          value: '99.84%',
                          color: AppMyColor.lightLavenderPinkColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
//
// class BuildLiveFeedCard extends StatelessWidget {
//   const BuildLiveFeedCard({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return       Container(
//       decoration: BoxDecoration(
//         color: const Color(0xFF1A1C1F),
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: Colors.white.withOpacity(0.05)),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: Row(
//               children: [
//                 // Live Indicator + Title
//                 Expanded(
//                   child: Row(
//                     children: [
//                       Container(
//                         width: 8,
//                         height: 8,
//                         decoration:  BoxDecoration(
//
//                           // color: Color(0xFF00D2FF),
//                           color: AppMyColor.blueColor,
//
//                           shape: BoxShape.circle,
//                         ),
//                       ),
//                       const SizedBox(width: 8),
//                       const Expanded(
//                         child: Text(
//                           'LIVE LABORATORY FEED',
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 12,
//                             letterSpacing: 2,
//                             color: Colors.white
//
//                           ),
//                           overflow: TextOverflow.ellipsis,   // ← مهم
//                           maxLines: 1,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//
//                 // Camera Info
//                 const SizedBox(width: 12),
//                 Text(
//                   'CAM_042',
//                   style: TextStyle(
//                     color: AppMyColor.blueColor,
//
//                     fontSize: 12,
//                     // color: Colors.grey[400],
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//
//           // Image Area
//           Expanded(
//             child: ClipRRect(
//               borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
//               child: Stack(
//                 children: [
//                   Image.asset(
//                     AppImageAsset.onboarding,
//                     fit: BoxFit.cover,
//                     width: double.infinity,
//                     height: double.infinity,
//                     errorBuilder: (context, error, stackTrace) {
//                       return Container(
//                         color: Colors.grey[900],
//                         child: const Center(
//                           child: Icon(Icons.image_not_supported, color: Colors.grey, size: 50),
//                         ),
//                       );
//                     },
//                   ),
//                   Container(
//                     decoration: const BoxDecoration(
//                       gradient: LinearGradient(
//                         begin: Alignment.topCenter,
//                         end: Alignment.bottomCenter,
//                         colors: [Colors.transparent, Colors.black54],
//                       ),
//                     ),
//                   ),
//                   // Overlay Data
//                   Positioned(
//                     top: 16,
//                     left: 16,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         BuildScanOverlay
//                         (
//                           icon: Icons.qr_code_2,
//                           title: 'Scanning Vial',
//                           value: '#VX-992-04',
//                           color: AppMyColor.blueColor,
//
//                           // color: const Color(0xFF00D2FF),
//                         ),
//                         const SizedBox(height: 12),
//                         BuildScanOverlay(
//                           icon: Icons.biotech,
//                           title: 'Molecular Integrity',
//                           value: '99.84%',
//                           color: AppMyColor.lightLavenderPinkColor,
//
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//
//   }
// }
