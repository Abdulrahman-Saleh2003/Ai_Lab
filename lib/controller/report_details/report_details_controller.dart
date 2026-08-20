import 'dart:io';
import 'package:ai_lab/controller/home/home_provider.dart';
import 'package:ai_lab/controller/home/home_state.dart';
import 'package:ai_lab/controller/report_details/report_details_state.dart';
import 'package:ai_lab/models/home/lab_report_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class ReportDetailsController extends Notifier<ReportDetailsState> {
  @override
  ReportDetailsState build() {
    return const ReportDetailsState();
  }

  void initialize(LabReportItem report) {
    final initialResult = report.isAnalyzed ? report.aiResult : null;
    state = ReportDetailsState(
      report: report,
      result: initialResult,
      showResults: report.isAnalyzed && initialResult != null,
    );
  }

  void toggleShowResults(bool show) {
    state = state.copyWith(showResults: show);
  }

  Future<File?> downloadImageToTempFile(String url) async {
    try {
      state = state.copyWith(
        isDownloading: true,
        status: ReportDetailsStatus.downloading,
      );
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final tempDir = Directory.systemTemp;
        final reportId = state.report?.reportId ?? 'temp';
        final filePath = '${tempDir.path}/report_$reportId.jpg';
        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);
        state = state.copyWith(isDownloading: false);
        return file;
      }
    } catch (e) {
      state = state.copyWith(
        isDownloading: false,
        status: ReportDetailsStatus.failure,
        errorMessage: 'فشل تحميل صورة التقرير: $e',
      );
    }
    state = state.copyWith(isDownloading: false);
    return null;
  }

  Future<void> runAnalysis() async {
    final report = state.report;
    if (report == null || !report.hasImage) {
      state = state.copyWith(
        status: ReportDetailsStatus.failure,
        errorMessage: 'لا توجد صورة مرفقة بهذا التقرير',
      );
      return;
    }

    final file = await downloadImageToTempFile(report.fullImageUrl!);
    if (file == null) {
      state = state.copyWith(
        status: ReportDetailsStatus.failure,
        errorMessage: 'تعذر تحميل صورة التقرير لتحليلها',
      );
      return;
    }

    state = state.copyWith(status: ReportDetailsStatus.analyzing);

    await ref.read(homeProvider.notifier).analyzeExistingImage(file);

    final homeState = ref.read(homeProvider);
    if (homeState.status == HomeStatus.ready &&
        homeState.analysisResult != null) {
      state = state.copyWith(
        result: homeState.analysisResult,
        showResults: true,
        status: ReportDetailsStatus.success,
      );
    } else if (homeState.status == HomeStatus.error) {
      state = state.copyWith(
        status: ReportDetailsStatus.failure,
        errorMessage: homeState.errorMessage ?? 'حدث خطأ أثناء التحليل',
      );
    }
  }
}
