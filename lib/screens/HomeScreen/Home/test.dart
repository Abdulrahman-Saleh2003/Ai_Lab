// Widget _buildHeroSection() {
//   return Container(
//     padding: const EdgeInsets.all(20),
//     decoration: BoxDecoration(
//       gradient: const LinearGradient(
//         colors: [Color(0xFF1A1C1F), Color(0xFF0F1215)],
//       ),
//       borderRadius: BorderRadius.circular(24),
//       border: Border.all(color: const Color(0xFF00D2FF).withOpacity(0.15)),
//     ),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//           decoration: BoxDecoration(
//             color: const Color(0xFF00D2FF).withOpacity(0.1),
//             borderRadius: BorderRadius.circular(20),
//           ),
//           child: const Text(
//             "SYSTEM READY",
//             style: TextStyle(
//               fontSize: 11,
//               fontWeight: FontWeight.bold,
//               color: Color(0xFF00D2FF),
//               letterSpacing: 1,
//             ),
//           ),
//         ),
//         const SizedBox(height: 12),
//         const Text(
//           "Secure Lab\nData Processing",
//           style: TextStyle(
//             fontFamily: 'SpaceGrotesk',
//             fontSize: 26,
//             fontWeight: FontWeight.bold,
//             height: 1.1,
//             color: Colors.white,
//           ),
//         ),
//         const SizedBox(height: 8),
//         const Text(
//           "Instantly digitize your physical reports using our proprietary AI vision engine.",
//           style: TextStyle(
//             fontSize: 14,
//             color: Colors.grey,
//             height: 1.4,
//           ),
//         ),
//         const SizedBox(height: 20),
//         ElevatedButton.icon(
//           onPressed: () {},
//           icon: const Icon(Icons.add_circle, color: Colors.black),
//           label: const Text(
//             "UPLOAD NEW TEST",
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               color: Colors.black,
//             ),
//           ),
//           style: ElevatedButton.styleFrom(
//             backgroundColor: const Color(0xFF00D2FF),
//             padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(50),
//             ),
//           ),
//         ),
//         const SizedBox(height: 30),
//
//         // الصورة مع الـ Glow
//         Center(
//           child: Stack(
//             alignment: Alignment.center,
//             children: [
//               Container(
//                 width: MediaQuery.sizeOf(context).width,
//                 height: MediaQuery.sizeOf(context).height/4+100,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: const Color(0xFF00D2FF).withOpacity(0.12),
//                 ),
//               ),
//               Container(
//                 // width: 125,
//                 // height: 125,
//                 width: MediaQuery.sizeOf(context).width-100,
//                 height: MediaQuery.sizeOf(context).height/4,
//                 decoration: BoxDecoration(
//                   color: const Color(0xFF1E2023),
//                   borderRadius: BorderRadius.circular(24),
//                   border: Border.all(
//                     color: const Color(0xFF00D2FF).withOpacity(0.3),
//                   ),
//                 ),
//                 child: const Icon(
//                   Icons.biotech,
//                   size: 70,
//                   color: Color(0xFF00D2FF),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     ),
//   );
// }