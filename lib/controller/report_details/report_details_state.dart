import 'package:ai_lab/models/home/lab_report_models.dart';
import 'package:flutter/foundation.dart';

enum ReportDetailsStatus { initial, downloading, analyzing, success, failure }

@immutable
class ReportDetailsState {
  final LabReportItem? report;
  final LabAnalysisResult? result;
  final bool showResults;
  final bool isDownloading;
  final ReportDetailsStatus status;
  final String? errorMessage;

  const ReportDetailsState({
    this.report,
    this.result,
    this.showResults = false,
    this.isDownloading = false,
    this.status = ReportDetailsStatus.initial,
    this.errorMessage,
  });

  ReportDetailsState copyWith({
    LabReportItem? report,
    LabAnalysisResult? result,
    bool? showResults,
    bool? isDownloading,
    ReportDetailsStatus? status,
    String? errorMessage,
  }) {
    return ReportDetailsState(
      report: report ?? this.report,
      result: result ?? this.result,
      showResults: showResults ?? this.showResults,
      isDownloading: isDownloading ?? this.isDownloading,
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }
}
