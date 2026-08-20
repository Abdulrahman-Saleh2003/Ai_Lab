import 'package:ai_lab/controller/report_chat/report_chat_controller.dart';
import 'package:ai_lab/controller/report_chat/report_chat_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final reportChatProvider =
    NotifierProvider<ReportChatController, ReportChatState>(
  ReportChatController.new,
);
