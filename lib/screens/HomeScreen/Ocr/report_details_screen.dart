import 'package:ai_lab/controller/report_details/report_details_controller.dart';
import 'package:ai_lab/controller/report_details/report_details_provider.dart';
import 'package:ai_lab/controller/report_details/report_details_state.dart';
import 'package:ai_lab/models/home/lab_report_models.dart';
import 'package:ai_lab/screens/HomeScreen/report/report_chat_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReportDetailsScreen extends ConsumerWidget {
  final LabReportItem report;

  const ReportDetailsScreen({super.key, required this.report});

  static const _bg = Color(0xFF111317);
  static const _surface = Color(0xFF1A1C1F);
  static const _outlineVar = Color(0xFF3C494E);
  static const _primary = Color(0xFF00D2FF);
  static const _onSurfaceVar = Color(0xFFBBC9CF);
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
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  Color _testStatusColor(String status) {
    final s = status.toLowerCase();
    if (s.contains('critical')) return const Color(0xFFEF4444);
    if (s.contains('high') || s.contains('low')) return const Color(0xFFF59E0B);
    if (s.contains('normal')) return const Color(0xFF10B981);
    return const Color(0xFF00D2FF);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailsState = ref.watch(reportDetailsProvider);
    final controller = ref.read(reportDetailsProvider.notifier);

    // Auto initialize if not set
    if (detailsState.report == null || detailsState.report?.reportId != report.reportId) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.initialize(report);
      });
    }

    ref.listen<ReportDetailsState>(reportDetailsProvider, (prev, next) {
      if (next.status == ReportDetailsStatus.failure &&
          next.errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.errorMessage!),
            backgroundColor: Colors.redAccent,
          ),
        );
      }

      if (next.status == ReportDetailsStatus.success &&
          prev?.status != ReportDetailsStatus.success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("analysis_success".tr()),
            backgroundColor: Colors.green,
          ),
        );
      }
    });

    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: const Color(0xFF0C0E11),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: _primary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'report_details'.tr(),
          style: const TextStyle(
            fontFamily: 'SpaceGrotesk',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: _primary,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── الصورة ───
            if (report.hasImage)
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  report.fullImageUrl!,
                  width: double.infinity,
                  height: 220,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => _imagePlaceholder(),
                ),
              )
            else
              _imagePlaceholder(),

            const SizedBox(height: 20),

            // ─── العنوان + الحالة ───
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    report.title.isNotEmpty ? report.title : report.reportType,
                    style: const TextStyle(
                      fontFamily: 'SpaceGrotesk',
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: _statusColor(report.status).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text(
                    _statusLabel(report.status).toUpperCase(),
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: _statusColor(report.status),
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            if (report.description.isNotEmpty)
              Text(
                report.description,
                style: const TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 14,
                  color: _onSurfaceVar,
                  height: 1.5,
                ),
              ),

            const SizedBox(height: 24),

            // ─── بطاقة المعلومات ───
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: _surface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: _outlineVar),
              ),
              child: Column(
                children: [
                  _infoRow(
                    Icons.badge_outlined,
                    "patient_name".tr(),
                    report.patient.user.name.isNotEmpty
                        ? report.patient.user.name
                        : "not_available".tr(),
                  ),
                  _divider(),
                  _infoRow(
                    Icons.bloodtype_outlined,
                    "blood_type".tr(),
                    report.patient.bloodType.isNotEmpty
                        ? report.patient.bloodType
                        : "not_specified".tr(),
                  ),
                  _divider(),
                  _infoRow(
                    Icons.local_hospital_outlined,
                    "lab_name".tr(),
                    report.labName.isNotEmpty ? report.labName : "not_specified".tr(),
                  ),
                  _divider(),
                  _infoRow(
                    Icons.category_outlined,
                    "category".tr(),
                    report.category.isNotEmpty ? report.category : "not_specified".tr(),
                  ),
                  _divider(),
                  _infoRow(
                    Icons.flag_outlined,
                    "priority".tr(),
                    report.priority.toUpperCase(),
                  ),
                  _divider(),
                  _infoRow(
                    Icons.calendar_today_outlined,
                    "report_date".tr(),
                    _formatDate(report.reportDate ?? report.createdAt),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ─── زر التحليل أو عرض النتائج ───
            _buildActionSection(context, detailsState, controller),

            // ─── قسم النتائج إذا كانت متوفرة ───
            if (detailsState.showResults && detailsState.result != null) ...[
              const SizedBox(height: 28),
              _buildResultsSection(context, detailsState.result!),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildActionSection(
    BuildContext context,
    ReportDetailsState state,
    ReportDetailsController controller,
  ) {
    if (!report.hasImage) {
      return _infoBox("no_image_attached".tr());
    }

    if (state.isDownloading ||
        state.status == ReportDetailsStatus.downloading) {
      return _busyButton("preparing_image".tr());
    }

    if (state.status == ReportDetailsStatus.analyzing) {
      return _busyButton("analyzing_ai".tr());
    }

    if (state.result != null) {
      return SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: () => controller.toggleShowResults(!state.showResults),
          icon: Icon(
            state.showResults
                ? Icons.keyboard_arrow_up
                : Icons.keyboard_arrow_down,
            color: Colors.black,
          ),
          label: Text(
            state.showResults ? 'hide_analysis_results'.tr() : 'view_analysis_results'.tr(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: _primary,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
        ),
      );
    }

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: controller.runAnalysis,
        icon: const Icon(Icons.document_scanner_outlined, color: Colors.black),
        label: Text(
          'start_ocr_analysis'.tr(),
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: _primary,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
      ),
    );
  }

  Widget _buildResultsSection(BuildContext context, LabAnalysisResult result) {
    final tests = result.tests;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'analysis_results'.tr(),
          style: const TextStyle(
            fontFamily: 'SpaceGrotesk',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: _primary,
          ),
        ),
        const SizedBox(height: 12),
        if (tests.isEmpty)
          _infoBox("no_extracted_tests".tr())
        else
          ...tests.map((test) {
            final color = _testStatusColor(test.status);
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: _outlineVar),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          test.displayTitle,
                          style: const TextStyle(
                            fontFamily: 'SpaceGrotesk',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Text(
                        test.value.isNotEmpty ? test.value : '-',
                        style: TextStyle(
                          fontFamily: 'SpaceGrotesk',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${test.referenceRange} ${test.unit}',
                    style: const TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 12,
                      color: _onSurfaceVar,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(999),
                    child: LinearProgressIndicator(
                      value: test.progress,
                      backgroundColor: const Color(0xFF333538),
                      valueColor: AlwaysStoppedAnimation<Color>(color),
                      minHeight: 6,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    test.statusAr.isNotEmpty ? test.statusAr : test.status,
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: color,
                    ),
                  ),
                ],
              ),
            );
          }),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ReportChatScreen(
                    reportId: report.reportId,
                    reportTitle: report.title.isNotEmpty
                        ? report.title
                        : report.reportType,
                  ),
                ),
              );
            },
            icon: const Icon(Icons.chat_bubble_outline, color: Colors.white),
            label: Text(
              'talk_with_chat_about_report'.tr(),
              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6E208C),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _imagePlaceholder() {
    return Container(
      width: double.infinity,
      height: 220,
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _outlineVar),
      ),
      child: const Center(
        child: Icon(
          Icons.image_not_supported_outlined,
          color: _onSurfaceVar,
          size: 48,
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(icon, color: _primary, size: 18),
          const SizedBox(width: 12),
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'Cairo',
              fontSize: 13,
              color: _onSurfaceVar,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              fontFamily: 'Cairo',
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() =>
      Container(height: 1, color: _outlineVar.withValues(alpha: 0.4));

  Widget _infoBox(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _outlineVar),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline, color: _onSurfaceVar, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontFamily: 'Cairo',
                fontSize: 13,
                color: _onSurfaceVar,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _busyButton(String label) {
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
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: _primary.withValues(alpha: 0.6),
          disabledBackgroundColor: _primary.withValues(alpha: 0.6),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
      ),
    );
  }
}