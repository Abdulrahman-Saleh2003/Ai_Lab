
import 'package:ai_lab/controller/home/Chat/chat_controller.dart';
import 'package:ai_lab/controller/home/Chat/chat_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatProvider = NotifierProvider<ChatController, ChatState>(
  ChatController.new,
);