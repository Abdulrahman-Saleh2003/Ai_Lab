import 'package:ai_lab/controller/comparison/comparison_state.dart';
import 'package:ai_lab/controller/home/home_provider.dart';
import 'package:ai_lab/models/home/Chat/message.dart';
import 'package:ai_lab/models/home/lab_report_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ComparisonController extends Notifier<ComparisonState> {
  @override
  ComparisonState build() {
    return const ComparisonState();
  }

  void updateInput(String text) {
    state = state.copyWith(inputText: text);
  }

  Future<void> init({
    required LabReportItem report1,
    required LabReportItem report2,
  }) async {
    // تحديد الأحدث والأقدم
    final date1 = report1.reportDate ?? report1.createdAt ?? DateTime(2000);
    final date2 = report2.reportDate ?? report2.createdAt ?? DateTime(2000);

    final LabReportItem current = date1.isAfter(date2) ? report1 : report2;
    final LabReportItem previous = date1.isAfter(date2) ? report2 : report1;

    state = ComparisonState(
      currentReport: current,
      previousReport: previous,
      status: ComparisonStatus.loadingData,
    );

    final homeData = ref.read(homeDataProvider);

    LabAnalysisResult? currentAnalysis = current.aiResult;
    LabAnalysisResult? previousAnalysis = previous.aiResult;

    // جلب نتائج التحليل للأحدث إذا لم تكن موجودة مسبقاً
    if (currentAnalysis == null) {
      final res = await homeData.getReportAnalysisResult(current.reportId);
      res.fold((_) {}, (data) {
        if (data is Map<String, dynamic>) {
          currentAnalysis = LabAnalysisResult.fromJson(data);
        }
      });
    }

    // جلب نتائج التحليل للأقدم إذا لم تكن موجودة مسبقاً
    if (previousAnalysis == null) {
      final res = await homeData.getReportAnalysisResult(previous.reportId);
      res.fold((_) {}, (data) {
        if (data is Map<String, dynamic>) {
          previousAnalysis = LabAnalysisResult.fromJson(data);
        }
      });
    }

    state = state.copyWith(
      currentAnalysis: currentAnalysis,
      previousAnalysis: previousAnalysis,
      status: ComparisonStatus.comparingAi,
    );

    // تجهيز الـ JSON للباك إند
    final labJson = currentAnalysis?.toJson(
          reportType: current.reportType.isNotEmpty ? current.reportType : 'CBC',
        ) ??
        {
          "report_type": current.reportType.isNotEmpty ? current.reportType : 'CBC',
          "panels": [],
        };

    final previousJson = previousAnalysis?.toJson(
          reportType: previous.reportType.isNotEmpty ? previous.reportType : 'CBC',
        ) ??
        {
          "report_type": previous.reportType.isNotEmpty ? previous.reportType : 'CBC',
          "panels": [],
        };

    // طلب المقارنة التلقائية الأولى من RAG API
    const initialQuestion =
        "قارن بين التحاليل السابقة والحالية وأخبرني عن التغييرات الصحية والتطورات والمؤشرات غير الطبيعية بدقة سريرية ومختبرية.";

    final compRes = await homeData.askFullAnalysisComparison(
      reportId: current.reportId,
      previousReportId: previous.reportId,
      question: initialQuestion,
      labJson: labJson,
      previousJson: previousJson,
    );

    compRes.fold(
      (failure) {
        state = state.copyWith(
          status: ComparisonStatus.error,
          errorMessage: failure.message,
        );
      },
      (data) {
        final answer = data['answer_html']?.toString() ??
            data['answer']?.toString() ??
            data['response']?.toString() ??
            data['analysis']?.toString() ??
            data['message']?.toString() ??
            'تمت مقارنة التحليلين بنجاح.';

        final initialAiMsg = Message(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          text: answer,
          sender: MessageSender.ai,
          timestamp: DateTime.now(),
        );

        state = state.copyWith(
          status: ComparisonStatus.ready,
          aiComparisonAnalysis: answer,
          chatMessages: [initialAiMsg],
        );
      },
    );
  }

  Future<void> sendQuestion() async {
    final text = state.inputText.trim();
    if (text.isEmpty || state.isAiTyping) return;

    final userMsg = Message(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: text,
      sender: MessageSender.user,
      timestamp: DateTime.now(),
    );

    state = state.copyWith(
      chatMessages: [...state.chatMessages, userMsg],
      inputText: '',
      isAiTyping: true,
    );

    final labJson = state.currentAnalysis?.toJson(
          reportType: state.currentReport?.reportType ?? 'CBC',
        ) ??
        {
          "report_type": state.currentReport?.reportType ?? 'CBC',
          "panels": [],
        };

    final previousJson = state.previousAnalysis?.toJson(
          reportType: state.previousReport?.reportType ?? 'CBC',
        ) ??
        {
          "report_type": state.previousReport?.reportType ?? 'CBC',
          "panels": [],
        };

    final res = await ref.read(homeDataProvider).askFullAnalysisComparison(
          reportId: state.currentReport?.reportId ?? '',
          previousReportId: state.previousReport?.reportId ?? '',
          question: text,
          labJson: labJson,
          previousJson: previousJson,
        );

    res.fold(
      (failure) {
        final errorMsg = Message(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          text: 'تعذر الاتصال بالمساعد الذكي: ${failure.message}',
          sender: MessageSender.ai,
          timestamp: DateTime.now(),
        );
        state = state.copyWith(
          chatMessages: [...state.chatMessages, errorMsg],
          isAiTyping: false,
        );
      },
      (data) {
        final answer = data['answer']?.toString() ??
            data['response']?.toString() ??
            data['analysis']?.toString() ??
            data['message']?.toString() ??
            'تم استلام الإجابة.';

        final aiMsg = Message(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          text: answer,
          sender: MessageSender.ai,
          timestamp: DateTime.now(),
        );

        state = state.copyWith(
          chatMessages: [...state.chatMessages, aiMsg],
          isAiTyping: false,
        );
      },
    );
  }
}
