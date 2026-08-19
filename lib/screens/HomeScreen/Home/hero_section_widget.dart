// import 'package:flutter/material.dart';
//
// class HeroSectionWidget extends StatelessWidget {
//   final VoidCallback? onUploadPressed;
//
//   const HeroSectionWidget({
//     super.key,
//     this.onUploadPressed,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.sizeOf(context);
//     final scale = size.width / 375;
//
//     return Container(
//       padding: EdgeInsets.all(20 * scale.clamp(0.9, 1.2)),
//       decoration: BoxDecoration(
//         gradient: const LinearGradient(
//           colors: [Color(0xFF1A1C1F), Color(0xFF0F1215)],
//         ),
//         borderRadius: BorderRadius.circular(24),
//         border: Border.all(
//           color: const Color(0xFF00D2FF).withValues(alpha:0.15),
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // System Ready Tag
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//             decoration: BoxDecoration(
//               color: const Color(0xFF00D2FF).withValues(alpha:0.1),
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: const Text(
//               "SYSTEM READY",
//               style: TextStyle(
//                 fontSize: 11,
//                 fontWeight: FontWeight.bold,
//                 color: Color(0xFF00D2FF),
//                 letterSpacing: 1,
//               ),
//             ),
//           ),
//
//           const SizedBox(height: 12),
//
//           // Main Title
//           Text(
//             "Secure Lab\nData Processing",
//             style: TextStyle(
//               fontFamily: 'SpaceGrotesk',
//               fontSize: 26 * scale.clamp(0.85, 1.15),
//               fontWeight: FontWeight.bold,
//               height: 1.1,
//               color: Colors.white,
//             ),
//           ),
//
//           const SizedBox(height: 8),
//
//           // Description
//           Text(
//             "Instantly digitize your physical reports using our proprietary AI vision engine.",
//             style: TextStyle(
//               fontSize: 14 * scale.clamp(0.9, 1.1),
//               color: Colors.grey,
//               height: 1.4,
//             ),
//           ),
//
//           const SizedBox(height: 24),
//
//           // Upload Button
//           SizedBox(
//             width: double.infinity,
//             child: ElevatedButton.icon(
//               onPressed: onUploadPressed,
//               icon: const Icon(Icons.add_circle, color: Colors.black),
//               label: const Text(
//                 "UPLOAD NEW TEST",
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                 ),
//               ),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFF00D2FF),
//                 padding: EdgeInsets.symmetric(
//                   horizontal: 24 * scale,
//                   vertical: 16 * scale.clamp(0.9, 1.2),
//                 ),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(50),
//                 ),
//               ),
//             ),
//           ),
//
//           const SizedBox(height: 32),
//
//           // Visual Section with Glow
//           Center(
//             child: Stack(
//               alignment: Alignment.center,
//               children: [
//                 // Glow Effect
//                 Container(
//                   width: 160 * scale.clamp(0.9, 1.3),
//                   height: 160 * scale.clamp(0.9, 1.3),
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: const Color(0xFF00D2FF).withValues(alpha:0.12),
//                   ),
//                 ),
//                 // Main Box
//                 Container(
//                   width: size.width - 100,
//                   height: 160 * scale.clamp(0.8, 1.2),
//                   decoration: BoxDecoration(
//                     color: const Color(0xFF1E2023),
//                     borderRadius: BorderRadius.circular(24),
//                     border: Border.all(
//                       color: const Color(0xFF00D2FF).withValues(alpha:0.3),
//                     ),
//                   ),
//                   child: const Icon(
//                     Icons.biotech,
//                     size: 72,
//                     color: Color(0xFF00D2FF),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }





// #########################

