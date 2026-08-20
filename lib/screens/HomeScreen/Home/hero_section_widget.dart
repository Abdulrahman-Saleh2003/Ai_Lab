import 'dart:io';
import 'package:ai_lab/core/constant/app_size.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

enum HeroButtonState { upload, readyToAnalyze, uploading, analyzing, resultsReady }

class HeroSectionWidget extends StatelessWidget {
  final File? selectedImage;
  final HeroButtonState buttonState;
  final VoidCallback? onPickImagePressed;
  final VoidCallback? onAnalyzePressed;
  final VoidCallback? onRemoveImagePressed;
  final VoidCallback? onViewResultsPressed;

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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final scale = AppSize.scale(context);

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
            "system_diagnostic_ai".tr(),
            style: TextStyle(
              fontFamily: 'SpaceGrotesk',
              fontSize: 24 * scale.clamp(0.85, 1.15),
              fontWeight: FontWeight.bold,
              height: 1.2,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _descriptionText,
            style: TextStyle(
              fontSize: 13 * scale.clamp(0.9, 1.1),
              color: Colors.grey,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 24),
          _buildActionArea(scale),
          const SizedBox(height: 32),
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
        return "ready_to_analyze".tr().toUpperCase();
      case HeroButtonState.readyToAnalyze:
        return "ready_to_analyze".tr().toUpperCase();
      case HeroButtonState.uploading:
        return "uploading_image".tr().toUpperCase();
      case HeroButtonState.analyzing:
        return "analyzing_ai".tr().toUpperCase();
      case HeroButtonState.resultsReady:
        return "analysis_results".tr().toUpperCase();
    }
  }

  String get _descriptionText {
    switch (buttonState) {
      case HeroButtonState.upload:
        return "onboarding_desc_1".tr();
      case HeroButtonState.readyToAnalyze:
        return "start_ocr_analysis".tr();
      case HeroButtonState.uploading:
        return "uploading_image".tr();
      case HeroButtonState.analyzing:
        return "analyzing_ai".tr();
      case HeroButtonState.resultsReady:
        return "analysis_success".tr();
    }
  }

  Widget _buildActionArea(double scale) {
    switch (buttonState) {
      case HeroButtonState.upload:
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: onPickImagePressed,
            icon: const Icon(Icons.document_scanner, color: Colors.black),
            label: Text(
              "upload_new_test".tr(),
              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00D2FF),
              padding: EdgeInsets.symmetric(
                horizontal: 24 * scale,
                vertical: 16 * scale.clamp(0.9, 1.2),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
        );

      case HeroButtonState.readyToAnalyze:
        return Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: onAnalyzePressed,
                icon: const Icon(Icons.biotech, color: Colors.black),
                label: Text(
                  "start_ocr_analysis".tr(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00D2FF),
                  padding: EdgeInsets.symmetric(
                    horizontal: 24 * scale,
                    vertical: 16 * scale.clamp(0.9, 1.2),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10 * scale),
            SizedBox(
              width: double.infinity,
              child: TextButton.icon(
                onPressed: onRemoveImagePressed,
                icon: const Icon(Icons.close, color: Colors.grey, size: 18),
                label: const Text(
                  "Remove & choose another",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ],
        );

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
                  ? "uploading_image".tr()
                  : "analyzing_ai".tr(),
              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00D2FF).withValues(alpha: 0.6),
              disabledBackgroundColor: const Color(0xFF00D2FF).withValues(alpha: 0.6),
              padding: EdgeInsets.symmetric(
                horizontal: 24 * scale,
                vertical: 16 * scale.clamp(0.9, 1.2),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
        );

      case HeroButtonState.resultsReady:
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: onViewResultsPressed,
            icon: const Icon(Icons.check_circle, color: Colors.white),
            label: Text(
              "view_ai_results".tr(),
              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2ECC71),
              padding: EdgeInsets.symmetric(
                horizontal: 24 * scale,
                vertical: 16 * scale.clamp(0.9, 1.2),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
        );
    }
  }
}