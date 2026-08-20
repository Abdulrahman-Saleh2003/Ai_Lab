import 'package:ai_lab/models/home/Chat/message.dart';
import 'package:ai_lab/models/home/lab_report_models.dart';

enum ComparisonStatus { initial, loadingData, comparingAi, ready, error }

class ComparisonState {
  final LabReportItem? currentReport;
  final LabReportItem? previousReport;
  final LabAnalysisResult? currentAnalysis;
  final LabAnalysisResult? previousAnalysis;
  final ComparisonStatus status;
  final String? aiComparisonAnalysis;
  final String? errorMessage;
  final List<Message> chatMessages;
  final bool isAiTyping;
  final String inputText;

  const ComparisonState({
    this.currentReport,
    this.previousReport,
    this.currentAnalysis,
    this.previousAnalysis,
    this.status = ComparisonStatus.initial,
    this.aiComparisonAnalysis,
    this.errorMessage,
    this.chatMessages = const [],
    this.isAiTyping = false,
    this.inputText = '',
  });

  bool get isLoading =>
      status == ComparisonStatus.loadingData || status == ComparisonStatus.comparingAi;

  ComparisonState copyWith({
    LabReportItem? currentReport,
    LabReportItem? previousReport,
    LabAnalysisResult? currentAnalysis,
    LabAnalysisResult? previousAnalysis,
    ComparisonStatus? status,
    String? aiComparisonAnalysis,
    String? errorMessage,
    List<Message>? chatMessages,
    bool? isAiTyping,
    String? inputText,
  }) {
    return ComparisonState(
      currentReport: currentReport ?? this.currentReport,
      previousReport: previousReport ?? this.previousReport,
      currentAnalysis: currentAnalysis ?? this.currentAnalysis,
      previousAnalysis: previousAnalysis ?? this.previousAnalysis,
      status: status ?? this.status,
      aiComparisonAnalysis: aiComparisonAnalysis ?? this.aiComparisonAnalysis,
      errorMessage: errorMessage ?? this.errorMessage,
      chatMessages: chatMessages ?? this.chatMessages,
      isAiTyping: isAiTyping ?? this.isAiTyping,
      inputText: inputText ?? this.inputText,
    );
  }
}
