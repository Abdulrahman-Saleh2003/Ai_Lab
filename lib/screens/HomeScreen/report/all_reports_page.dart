
import 'package:ai_lab/controller/home/home_provider.dart';
import 'package:ai_lab/controller/home/home_state.dart';
import 'package:ai_lab/models/home/lab_report_models.dart';
import 'package:ai_lab/screens/HomeScreen/report/report_chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ai_lab/screens/HomeScreen/Ocr/report_details_screen.dart'; // ✅ عدّل المسار حسب مكان الملف عندك


class AllReportsPage extends ConsumerStatefulWidget {
  const AllReportsPage({super.key});

  @override
  ConsumerState<AllReportsPage> createState() => _AllReportsPageState();
}

class _AllReportsPageState extends ConsumerState<AllReportsPage> {
  static const _bg = Color(0xFF111317);
  static const _surfaceHigh = Color(0xFF282A2D);
  static const _onSurface = Color(0xFFE2E2E6);
  static const _onSurfaceVar = Color(0xFFBBC9CF);
  static const _outlineVar = Color(0xFF3C494E);
  static const _primary = Color(0xFF00D2FF);
  static const _primarySoft = Color(0xFFA5E7FF);
  static const _error = Color(0xFFFFB4AB);
  static const _onPrimary = Color(0xFF003543);
  static const _warning = Color(0xFFF59E0B);
  static const _grey = Color(0xFF7A8A90);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(homeProvider.notifier).fetchAllReports();
    });
  }

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
        return 'Completed';
      case ReportStatus.reviewed:
        return 'Reviewed';
      case ReportStatus.processing:
        return 'Processing';
      case ReportStatus.pending:
        return 'Pending';
      case ReportStatus.rejected:
        return 'Rejected';
      case ReportStatus.archived:
        return 'Archived';
      case ReportStatus.unknown:
        return 'Unknown';
    }
  }

  IconData _iconForType(String reportType) {
    switch (reportType.toLowerCase()) {
      case 'blood':
        return Icons.bloodtype_outlined;
      case 'urine':
        return Icons.water_drop_outlined;
      case 'xray':
        return Icons.medical_information_outlined;
      case 'ct':
      case 'mri':
        return Icons.document_scanner_outlined;
      case 'ultrasound':
        return Icons.graphic_eq_outlined;
      case 'ecg':
      case 'eeg':
        return Icons.monitor_heart_outlined;
      case 'biopsy':
        return Icons.biotech_outlined;
      case 'dna':
        return Icons.hub_outlined;
      case 'hormones':
      case 'biochemistry':
        return Icons.science_outlined;
      case 'microbiology':
        return Icons.coronavirus_outlined;
      case 'endoscopy':
        return Icons.camera_outlined;
      default:
        return Icons.description_outlined;
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
  Widget build(BuildContext context) {
    final state = ref.watch(homeProvider);

    return Scaffold(
      backgroundColor: _bg,
      extendBody: true,
      appBar: _buildAppBar(state),
      body: _buildBody(state),
    );
  }

  PreferredSizeWidget _buildAppBar(HomeState state) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(64),
      child: Container(
        color: const Color(0xFF0C0E11),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.science, color: _primary, size: 22),
                  const SizedBox(width: 8),
                  const Text(
                    'ALL REPORTS',
                    style: TextStyle(
                      fontFamily: 'SpaceGrotesk',
                      color: _primary,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 3,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  if (state.reportsStatus == ReportsListStatus.loading)
                    const Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: _primary,
                        ),
                      ),
                    ),
                  Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      color: _surfaceHigh,
                      shape: BoxShape.circle,
                      border: Border.all(color: _outlineVar),
                    ),
                    child: const Icon(Icons.person_outline,
                        size: 18, color: _primarySoft),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody(HomeState state) {
    if (state.reportsStatus == ReportsListStatus.loading &&
        state.reports.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(color: _primary),
      );
    }

    if (state.reportsStatus == ReportsListStatus.error &&
        state.reports.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.wifi_off_rounded, color: _error, size: 48),
              const SizedBox(height: 16),
              Text(
                state.reportsErrorMessage ?? 'تعذر تحميل التقارير',
                textAlign: TextAlign.center,
                style: const TextStyle(color: _onSurfaceVar, fontSize: 14),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () =>
                    ref.read(homeProvider.notifier).fetchAllReports(forceRefresh: true),
                icon: const Icon(Icons.refresh, color: _onPrimary),
                label: const Text('حاول مرة أخرى',
                    style: TextStyle(color: _onPrimary)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (state.reports.isEmpty) {
      return RefreshIndicator(
        color: _primary,
        onRefresh: () => ref.read(homeProvider.notifier).fetchAllReports(forceRefresh: true),
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.25),
            const Icon(Icons.folder_off_outlined,
                color: _onSurfaceVar, size: 48),
            const SizedBox(height: 16),
            const Text(
              'لا توجد تقارير بعد',
              textAlign: TextAlign.center,
              style: TextStyle(color: _onSurfaceVar, fontSize: 15),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      color: _primary,
      backgroundColor: _surfaceHigh,
      onRefresh: () => ref.read(homeProvider.notifier).fetchAllReports(forceRefresh: true),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 160),
        children: [
          Text(
            'Live Analysis Feed',
            style: TextStyle(
              color: _onSurfaceVar,
              fontSize: 11,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 6),
          RichText(
            text: TextSpan(
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                height: 1.2,
              ),
              children: [
                const TextSpan(
                    text: 'Laboratory\n',
                    style: TextStyle(color: _onSurface)),
                TextSpan(
                    text: '${state.reports.length} Reports',
                    style: const TextStyle(color: _primary)),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // ✅ كل بطاقة الآن ConsumerWidget مستقل، وفيه key ثابت مشان توسيعها/طيّها ما ينضرب بالـ rebuild
          ...state.reports.map((report) {
            return Padding(
              key: ValueKey(report.reportId),
              padding: const EdgeInsets.only(bottom: 14),
              child: _ReportCard(
                report: report,
                accentColor: _statusColor(report.status),
                statusLabel: _statusLabel(report.status),
                icon: _iconForType(report.reportType),
                dateText: _formatDate(report.uploadDate),
              ),
            );
          }),

          const SizedBox(height: 16),
          Text(
            'END OF SYNCHRONIZED RECORDS',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: _onSurfaceVar.withValues(alpha: 0.5),
              fontSize: 10,
              letterSpacing: 2.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _ReportCard extends ConsumerWidget {
  final LabReportItem report;
  final Color accentColor;
  final String statusLabel;
  final IconData icon;
  final String dateText;

  const _ReportCard({
    required this.report,
    required this.accentColor,
    required this.statusLabel,
    required this.icon,
    required this.dateText,
  });

  static const _error = Color(0xFFFFB4AB);
  static const _primary = Color(0xFF00D2FF);
  static const _outlineVar = Color(0xFF3C494E);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ✅ نراقب فقط حالة التحليل الخاصة بهاد التقرير (ما عاد في حاجة لـ isExpanded)
    final analysisState = ref.watch(
      homeProvider.select((s) => s.analysisFor(report.reportId)),
    );

    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1A1C1F).withValues(alpha: 0.85),
          borderRadius: BorderRadius.circular(16),
          border: Border(
            left: BorderSide(color: accentColor, width: 2.5),
          ),
        ),
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── Top row ─── (بدون تغيير)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: report.hasImage
                      ? Image.network(
                    report.fullImageUrl!,
                    width: 44,
                    height: 44,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => _iconBox(),
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
                        report.title.isNotEmpty
                            ? report.title
                            : report.reportType,
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
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 5),
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
                                blurRadius: 6)
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
                color: const Color(0xFF3C494E).withValues(alpha: 0.3)),
            const SizedBox(height: 12),

            // ─── Bottom row: المختبر ─── (بدون تغيير)
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Icon(icon, size: 14, color: const Color(0xFFBBC9CF)),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          report.labName.isNotEmpty
                              ? report.labName
                              : report.category,
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
                ),
              ],
            ),

            const SizedBox(height: 12),

            // ✅ الزر الرئيسي فقط — بدون أي قسم موسّع تحته
            _buildActionButton(context, ref, analysisState),
          ],
        ),
      ),
    );
  }

  // ─── الزر الرئيسي: تحليل / متابعة الانتظار / الانتقال لصفحة النتائج ───
  Widget _buildActionButton(
      BuildContext context,
      WidgetRef ref,
      ReportAnalysisState analysisState,
      ) {
    if (!report.hasImage) {
      return Row(
        children: [
          const Icon(Icons.info_outline, color: Color(0xFFBBC9CF), size: 16),
          const SizedBox(width: 8),
          const Expanded(
            child: Text(
              "لا توجد صورة مرفقة بهذا التقرير لتحليلها",
              style: TextStyle(fontSize: 12, color: Color(0xFFBBC9CF)),
            ),
          ),
        ],
      );
    }

    // ✅ التقرير محلل مسبقاً → زر ينتقل لصفحة التفاصيل + النتائج (صفحة منفصلة)
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

    // #########################

    // عم يحلل حالياً (تنزيل/رفع/انتظار) — بدون تغيير
    // if (analysisState.isBusy) {
    //   final label = switch (analysisState.status) {
    //     ReportAnalysisStatus.downloading => "جاري تحميل الصورة...",
    //     ReportAnalysisStatus.uploading => "جاري الرفع...",
    //     ReportAnalysisStatus.analyzing => "جاري التحليل بالذكاء الاصطناعي...",
    //     _ => "جاري المعالجة...",
    //   };
    //   return SizedBox(
    //     width: double.infinity,
    //     child: ElevatedButton.icon(
    //       onPressed: null,
    //       icon: const SizedBox(
    //         width: 16,
    //         height: 16,
    //         child: CircularProgressIndicator(strokeWidth: 2, color: Colors.black),
    //       ),
    //       label: Text(
    //         label,
    //         style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
    //       ),
    //       style: ElevatedButton.styleFrom(
    //         backgroundColor: _primary.withValues(alpha: 0.6),
    //         disabledBackgroundColor: _primary.withValues(alpha: 0.6),
    //         padding: const EdgeInsets.symmetric(vertical: 12),
    //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
    //       ),
    //     ),
    //   );
    // }

    // #########################
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
    // ─── الحالة الافتراضية أو خطأ سابق → زر "تحليل بالذكاء الاصطناعي" ───
    // بدون تغيير — بعد ما يخلص التحليل، الزر رح يتحول تلقائياً لـ "عرض نتائج التحليل"
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
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: accentColor.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, color: accentColor, size: 22),
    );
  }
}