import 'package:ai_lab/controller/home/Chat/chat_provider.dart';
import 'package:ai_lab/core/constant/app_size.dart';
import 'package:ai_lab/screens/HomeScreen/chat/chat_message_bubble.dart';
import 'package:ai_lab/screens/HomeScreen/chat/typing_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatScreen extends ConsumerWidget {
  ChatScreen({super.key});

  final TextEditingController _inputController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatState = ref.watch(chatProvider);
    final chatController = ref.read(chatProvider.notifier);
    final scale = AppSize.scale(context);

    ref.listen(chatProvider, (previous, next) {
      if (previous?.messages.length != next.messages.length || next.isAiTyping) {
        _scrollToBottom();
      }
    });

    return Scaffold(
      backgroundColor: const Color(0xFF111317),
      body: Column(
        children: [
          // ===== Top App Bar =====
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 24 * scale,
              vertical: 16 * scale,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1C1F),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.5),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: SafeArea(
              bottom: false,
              child: Row(
                children: [
                  Container(
                    width: 40 * scale,
                    height: 40 * scale,
                    decoration: BoxDecoration(
                      color: const Color(0xFF333538),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF00D2FF).withValues(alpha: 0.4),
                          blurRadius: 20,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.psychology,
                      color: Color(0xFFA5E7FF),
                    ),
                  ),
                  SizedBox(width: 16 * scale),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'neural_assistant'.tr(),
                          style: const TextStyle(
                            color: Color(0xFFA5E7FF),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                          ),
                        ),
                        Text(
                          'connected_labsync_ai'.tr(),
                          style: const TextStyle(
                            color: Color(0xFFBBC9CF),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ===== Chat Area =====
          Expanded(
            child: ListView(
              controller: _scrollController,
              padding: EdgeInsets.fromLTRB(
                24 * scale,
                24 * scale,
                24 * scale,
                120 * scale,
              ),
              children: [
                // Date Divider
                Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 16),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A1C1F),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'today'.tr(),
                      style: const TextStyle(
                        color: Color(0xFFBBC9CF),
                        fontSize: 12,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),

                // Messages
                ...chatState.messages
                    .map((msg) => ChatMessageBubble(message: msg)),

                // Typing Indicator
                if (chatState.isAiTyping) const TypingIndicator(),
              ],
            ),
          ),
        ],
      ),

      // ===== Input Bottom Bar =====
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Color(0xFF111317), Colors.transparent],
              ),
            ),
            child: SafeArea(
              top: false,
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: const Color(0xFF333538),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color:
                                const Color(0xFF3C494E).withValues(alpha: 0.2),
                          ),
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Color(0xFFBBC9CF),
                        ),
                      ),
                      const SizedBox(width: 8),

                      // Text Field
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF282A2D),
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                              color: const Color(0xFF3C494E)
                                  .withValues(alpha: 0.3),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _inputController,
                                  onChanged: chatController.updateInput,
                                  maxLines: 4,
                                  minLines: 1,
                                  style: const TextStyle(
                                    color: Color(0xFFE2E2E6),
                                    fontSize: 14,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'ask_neural_assistant'.tr(),
                                    hintStyle: const TextStyle(
                                      color: Color(0xFFBBC9CF),
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 14,
                                    ),
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                              // Send button
                              Padding(
                                padding: const EdgeInsets.all(6),
                                child: GestureDetector(
                                  onTap: () {
                                    chatController.sendMessage();
                                    _inputController.clear();
                                  },
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xFFA5E7FF),
                                          Color(0xFF00D2FF)
                                        ],
                                      ),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.send,
                                      size: 18,
                                      color: Color(0xFF00566A),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'ai_disclaimer'.tr(),
                    style: const TextStyle(
                      color: Color(0xFFBBC9CF),
                      fontSize: 10,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}