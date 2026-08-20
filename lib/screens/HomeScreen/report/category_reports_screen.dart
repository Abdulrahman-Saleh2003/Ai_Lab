import 'package:ai_lab/controller/home/home_provider.dart';
import 'package:ai_lab/controller/home/home_state.dart';
import 'package:ai_lab/core/constant/app_size.dart';
import 'package:ai_lab/models/home/lab_report_models.dart';
import 'package:ai_lab/screens/HomeScreen/Ocr/report_details_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryReportsScreen extends ConsumerWidget {
  final String categoryKey;
  final String categoryTitle;
  final IconData icon;

  const CategoryReportsScreen({
    super.key,
    required this.categoryKey,
    required this.categoryTitle,
    required this.icon,
  });

  static const _bg = Color(0xFF111317);
  static const _surfaceHigh = Color(0xFF282A2D);
  static const _onSurface = Color(0xFFE2E2E6);
  static const _onSurfaceVar = Color(0xFFBBC9CF);
  static const _outlineVar = Color(0xFF3C494E);
  static const _primary = Color(0xFF00D2FF);
  static const _primarySoft = Color(0xFFA5E7FF);
  static const _error = Color(0xFFFFB4AB);
  static const _warning = Color(0xFFF59E0B);
  static const _grey = Color(0xFF7A8A90);

  Color _statusColor(ReportStatus s) {
    switch (s) {
      case ReportStatus.completed:
      case ReportStatus.reviewed:
        return _primary;
      case ReportStatus.processing:
      case ReportStatus.pending:
        return _warning;
      case ReportStatus.rejected:
        return _error;
      case ReportStatus.archived:
        return _grey;
      case ReportStatus.unknown:
        return _onSurfaceVar;
    }
  }

  String _statusLabel(ReportStatus s) {
    switch (s) {
      case ReportStatus.completed:
        return 'status_completed'.tr();
      case ReportStatus.reviewed:
        return 'status_reviewed'.tr();
      case ReportStatus.processing:
        return 'status_processing'.tr();
      case ReportStatus.pending:
        return 'status_pending'.tr();
      case ReportStatus.rejected:
        return 'status_rejected'.tr();
      case ReportStatus.archived:
        return 'status_archived'.tr();
      case ReportStatus.unknown:
        return 'status_unknown'.tr();
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '—';
    const months = [
      'JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN',
      'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC'
    ];
    final month = months[date.month - 1];
    final hour12 = date.hour % 12 == 0 ? 12 : date.hour % 12;
    final period = date.hour >= 12 ? 'PM' : 'AM';
    final minute = date.minute.toString().padLeft(2, '0');
    return '$month ${date.day}, ${date.year} • $hour12:$minute $period';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allReports = ref.watch(homeProvider.select((s) => s.reports));
    final reportsStatus = ref.watch(homeProvider.select((s) => s.reportsStatus));

    // فلترة التقارير التابعة لهذا القسم
    final categoryReports = allReports.where((r) {
      final key = categoryKey.toLowerCase().trim();
      final type = r.reportType.toLowerCase().trim();
      final cat = r.category.toLowerCase().trim();
      return type == key || cat == key || (key == 'other' && type.isEmpty && cat.isEmpty);
    }).toList();

    return Scaffold(
      backgroundColor: _bg,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(64),
        child: Container(
          color: const Color(0xFF0C0E11),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new, color: _primary, size: 20),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      const SizedBox(width: 4),
                      Icon(icon, color: _primary, size: 22),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          categoryTitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontFamily: 'SpaceGrotesk',
                            color: _onSurface,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: _surfaceHigh,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: _outlineVar),
                  ),
                  child: Text(
                    '${categoryReports.length} ${'reports_count'.tr()}',
                    style: const TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 12,
                      color: _primarySoft,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        color: _primary,
        backgroundColor: _surfaceHigh,
        onRefresh: () => ref.read(homeProvider.notifier).fetchAllReports(),
        child: reportsStatus == ReportsListStatus.loading && categoryReports.isEmpty
            ? const Center(child: CircularProgressIndicator(color: _primary))
            : categoryReports.isEmpty
                ? ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: [
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.6,
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(icon, size: 64, color: _grey.withValues(alpha: 0.5)),
                              const SizedBox(height: 16),
                              Text(
                                "${'no_reports_in_category'.tr()} ($categoryTitle)",
                                style: const TextStyle(color: _onSurfaceVar, fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 20, 16, 40),
                    itemCount: categoryReports.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final report = categoryReports[index];
                      return _CategoryReportCard(
                        report: report,
                        accentColor: _statusColor(report.status),
                        statusLabel: _statusLabel(report.status),
                        dateText: _formatDate(report.reportDate ?? report.createdAt),
                        icon: icon,
                      );
                    },
                  ),
      ),
    );
  }
}