//todo
// import 'dart:io';
// import 'package:flutter/material.dart';
//
// class HeroSectionWidget extends StatelessWidget {
//   final File? selectedImage;
//   final bool isLoading;
//   final VoidCallback? onPickImagePressed; // يفتح bottom sheet كاميرا/معرض
//   final VoidCallback? onAnalyzePressed;
//   final VoidCallback? onRemoveImagePressed;
//
//   const HeroSectionWidget({
//     super.key,
//     this.selectedImage,
//     this.isLoading = false,
//     this.onPickImagePressed,
//     this.onAnalyzePressed,
//     this.onRemoveImagePressed,
//   });
//
//   bool get _hasImage => selectedImage != null;
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.sizeOf(context);
//     final scale = size.width / 375;
//
//     return Container(
//       padding: EdgeInsets.all(20 * scale.clamp(0.9, 1.2)),
//       decoration: BoxDecoration(
//         gradient: const LinearGradient(
//           colors: [Color(0xFF1A1C1F), Color(0xFF0F1215)],
//         ),
//         borderRadius: BorderRadius.circular(24),
//         border: Border.all(
//           color: const Color(0xFF00D2FF).withValues(alpha: 0.15),
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // System Ready Tag
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//             decoration: BoxDecoration(
//               color: const Color(0xFF00D2FF).withValues(alpha: 0.1),
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: Text(
//               _hasImage ? "IMAGE READY" : "SYSTEM READY",
//               style: const TextStyle(
//                 fontSize: 11,
//                 fontWeight: FontWeight.bold,
//                 color: Color(0xFF00D2FF),
//                 letterSpacing: 1,
//               ),
//             ),
//           ),
//
//           const SizedBox(height: 12),
//
//           // Main Title
//           Text(
//             "Secure Lab\nData Processing",
//             style: TextStyle(
//               fontFamily: 'SpaceGrotesk',
//               fontSize: 26 * scale.clamp(0.85, 1.15),
//               fontWeight: FontWeight.bold,
//               height: 1.1,
//               color: Colors.white,
//             ),
//           ),
//
//           const SizedBox(height: 8),
//
//           // Description
//           Text(
//             _hasImage
//                 ? "Report image selected. Run the AI vision engine to extract your results."
//                 : "Instantly digitize your physical reports using our proprietary AI vision engine.",
//             style: TextStyle(
//               fontSize: 14 * scale.clamp(0.9, 1.1),
//               color: Colors.grey,
//               height: 1.4,
//             ),
//           ),
//
//           const SizedBox(height: 24),
//
//           // ─── زر واحد بس ظاهر حسب الحالة ───
//           if (!_hasImage)
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton.icon(
//                 onPressed: isLoading ? null : onPickImagePressed,
//                 icon: const Icon(Icons.add_circle, color: Colors.black),
//                 label: const Text(
//                   "UPLOAD NEW TEST",
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black,
//                   ),
//                 ),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFF00D2FF),
//                   padding: EdgeInsets.symmetric(
//                     horizontal: 24 * scale,
//                     vertical: 16 * scale.clamp(0.9, 1.2),
//                   ),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(50),
//                   ),
//                 ),
//               ),
//             )
//           else ...[
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton.icon(
//                 onPressed: isLoading ? null : onAnalyzePressed,
//                 icon: isLoading
//                     ? const SizedBox(
//                   width: 18,
//                   height: 18,
//                   child: CircularProgressIndicator(
//                     strokeWidth: 2,
//                     color: Colors.black,
//                   ),
//                 )
//                     : const Icon(Icons.auto_awesome, color: Colors.black),
//                 label: Text(
//                   isLoading ? "ANALYZING..." : "ANALYZE IMAGE",
//                   style: const TextStyle(
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black,
//                   ),
//                 ),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFF00D2FF),
//                   padding: EdgeInsets.symmetric(
//                     horizontal: 24 * scale,
//                     vertical: 16 * scale.clamp(0.9, 1.2),
//                   ),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(50),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 10 * scale),
//             SizedBox(
//               width: double.infinity,
//               child: TextButton.icon(
//                 onPressed: isLoading ? null : onRemoveImagePressed,
//                 icon: const Icon(Icons.close, color: Colors.grey, size: 18),
//                 label: const Text(
//                   "Remove & choose another",
//                   style: TextStyle(color: Colors.grey),
//                 ),
//               ),
//             ),
//           ],
//
//           const SizedBox(height: 32),
//
//           // ─── معاينة الصورة المختارة أو الأيقونة الافتراضية ───
//           Center(
//             child: Stack(
//               alignment: Alignment.center,
//               children: [
//                 Container(
//                   width: 160 * scale.clamp(0.9, 1.3),
//                   height: 160 * scale.clamp(0.9, 1.3),
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: const Color(0xFF00D2FF).withValues(alpha: 0.12),
//                   ),
//                 ),
//                 Container(
//                   width: size.width - 100,
//                   height: 160 * scale.clamp(0.8, 1.2),
//                   clipBehavior: Clip.antiAlias,
//                   decoration: BoxDecoration(
//                     color: const Color(0xFF1E2023),
//                     borderRadius: BorderRadius.circular(24),
//                     border: Border.all(
//                       color: const Color(0xFF00D2FF).withValues(alpha: 0.3),
//                     ),
//                   ),
//                   child: _hasImage
//                       ? Image.file(selectedImage!, fit: BoxFit.cover)
//                       : const Icon(
//                     Icons.biotech,
//                     size: 72,
//                     color: Color(0xFF00D2FF),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:io';
import 'package:flutter/material.dart';

enum HeroButtonState { upload, readyToAnalyze, uploading, analyzing, resultsReady }

class HeroSectionWidget extends StatelessWidget {
  final File? selectedImage;
  final HeroButtonState buttonState;
  final VoidCallback? onPickImagePressed;   // يفتح bottom sheet كاميرا/معرض
  final VoidCallback? onAnalyzePressed;     // يبدأ رفع الصورة
  final VoidCallback? onRemoveImagePressed; // يلغي الصورة المختارة
  final VoidCallback? onViewResultsPressed; // "اذهب لمشاهدة النتائج"

  const HeroSectionWidget({
    super.key,
    this.selectedImage,
    this.buttonState = HeroButtonState.upload,
    this.onPickImagePressed,
    this.onAnalyzePressed,
    this.onRemoveImagePressed,
    this.onViewResultsPressed,
  });

  bool get _hasImage => selectedImage != null;
  bool get _isBusy =>
      buttonState == HeroButtonState.uploading ||
          buttonState == HeroButtonState.analyzing;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final scale = size.width / 375;

    return Container(
      padding: EdgeInsets.all(20 * scale.clamp(0.9, 1.2)),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1A1C1F), Color(0xFF0F1215)],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFF00D2FF).withValues(alpha: 0.15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tag أعلى الكرت
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFF00D2FF).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              _tagText,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: Color(0xFF00D2FF),
                letterSpacing: 1,
              ),
            ),
          ),

          const SizedBox(height: 12),

          Text(
            "Secure Lab\nData Processing",
            style: TextStyle(
              fontFamily: 'SpaceGrotesk',
              fontSize: 26 * scale.clamp(0.85, 1.15),
              fontWeight: FontWeight.bold,
              height: 1.1,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            _descriptionText,
            style: TextStyle(
              fontSize: 14 * scale.clamp(0.9, 1.1),
              color: Colors.grey,
              height: 1.4,
            ),
          ),

          const SizedBox(height: 24),

          _buildActionArea(scale),

          const SizedBox(height: 32),

          // معاينة الصورة
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 160 * scale.clamp(0.9, 1.3),
                  height: 160 * scale.clamp(0.9, 1.3),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF00D2FF).withValues(alpha: 0.12),
                  ),
                ),
                Container(
                  width: size.width - 100,
                  height: 160 * scale.clamp(0.8, 1.2),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E2023),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: const Color(0xFF00D2FF).withValues(alpha: 0.3),
                    ),
                  ),
                  child: _hasImage
                      ? Image.file(selectedImage!, fit: BoxFit.cover)
                      : const Icon(
                    Icons.biotech,
                    size: 72,
                    color: Color(0xFF00D2FF),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String get _tagText {
    switch (buttonState) {
      case HeroButtonState.upload:
        return "SYSTEM READY";
      case HeroButtonState.readyToAnalyze:
        return "IMAGE READY";
      case HeroButtonState.uploading:
        return "UPLOADING...";
      case HeroButtonState.analyzing:
        return "AI ANALYZING...";
      case HeroButtonState.resultsReady:
        return "RESULTS READY";
    }
  }

  String get _descriptionText {
    switch (buttonState) {
      case HeroButtonState.upload:
        return "Instantly digitize your physical reports using our proprietary AI vision engine.";
      case HeroButtonState.readyToAnalyze:
        return "Report image selected. Run the AI vision engine to extract your results.";
      case HeroButtonState.uploading:
        return "Uploading your report image, please wait...";
      case HeroButtonState.analyzing:
        return "Our AI engine is analyzing your report. This may take a moment.";
      case HeroButtonState.resultsReady:
        return "Your report has been fully analyzed and is ready to view.";
    }
  }

  Widget _buildActionArea(double scale) {
    switch (buttonState) {
    // ─── ما في صورة → زر Upload ───
      case HeroButtonState.upload:
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: onPickImagePressed,
            icon: const Icon(Icons.add_circle, color: Colors.black),
            label: const Text(
              "UPLOAD NEW TEST",
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00D2FF),
              padding: EdgeInsets.symmetric(
                horizontal: 24 * scale,
                vertical: 16 * scale.clamp(0.9, 1.2),
              ),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            ),
          ),
        );

    // ─── في صورة، لسا ما انبعتت → زر Analyze + Remove ───
      case HeroButtonState.readyToAnalyze:
        return Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: onAnalyzePressed,
                icon: const Icon(Icons.auto_awesome, color: Colors.black),
                label: const Text(
                  "ANALYZE IMAGE",
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00D2FF),
                  padding: EdgeInsets.symmetric(
                    horizontal: 24 * scale,
                    vertical: 16 * scale.clamp(0.9, 1.2),
                  ),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                ),
              ),
            ),
            SizedBox(height: 10 * scale),
            SizedBox(
              width: double.infinity,
              child: TextButton.icon(
                onPressed: onRemoveImagePressed,
                icon: const Icon(Icons.close, color: Colors.grey, size: 18),
                label: const Text("Remove & choose another",
                    style: TextStyle(color: Colors.grey)),
              ),
            ),
          ],
        );

    // ─── عم يرفع الصورة أو عم يحلل → زر معطل فيه مؤشر تحميل ───
      case HeroButtonState.uploading:
      case HeroButtonState.analyzing:
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: null,
            icon: const SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(strokeWidth: 2, color: Colors.black),
            ),
            label: Text(
              buttonState == HeroButtonState.uploading
                  ? "UPLOADING..."
                  : "جاري التحليل باستخدام AI",
              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00D2FF).withValues(alpha: 0.6),
              disabledBackgroundColor: const Color(0xFF00D2FF).withValues(alpha: 0.6),
              padding: EdgeInsets.symmetric(
                horizontal: 24 * scale,
                vertical: 16 * scale.clamp(0.9, 1.2),
              ),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            ),
          ),
        );

    // ─── النتيجة جاهزة → زر أخضر ───
      case HeroButtonState.resultsReady:
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: onViewResultsPressed,
            icon: const Icon(Icons.check_circle, color: Colors.white),
            label: const Text(
              "اذهب معنا لمشاهدة النتائج",
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2ECC71),
              padding: EdgeInsets.symmetric(
                horizontal: 24 * scale,
                vertical: 16 * scale.clamp(0.9, 1.2),
              ),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            ),
          ),
        );
    }
  }
}