import 'dart:async';
import 'dart:io';

import 'package:ai_lab/controller/home/home_provider.dart';
import 'package:ai_lab/controller/home/home_state.dart';
import 'package:ai_lab/models/home/lab_report_models.dart';
import 'package:ai_lab/screens/HomeScreen/Home/home_screen.dart';
import 'package:ai_lab/screens/HomeScreen/chat/chat_screen.dart';
import 'package:ai_lab/screens/HomeScreen/profile/profile.dart';
import 'package:ai_lab/screens/HomeScreen/report/cbc_report_screen.dart';
import 'package:ai_lab/screens/HomeScreen/report/report_screen.dart';
import 'package:ai_lab/screens/HomeScreen/report/all_reports_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class HomeController extends Notifier<HomeState> {
  final ImagePicker _picker = ImagePicker();
  Timer? _pollingTimer;
  int _pollAttempts = 0;

  // تايمر + عدّاد محاولات مستقل لكل تقرير بالقائمة
  final Map<String, Timer> _reportPollingTimers = {};
  final Map<String, int> _reportPollAttempts = {};

  static const int _maxPollAttempts = 15;

  @override
  HomeState build() {
    ref.onDispose(() {
      _pollingTimer?.cancel();
      for (final timer in _reportPollingTimers.values) {
        timer.cancel();
      }
      _reportPollingTimers.clear();
    });

    Future.microtask(() => loadRecentReportsForHome());

    return const HomeState();
  }

  final List<Widget> pages = [
    const HomeScreen(),
    const AllReportsPage(),
    const CBCReportScreen(),
    // const BloodCountReportPage(),
    const PatientProfilePage(),
    ChatScreen(),
  ];

  void changePage(int index) {
    state = state.copyWith(currentIndex: index);
  }

  // ─── اختيار صورة من الكاميرا أو المعرض ───
  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? picked = await _picker.pickImage(
        source: source,
        imageQuality: 85,
        maxWidth: 2000,
      );
      if (picked != null) {
        state = state.copyWith(
          selectedImage: File(picked.path),
          status: HomeStatus.initial,
          clearError: true,
        );
      }
    } catch (e, st) {
      debugPrint("PickImage Error: $e");
      debugPrint("StackTrace: $st");
      state = state.copyWith(
        status: HomeStatus.error,
        errorMessage:
            "تعذر فتح ${source == ImageSource.camera ? 'الكاميرا' : 'المعرض'}: $e",
      );
    }
  }

  void removeImage() {
    _pollingTimer?.cancel();
    state = const HomeState();
  }

  Future<void> analyzeExistingImage(File image) async {
    state = state.copyWith(
      selectedImage: image,
      status: HomeStatus.initial,
      clearError: true,
      clearJobId: true,
    );
    await analyzeImage();
  }

  Future<void> analyzeImage() async {
    if (state.selectedImage == null) return;

    state = state.copyWith(status: HomeStatus.uploading, clearError: true);

    final result = await ref.read(homeDataProvider).postData(
      image: state.selectedImage!,
    );

    result.fold(
      (failure) {
        state = state.copyWith(
          status: HomeStatus.error,
          errorMessage: "فشل رفع الصورة، حاول مرة أخرى",
        );
      },
      (data) {
        final String? jobId = (data is Map) ? data['job_id']?.toString() : null;

        if (jobId == null || jobId.isEmpty) {
          state = state.copyWith(
            status: HomeStatus.error,
            errorMessage: "لم يتم استلام رقم العملية من السيرفر",
          );
          return;
        }

        state = state.copyWith(status: HomeStatus.analyzing, jobId: jobId);
        _startPolling(jobId);
      },
    );
  }

  void _startPolling(String jobId) {
    _pollingTimer?.cancel();
    _pollingTimer = null;
    _pollAttempts = 0;
    _pollingTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      _checkResult(jobId);
    });
  }

  Future<void> _checkResult(String jobId) async {
    if (state.jobId != jobId) {
      _pollingTimer?.cancel();
      return;
    }

    _pollAttempts++;
    if (_pollAttempts > _maxPollAttempts) {
      _pollingTimer?.cancel();
      if (state.jobId == jobId) {
        state = state.copyWith(
          status: HomeStatus.error,
          errorMessage: "استغرق التحليل وقتاً أطول من المتوقع. حاول رفع الصورة مرة أخرى.",
        );
      }
      return;
    }

    final result = await ref.read(homeDataProvider).checkResult(jobId);

    if (state.jobId != jobId) return;

    result.fold(
      (failure) {
        debugPrint("Check result failed, retrying in 10s...");
      },
      (response) {
        final dynamic rawBody = response is Map ? response : null;
        if (rawBody is! Map) return;

        final jobStatus = LabJobStatus.fromJson(Map<String, dynamic>.from(rawBody));

        if (jobStatus.isFailed) {
          _pollingTimer?.cancel();
          state = state.copyWith(
            status: HomeStatus.error,
            errorMessage: "فشل تحليل الصورة بالسيرفر",
          );
          return;
        }

        if (jobStatus.isDone && jobStatus.result != null) {
          _pollingTimer?.cancel();
          state = state.copyWith(
            status: HomeStatus.ready,
            analysisResult: jobStatus.result,
          );
        }
      },
    );
  }

  void goToResults() {
    _pollingTimer?.cancel();
    state = const HomeState();
  }

  // ═══════════════════════════════════════════════════════════
  // منطق تحليل تقرير محدد داخل قائمة "كل التحاليل"
  // ═══════════════════════════════════════════════════════════

  void toggleReportExpanded(String reportId) {
    final updated = Set<String>.from(state.expandedReportIds);
    if (updated.contains(reportId)) {
      updated.remove(reportId);
    } else {
      updated.add(reportId);
    }
    state = state.copyWith(expandedReportIds: updated);
  }

  void _updateReportAnalysis(String reportId, ReportAnalysisState newState) {
    final updated = Map<String, ReportAnalysisState>.from(state.reportAnalysis);
    updated[reportId] = newState;
    state = state.copyWith(reportAnalysis: updated);
  }

  Future<void> analyzeReportInList(LabReportItem report) async {
    final reportId = report.reportId;
    if (reportId.isEmpty) return;

    if (state.analysisFor(reportId).isBusy) return;

    _updateReportAnalysis(
      reportId,
      const ReportAnalysisState(status: ReportAnalysisStatus.starting),
    );

    final result = await ref.read(homeDataProvider).startReportAnalysis(reportId);

    result.fold(
      (failure) {
        _updateReportAnalysis(
          reportId,
          const ReportAnalysisState(
            status: ReportAnalysisStatus.error,
            errorMessage: "فشل بدء التحليل، حاول مرة أخرى",
          ),
        );
      },
      (data) {
        final map = data is Map ? Map<String, dynamic>.from(data) : <String, dynamic>{};

        final jobId = map['job_id']?.toString();

        _updateReportAnalysis(
          reportId,
          ReportAnalysisState(
            status: ReportAnalysisStatus.analyzing,
            jobId: jobId,
          ),
        );

        _startReportPolling(reportId);
      },
    );
  }

  void _startReportPolling(String reportId) {
    _reportPollingTimers[reportId]?.cancel();
    _reportPollAttempts[reportId] = 0;

    _reportPollingTimers[reportId] = Timer.periodic(
      const Duration(seconds: 8),
      (_) => _checkReportAnalysisResult(reportId),
    );

    _checkReportAnalysisResult(reportId);
  }

  Future<void> _checkReportAnalysisResult(String reportId) async {
    final current = state.reportAnalysis[reportId];
    if (current == null || current.status != ReportAnalysisStatus.analyzing) {
      _reportPollingTimers[reportId]?.cancel();
      _reportPollingTimers.remove(reportId);
      return;
    }

    final attempts = (_reportPollAttempts[reportId] ?? 0) + 1;
    _reportPollAttempts[reportId] = attempts;

    if (attempts > _maxPollAttempts) {
      _reportPollingTimers[reportId]?.cancel();
      _reportPollingTimers.remove(reportId);
      _updateReportAnalysis(
        reportId,
        const ReportAnalysisState(
          status: ReportAnalysisStatus.error,
          errorMessage: "استغرق التحليل وقتاً أطول من المتوقع. حاول مرة أخرى.",
        ),
      );
      return;
    }

    final result = await ref.read(homeDataProvider).getReportAnalysisResult(reportId);

    final latest = state.reportAnalysis[reportId];
    if (latest == null || latest.status != ReportAnalysisStatus.analyzing) {
      return;
    }

    result.fold(
      (failure) {
        debugPrint("Check analysis-result failed for $reportId, retrying...");
      },
      (response) {
        if (response is! Map) return;

        final map = Map<String, dynamic>.from(response);
        final resultRaw = map['ocr_result'] ?? map['result'] ?? map['ai_result'];
        final bool hasOcrData = (resultRaw is Map && resultRaw.isNotEmpty);
        final statusStr = map['status']?.toString().toLowerCase() ?? '';
        final isAnalyzed = map['is_analyzed'] == true ||
            statusStr == 'done' ||
            statusStr == 'completed' ||
            hasOcrData;

        if (map['error'] != null && map['error'].toString().isNotEmpty) {
          _reportPollingTimers[reportId]?.cancel();
          _reportPollingTimers.remove(reportId);
          _updateReportAnalysis(
            reportId,
            ReportAnalysisState(
              status: ReportAnalysisStatus.error,
              errorMessage: map['error'].toString(),
            ),
          );
          return;
        }

        if (!hasOcrData && !isAnalyzed) {
          debugPrint("Analysis for report $reportId is still pending ($statusStr), continuing polling...");
          return;
        }

        _reportPollingTimers[reportId]?.cancel();
        _reportPollingTimers.remove(reportId);
        _reportPollAttempts.remove(reportId);

        LabAnalysisResult? aiResult;
        if (hasOcrData) {
          try {
            final resultMap = Map<String, dynamic>.from(resultRaw);
            if (resultMap.containsKey('current_report')) {
              aiResult = LabAnalysisResult.fromJson(resultMap);
            } else if (resultMap.containsKey('panels')) {
              aiResult = LabAnalysisResult(
                currentReport: CurrentReport.fromJson(resultMap),
              );
            }
          } catch (e) {
            debugPrint("Parse ai result error: $e");
          }
        }

        final updatedReports = state.reports.map((r) {
          if (r.reportId != reportId) return r;
          return r.copyWith(
            isAnalyzed: true,
            aiResult: aiResult ?? r.aiResult,
          );
        }).toList();

        final updatedAnalysis = Map<String, ReportAnalysisState>.from(state.reportAnalysis);
        updatedAnalysis[reportId] = const ReportAnalysisState(status: ReportAnalysisStatus.ready);

        state = state.copyWith(
          reports: updatedReports,
          reportAnalysis: updatedAnalysis,
        );
      },
    );
  }

  // ─── جلب كل التقارير ───
  Future<void> fetchAllReports({bool forceRefresh = false}) async {
    if (!forceRefresh &&
        state.reportsStatus == ReportsListStatus.loaded &&
        state.reports.isNotEmpty) {
      return;
    }

    if (state.reportsStatus == ReportsListStatus.loading) return;

    state = state.copyWith(
      reportsStatus: ReportsListStatus.loading,
      clearReportsError: true,
    );

    final result = await ref.read(homeDataProvider).getAllReports();

    result.fold(
      (failure) {
        state = state.copyWith(
          reportsStatus: ReportsListStatus.error,
          reportsErrorMessage: "تعذر تحميل التقارير، تأكد من الاتصال",
        );
      },
      (response) {
        if (response is! Map) {
          state = state.copyWith(
            reportsStatus: ReportsListStatus.error,
            reportsErrorMessage: "شكل البيانات القادمة من السيرفر غير متوقع",
          );
          return;
        }

        final parsed = LabReportsResponse.fromJson(Map<String, dynamic>.from(response));

        state = state.copyWith(
          reportsStatus: ReportsListStatus.loaded,
          reports: parsed.results,
        );
      },
    );
  }

  Future<void> loadRecentReportsForHome() async {
    if (state.reportsStatus == ReportsListStatus.loaded && state.reports.isNotEmpty) {
      return;
    }
    await fetchAllReports();
  }

  Future<void> fetchReportsByType(String type) async {
    await ref.read(homeDataProvider).getReportsByType(type);
  }
}