class _CategoryReportCard extends ConsumerWidget {
  final LabReportItem report;
  final Color accentColor;
  final String statusLabel;
  final String dateText;
  final IconData icon;

  const _CategoryReportCard({
    required this.report,
    required this.accentColor,
    required this.statusLabel,
    required this.dateText,
    required this.icon,
  });

  static const _error = Color(0xFFFFB4AB);
  static const _primary = Color(0xFF00D2FF);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scale = AppSize.scale(context);
    final analysisState = ref.watch(
      homeProvider.select((s) => s.analysisFor(report.reportId)),
    );

    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1A1C1F).withValues(alpha: 0.90),
          borderRadius: BorderRadius.circular(16),
          border: Border(
            left: BorderSide(color: accentColor, width: 3),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: EdgeInsets.all(18 * scale.clamp(0.9, 1.15)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── Header Row ───
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: report.hasImage
                      ? Image.network(
                          report.fullImageUrl!,
                          width: 46,
                          height: 46,
                          fit: BoxFit.cover,
                          errorBuilder: (_, _, _) => _iconBox(),
                          loadingBuilder: (context, child, progress) {
                            if (progress == null) return child;
                            return _iconBox();
                          },
                        )
                      : _iconBox(),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        report.title.isNotEmpty ? report.title : report.reportType,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFFE2E2E6),
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        dateText,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Color(0xFFBBC9CF),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: accentColor.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 7,
                        height: 7,
                        decoration: BoxDecoration(
                          color: accentColor,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: accentColor.withValues(alpha: 0.5),
                              blurRadius: 6,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        statusLabel.toUpperCase(),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          color: accentColor,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),
            Container(
              height: 1,
              color: const Color(0xFF3C494E).withValues(alpha: 0.3),
            ),
            const SizedBox(height: 12),

            // ─── Lab Name Info ───
            Row(
              children: [
                Icon(icon, size: 14, color: const Color(0xFFBBC9CF)),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    report.labName.isNotEmpty ? report.labName : report.category,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFFBBC9CF),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            // ─── Action Button: OCR / Results ───
            _buildActionButton(context, ref, analysisState),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    WidgetRef ref,
    ReportAnalysisState analysisState,
  ) {
    if (!report.hasImage) {
      return const Row(
        children: [
          Icon(Icons.info_outline, color: Color(0xFFBBC9CF), size: 16),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              "لا توجد صورة مرفقة بهذا التقرير لتحليلها",
              style: TextStyle(fontSize: 12, color: Color(0xFFBBC9CF)),
            ),
          ),
        ],
      );
    }

    // إذا كان التقرير محللاً مسبقاً → زر عرض النتائج
    if (report.isAnalyzed) {
      return SizedBox(
        width: double.infinity,
        child: OutlinedButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ReportDetailsScreen(report: report),
              ),
            );
          },
          icon: const Icon(Icons.remove_red_eye_outlined, color: _primary, size: 18),
          label: const Text(
            "عرض نتائج التحليل",
            style: TextStyle(fontWeight: FontWeight.bold, color: _primary),
          ),
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: _primary),
            padding: const EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          ),
        ),
      );
    }

    // إذا كان التحليل جارياً
    if (analysisState.isBusy) {
      final label = switch (analysisState.status) {
        ReportAnalysisStatus.starting => "جاري بدء التحليل...",
        ReportAnalysisStatus.analyzing => "جاري التحليل بالذكاء الاصطناعي...",
        _ => "جاري المعالجة...",
      };
      return SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: null,
          icon: const SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(strokeWidth: 2, color: Colors.black),
          ),
          label: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: _primary.withValues(alpha: 0.6),
            disabledBackgroundColor: _primary.withValues(alpha: 0.6),
            padding: const EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          ),
        ),
      );
    }

    // الحالة الافتراضية: زر تحليل بالذكاء الاصطناعي
    final isRetry = analysisState.isError;
    return Column(
      children: [
        if (isRetry && analysisState.errorMessage != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              analysisState.errorMessage!,
              style: const TextStyle(color: _error, fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () =>
                ref.read(homeProvider.notifier).analyzeReportInList(report),
            icon: const Icon(Icons.document_scanner_outlined, color: Colors.black),
            label: Text(
              isRetry ? "حاول التحليل مرة أخرى" : "تحليل بالذكاء الاصطناعي (OCR)",
              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: _primary,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _iconBox() {
    return Container(
      width: 46,
      height: 46,
      decoration: BoxDecoration(
        color: accentColor.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, color: accentColor, size: 22),
    );
  }
}
