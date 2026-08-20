
import 'dart:io';

import 'package:ai_lab/models/home/lab_report_models.dart';

enum HomeStatus {
  initial,    // ما في صورة، أو صورة مختارة وما انبعتت لسا
  uploading,  // عم يرفع الصورة
  analyzing,  // الصورة انبعتت، عم ننتظر نتيجة التحليل (polling)
  ready,      // التحليل خلص، جاهز نعرض النتيجة
  error,
}

// حالة تحميل قائمة كل التقارير (منفصلة عن حالة رفع/تحليل الصورة)
enum ReportsListStatus {
  initial,
  loading,
  loaded,
  error,
}

// ✅ جديد: حالة تحليل تقرير محدد جوا القائمة (زر "تحليل بالـ AI" لكل بطاقة)
enum ReportAnalysisStatus {
  idle,
  downloading, // عم ننزّل صورة التقرير من السيرفر
  uploading,   // عم نرفعها للتحليل
  analyzing,   // عم ننتظر نتيجة الـ OCR (polling)
  ready,
  error,
  // #########################

  starting,   // عم نطلب بدء التحليل
  // #########################


}

class ReportAnalysisState {
  final ReportAnalysisStatus status;
  final String? jobId;
  final String? errorMessage;

  const ReportAnalysisState({
    this.status = ReportAnalysisStatus.idle,
    this.jobId,
    this.errorMessage,
  });
  // #########################

  //
  // bool get isBusy =>
  //     status == ReportAnalysisStatus.downloading ||
  //         status == ReportAnalysisStatus.uploading ||
  //         status == ReportAnalysisStatus.analyzing;
  // #########################
  // #########################

  bool get isBusy =>
      status == ReportAnalysisStatus.starting ||
          status == ReportAnalysisStatus.analyzing;

  bool get isError => status == ReportAnalysisStatus.error;
  bool get isReady => status == ReportAnalysisStatus.ready;
// #########################

  // bool get isError => status == ReportAnalysisStatus.error;
}

class HomeState {
  final int currentIndex;
  final HomeStatus status;
  final File? selectedImage;
  final String? jobId;
  final String? errorMessage;
  final LabAnalysisResult? analysisResult;

  // ─── قائمة كل التقارير (صفحة AllReportsPage) ───
  final ReportsListStatus reportsStatus;
  final List<LabReportItem> reports;
  final String? reportsErrorMessage;

  // ✅ جديد: حالة تحليل كل تقرير بالقائمة، مفتاحها reportId
  final Map<String, ReportAnalysisState> reportAnalysis;
  // ✅ جديد: أي بطاقات مفتوحة (عارضة نتائجها) حالياً
  final Set<String> expandedReportIds;

  const HomeState({
    this.currentIndex = 0,
    this.status = HomeStatus.initial,
    this.selectedImage,
    this.jobId,
    this.errorMessage,
    this.analysisResult,
    this.reportsStatus = ReportsListStatus.initial,
    this.reports = const [],
    this.reportsErrorMessage,
    this.reportAnalysis = const {},
    this.expandedReportIds = const {},
  });

  bool get hasImage => selectedImage != null;

  // ✅ Helpers جديدة
  ReportAnalysisState analysisFor(String reportId) =>
      reportAnalysis[reportId] ?? const ReportAnalysisState();

  bool isReportExpanded(String reportId) => expandedReportIds.contains(reportId);

  HomeState copyWith({
    int? currentIndex,
    HomeStatus? status,
    File? selectedImage,
    String? jobId,
    String? errorMessage,
    LabAnalysisResult? analysisResult,
    ReportsListStatus? reportsStatus,
    List<LabReportItem>? reports,
    String? reportsErrorMessage,
    Map<String, ReportAnalysisState>? reportAnalysis,
    Set<String>? expandedReportIds,
    bool clearImage = false,
    bool clearError = false,
    bool clearJobId = false,
    bool clearReportsError = false,
  }) {
    return HomeState(
      currentIndex: currentIndex ?? this.currentIndex,
      status: status ?? this.status,
      selectedImage: clearImage ? null : (selectedImage ?? this.selectedImage),
      jobId: clearJobId ? null : (jobId ?? this.jobId),
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      analysisResult: analysisResult ?? this.analysisResult,
      reportsStatus: reportsStatus ?? this.reportsStatus,
      reports: reports ?? this.reports,
      reportsErrorMessage: clearReportsError
          ? null
          : (reportsErrorMessage ?? this.reportsErrorMessage),
      reportAnalysis: reportAnalysis ?? this.reportAnalysis,
      expandedReportIds: expandedReportIds ?? this.expandedReportIds,
    );
  }
}