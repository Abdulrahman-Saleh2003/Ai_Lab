import 'package:flutter/foundation.dart';

@immutable
class ReportChatMessage {
  final String id;
  final String question;
  final String? answerHtml;
  final String? answer;
  final bool isLoading;
  final bool isError;
  final DateTime timestamp;

  const ReportChatMessage({
    required this.id,
    required this.question,
    this.answerHtml,
    this.answer,
    this.isLoading = false,
    this.isError = false,
    required this.timestamp,
  });

  ReportChatMessage copyWith({
    String? id,
    String? question,
    String? answerHtml,
    String? answer,
    bool? isLoading,
    bool? isError,
    DateTime? timestamp,
  }) {
    return ReportChatMessage(
      id: id ?? this.id,
      question: question ?? this.question,
      answerHtml: answerHtml ?? this.answerHtml,
      answer: answer ?? this.answer,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}

enum ReportChatStatus { initial, loading, success, failure }

@immutable
class ReportChatState {
  final String reportId;
  final List<ReportChatMessage> messages;
  final bool isSending;
  final ReportChatStatus status;
  final String? errorMessage;

  const ReportChatState({
    this.reportId = '',
    this.messages = const [],
    this.isSending = false,
    this.status = ReportChatStatus.initial,
    this.errorMessage,
  });

  ReportChatState copyWith({
    String? reportId,
    List<ReportChatMessage>? messages,
    bool? isSending,
    ReportChatStatus? status,
    String? errorMessage,
  }) {
    return ReportChatState(
      reportId: reportId ?? this.reportId,
      messages: messages ?? this.messages,
      isSending: isSending ?? this.isSending,
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }
}
