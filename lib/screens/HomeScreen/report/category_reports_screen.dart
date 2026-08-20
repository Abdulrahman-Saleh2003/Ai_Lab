import 'package:ai_lab/controller/category_selection/category_selection_provider.dart';
import 'package:ai_lab/controller/home/home_provider.dart';
import 'package:ai_lab/controller/home/home_state.dart';
import 'package:ai_lab/core/constant/app_size.dart';
import 'package:ai_lab/models/home/lab_report_models.dart';
import 'package:ai_lab/screens/HomeScreen/Ocr/report_details_screen.dart';
import 'package:ai_lab/screens/HomeScreen/report/report_comparison_screen.dart';
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

  void _openComparison(BuildContext context, LabReportItem r1, LabReportItem r2) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ReportComparisonScreen(report1: r1, report2: r2),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allReports = ref.watch(homeProvider.select((s) => s.reports));
    final reportsStatus = ref.watch(homeProvider.select((s) => s.reportsStatus));
    final selectionState = ref.watch(categorySelectionProvider);
    final selectionCtrl = ref.read(categorySelectionProvider.notifier);
    final scale = AppSize.scale(context);

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
                        onPressed: () {
                          if (selectionState.isSelectionMode) {
                            selectionCtrl.clearSelection();
                          } else {
                            Navigator.of(context).pop();
                          }
                        },
                      ),
                      const SizedBox(width: 4),
                      Icon(icon, color: _primary, size: 22),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          selectionState.isSelectionMode
                              ? "select_reports_to_compare".tr()
                              : categoryTitle,
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
                if (selectionState.isSelectionMode)
                  TextButton(
                    onPressed: selectionCtrl.clearSelection,
                    child: Text(
                      "cancel_selection".tr(),
                      style: const TextStyle(color: _error, fontSize: 13),
                    ),
                  )
                else
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
                : Column(
                    children: [
                      // ─── زر المقارنة السريعة لأحدث تقريرين ───
                      if (!selectionState.isSelectionMode && categoryReports.length >= 2)
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.fromLTRB(16, 12, 16, 4),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF1E2630), Color(0xFF13181F)],
                            ),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: _primary.withValues(alpha: 0.3),
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: _primary.withValues(alpha: 0.15),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.auto_awesome, color: _primary, size: 20),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "compare_latest_two".tr(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    const Text(
                                      "مقارنة ذكية وفورية بين أحدث تحليلين مسجلين",
                                      style: TextStyle(color: _onSurfaceVar, fontSize: 11),
                                    ),
                                  ],
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () => _openComparison(
                                  context,
                                  categoryReports[0],
                                  categoryReports[1],
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: _primary,
                                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: Text(
                                  "compare_reports".tr(),
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                      // ─── قائمة البطاقات ───
                      Expanded(
                        child: ListView.separated(
                          padding: EdgeInsets.fromLTRB(
                            16,
                            12,
                            16,
                            selectionState.isSelectionMode ? 100 : 40,
                          ),
                          itemCount: categoryReports.length,
                          separatorBuilder: (_, _) => const SizedBox(height: 16),
                          itemBuilder: (context, index) {
                            final report = categoryReports[index];
                            final isSelected = selectionState.isSelected(report.reportId);

                            return _CategoryReportCard(
                              report: report,
                              accentColor: _statusColor(report.status),
                              statusLabel: _statusLabel(report.status),
                              dateText: _formatDate(report.reportDate ?? report.createdAt),
                              icon: icon,
                              isSelectionMode: selectionState.isSelectionMode,
                              isSelected: isSelected,
                              onTap: () {
                                if (selectionState.isSelectionMode) {
                                  final ok = selectionCtrl.toggleReport(report);
                                  if (!ok) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text("max_two_reports_selected".tr()),
                                        backgroundColor: _warning,
                                      ),
                                    );
                                  }
                                }
                              },
                              onLongPress: () {
                                if (!selectionState.isSelectionMode) {
                                  selectionCtrl.startSelection(report);
                                }
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
      ),
      bottomNavigationBar: selectionState.isSelectionMode
          ? Container(
              padding: EdgeInsets.all(16 * scale.clamp(0.9, 1.2)),
              decoration: BoxDecoration(
                color: const Color(0xFF16181C),
                border: const Border(top: BorderSide(color: _outlineVar)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.5),
                    blurRadius: 20,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: SafeArea(
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: _primary.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: _primary.withValues(alpha: 0.4)),
                      ),
                      child: Text(
                        "selected_count".tr(namedArgs: {'count': '${selectionState.count}'}),
                        style: const TextStyle(
                          color: _primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: selectionState.canCompare
                            ? () {
                                final r1 = selectionState.selectedReports[0];
                                final r2 = selectionState.selectedReports[1];
                                selectionCtrl.clearSelection();
                                _openComparison(context, r1, r2);
                              }
                            : null,
                        icon: const Icon(Icons.compare_arrows, color: Colors.black),
                        label: Text(
                          "compare_now".tr(),
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _primary,
                          disabledBackgroundColor: _primary.withValues(alpha: 0.3),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : null,
    );
  }
}

class _CategoryReportCard extends ConsumerWidget {
  final LabReportItem report;
  final Color accentColor;
  final String statusLabel;
  final String dateText;
  final IconData icon;
  final bool isSelectionMode;
  final bool isSelected;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  const _CategoryReportCard({
    required this.report,
    required this.accentColor,
    required this.statusLabel,
    required this.dateText,
    required this.icon,
    this.isSelectionMode = false,
    this.isSelected = false,
    this.onTap,
    this.onLongPress,
  });

  static const _error = Color(0xFFFFB4AB);
  static const _primary = Color(0xFF00D2FF);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scale = AppSize.scale(context);
    final analysisState = ref.watch(
      homeProvider.select((s) => s.analysisFor(report.reportId)),
    );

    return InkWell(
      onTap: isSelectionMode
          ? onTap
          : () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ReportDetailsScreen(report: report),
                ),
              );
            },
      onLongPress: onLongPress,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF1F2B35)
              : const Color(0xFF1A1C1F).withValues(alpha: 0.90),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? _primary : Colors.white.withValues(alpha: 0.05),
            width: isSelected ? 2 : 1,
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
                if (isSelectionMode)
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Icon(
                      isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
                      color: isSelected ? _primary : const Color(0xFFBBC9CF),
                      size: 24,
                    ),
                  ),
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

            // ─── Actions Row ───
            if (!isSelectionMode)
              Row(
                children: [
                  Expanded(
                    child: _buildOcrActionButton(context, ref, scale, analysisState),
                  ),
                  const SizedBox(width: 10),
                  _buildDetailsButton(context, scale),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _iconBox() {
    return Container(
      width: 46,
      height: 46,
      decoration: BoxDecoration(
        color: const Color(0xFF282A2D),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF3C494E)),
      ),
      child: Icon(icon, color: _primary, size: 24),
    );
  }

  Widget _buildDetailsButton(BuildContext context, double scale) {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: const Color(0xFF282A2D),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF3C494E)),
      ),
      child: IconButton(
        icon: const Icon(Icons.arrow_forward, color: Color(0xFFE2E2E6), size: 18),
        tooltip: 'report_details'.tr(),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => ReportDetailsScreen(report: report),
            ),
          );
        },
      ),
    );
  }

  Widget _buildOcrActionButton(
    BuildContext context,
    WidgetRef ref,
    double scale,
    ReportAnalysisState analysisState,
  ) {
    if (analysisState.isBusy) {
      final label = switch (analysisState.status) {
        ReportAnalysisStatus.starting => "preparing_image".tr(),
        ReportAnalysisStatus.analyzing => "analyzing_ai".tr(),
        _ => "analyzing_ai".tr(),
      };
      return Container(
        height: 44,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: const Color(0xFF282A2D),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _primary.withValues(alpha: 0.4)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: _primary,
              ),
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: _primary,
                ),
              ),
            ),
          ],
        ),
      );
    }

    final hasResult = report.aiResult != null || analysisState.status == ReportAnalysisStatus.ready;

    if (hasResult) {
      return ElevatedButton.icon(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => ReportDetailsScreen(report: report),
            ),
          );
        },
        icon: const Icon(Icons.analytics_outlined, size: 16, color: Colors.black),
        label: Text(
          "view_analysis_results".tr(),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontFamily: 'Cairo',
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: _primary,
          elevation: 0,
          minimumSize: const Size(0, 44),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
    }

    return OutlinedButton.icon(
      onPressed: () {
        if (!report.hasImage) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("no_image_attached".tr()),
              backgroundColor: _error,
            ),
          );
          return;
        }
        ref.read(homeProvider.notifier).analyzeReportInList(report);
      },
      icon: const Icon(Icons.document_scanner_outlined, size: 16, color: _primary),
      label: Text(
        "start_ocr_analysis".tr(),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontFamily: 'Cairo',
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: _primary,
        ),
      ),
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: _primary, width: 1.2),
        minimumSize: const Size(0, 44),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }}

