import 'package:ai_lab/models/home/lab_report_models.dart';
import 'package:flutter/material.dart';

/// ماب ونظام ألوان ذكي للنتائج الطبية والـ OCR
/// يقوم بحساب الحالة الطبية بدقة متناهية وتعيين:
/// - اللون الأساسي
/// - لون ولون الإطار (مثل برودر برتقالي على خلفية خضراء عندما تقترب القيمة من حافة المجال)
/// - التدرج اللوني والتوهج
/// - نصوص وشارات الحالة الطبية
class MedicalTestTheme {
  final Color primaryColor;
  final Color borderColor;
  final Color backgroundColor;
  final Color badgeBg;
  final Color textColor;
  final String statusText;
  final String statusTextAr;
  final IconData icon;
  final bool hasWarningBorder;
  final double ratio; // من 0.0 إلى 1.0 لتمثيل شريط التقدم

  const MedicalTestTheme({
    required this.primaryColor,
    required this.borderColor,
    required this.backgroundColor,
    required this.badgeBg,
    required this.textColor,
    required this.statusText,
    required this.statusTextAr,
    required this.icon,
    this.hasWarningBorder = false,
    this.ratio = 0.5,
  });

  /// إنشاء مظهر مخصص للتحليل بناءً على قيمته ومجاله المرجعي
  static MedicalTestTheme fromTest(LabTest test) {
    final statusLower = test.status.toLowerCase().trim();
    final statusArLower = test.statusAr.trim();
    final flagLower = test.flag.toLowerCase().trim();

    final val = double.tryParse(test.value.replaceAll(',', '.').trim());
    double? lo;
    double? hi;

    // استخراج المجال المرجعي مثل "13.0 - 17.0" أو "4.5-5.5"
    final cleanRef = test.referenceRange
        .replaceAll('Ref:', '')
        .replaceAll('ref:', '')
        .replaceAll('النطاق:', '')
        .trim();

    if (cleanRef.contains('-')) {
      final parts = cleanRef.split('-');
      if (parts.length == 2) {
        lo = double.tryParse(parts[0].trim());
        hi = double.tryParse(parts[1].trim());
      }
    }

    double ratio = 0.5;
    bool isBorderlineNearLimit = false;

    if (val != null && lo != null && hi != null && hi > lo) {
      ratio = (val - lo) / (hi - lo);
      // إذا كانت القيمة ضمن النطاق الطبيعي لكنها على الحافة (أقل من 15% أو أكبر من 85%)
      if (ratio >= 0.0 && ratio <= 1.0) {
        if (ratio <= 0.15 || ratio >= 0.85) {
          isBorderlineNearLimit = true;
        }
      }
    }

    // 1. حالة حرجة (Critical Low / High)
    if (statusLower.contains('critical') ||
        flagLower.contains('critical') ||
        flagLower == 'c' ||
        statusArLower.contains('حرج')) {
      final isCritLow = statusLower.contains('low') ||
          statusArLower.contains('منخفض') ||
          (val != null && lo != null && val < lo);

      return MedicalTestTheme(
        primaryColor: const Color(0xFFFF1744),
        borderColor: const Color(0xFFFF1744),
        backgroundColor: const Color(0xFFFF1744).withValues(alpha: 0.12),
        badgeBg: const Color(0xFFFF1744).withValues(alpha: 0.22),
        textColor: const Color(0xFFFF5252),
        statusText: isCritLow ? 'Critical Low' : 'Critical High',
        statusTextAr: isCritLow ? 'منخفض بشكل حرج' : 'مرتفع بشكل حرج',
        icon: Icons.gpp_maybe_rounded,
        hasWarningBorder: true,
        ratio: (val != null && lo != null && hi != null && hi > lo)
            ? ratio.clamp(0.0, 1.0)
            : (isCritLow ? 0.1 : 0.95),
      );
    }

    // 2. حالة طبيعية ولكنها قريبة من الخروج من النطاق (Borderline Normal)
    // هنا يكون اللون أخضر ولكن بإطار برتقالي بارز للتنبيه!
    if (isBorderlineNearLimit ||
        statusLower.contains('borderline') ||
        statusArLower.contains('قريب') ||
        statusArLower.contains('حافة')) {
      final isNearHigh = ratio > 0.5;
      return MedicalTestTheme(
        primaryColor: const Color(0xFF00E676),
        borderColor: const Color(0xFFFF9100), // برودر برتقالي للتنبيه
        backgroundColor: const Color(0xFF00E676).withValues(alpha: 0.07),
        badgeBg: const Color(0xFFFF9100).withValues(alpha: 0.18),
        textColor: const Color(0xFFFFB300),
        statusText: isNearHigh ? 'Borderline High (Normal)' : 'Borderline Low (Normal)',
        statusTextAr: isNearHigh ? 'طبيعي (قريب من الحد الأقصى)' : 'طبيعي (قريب من الحد الأدنى)',
        icon: Icons.warning_amber_rounded,
        hasWarningBorder: true,
        ratio: ratio.clamp(0.05, 0.95),
      );
    }

    // 3. مرتفع عن النطاق (Elevated / High)
    if (statusLower.contains('high') ||
        statusLower.contains('elevated') ||
        flagLower == 'h' ||
        (val != null && hi != null && val > hi) ||
        statusArLower.contains('مرتفع')) {
      return MedicalTestTheme(
        primaryColor: const Color(0xFFFF9100),
        borderColor: const Color(0xFFFF9100).withValues(alpha: 0.7),
        backgroundColor: const Color(0xFFFF9100).withValues(alpha: 0.09),
        badgeBg: const Color(0xFFFF9100).withValues(alpha: 0.20),
        textColor: const Color(0xFFFFAB40),
        statusText: 'Elevated (High)',
        statusTextAr: 'مرتفع عن النطاق',
        icon: Icons.trending_up_rounded,
        hasWarningBorder: false,
        ratio: 1.0,
      );
    }

    // 4. منخفض عن النطاق (Low)
    if (statusLower.contains('low') ||
        flagLower == 'l' ||
        (val != null && lo != null && val < lo) ||
        statusArLower.contains('منخفض')) {
      return MedicalTestTheme(
        primaryColor: const Color(0xFF00D2FF),
        borderColor: const Color(0xFF00D2FF).withValues(alpha: 0.7),
        backgroundColor: const Color(0xFF00D2FF).withValues(alpha: 0.09),
        badgeBg: const Color(0xFF00D2FF).withValues(alpha: 0.20),
        textColor: const Color(0xFF40C4FF),
        statusText: 'Low',
        statusTextAr: 'منخفض عن النطاق',
        icon: Icons.trending_down_rounded,
        hasWarningBorder: false,
        ratio: 0.0,
      );
    }

    // 5. طبيعي ومثالي (Optimal Normal)
    return MedicalTestTheme(
      primaryColor: const Color(0xFF00E676),
      borderColor: const Color(0xFF00E676).withValues(alpha: 0.35),
      backgroundColor: const Color(0xFF00E676).withValues(alpha: 0.06),
      badgeBg: const Color(0xFF00E676).withValues(alpha: 0.15),
      textColor: const Color(0xFF00E676),
      statusText: 'Normal (Optimal)',
      statusTextAr: 'طبيعي ومثالي',
      icon: Icons.check_circle_outline_rounded,
      hasWarningBorder: false,
      ratio: ratio.clamp(0.0, 1.0),
    );
  }
}
