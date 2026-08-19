
import 'package:ai_lab/controller/home/Chat/chat_provider.dart';
import 'package:ai_lab/screens/HomeScreen/chat/bottom_nav_bar.dart';
import 'package:ai_lab/screens/HomeScreen/chat/chat_message_bubble.dart';
import 'package:ai_lab/screens/HomeScreen/chat/typing_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key});

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

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
  Widget build(BuildContext context) {
    final chatState = ref.watch(chatProvider);
    final chatController = ref.read(chatProvider.notifier);

    ref.listen(chatProvider, (previous, next) {
      if (previous?.messages.length != next.messages.length ||
          next.isAiTyping) {
        _scrollToBottom();
      }
    });

    return Scaffold(
      backgroundColor: const Color(0xFF111317),
      body: Column(
        children: [
          // ===== Top App Bar =====
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1C1F),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
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
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFF333538),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF00D2FF).withOpacity(0.4),
                          blurRadius: 20,
                        ),
                      ],
                    ),
                    child: const Icon(Icons.psychology,
                        color: Color(0xFFA5E7FF)),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Neural Assistant',
                          style: TextStyle(
                            color: Color(0xFFA5E7FF),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                          ),
                        ),
                        Text(
                          'متصل - LabSync AI',
                          style: TextStyle(
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
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 120),
              children: [
                // Date Divider
                Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 16),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A1C1F),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'اليوم',
                      style: TextStyle(
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

      // ===== Input + Bottom Nav =====
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Input Area
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
                      // Add button
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: const Color(0xFF333538),
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: const Color(0xFF3C494E).withOpacity(0.2)),
                        ),
                        child: const Icon(Icons.add,
                            color: Color(0xFFBBC9CF)),
                      ),
                      const SizedBox(width: 8),

                      // Text Field
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF282A2D),
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                                color:
                                    const Color(0xFF3C494E).withOpacity(0.3)),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _controller,
                                  onChanged: chatController.updateInput,
                                  maxLines: 4,
                                  minLines: 1,
                                  style: const TextStyle(
                                      color: Color(0xFFE2E2E6), fontSize: 14),
                                  decoration: const InputDecoration(
                                    hintText: 'اسأل Neural Assistant...',
                                    hintStyle:
                                        TextStyle(color: Color(0xFFBBC9CF)),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 14),
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
                                    _controller.clear();
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
                                      textDirection: TextDirection.ltr,
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
                  const Text(
                    'الذكاء الاصطناعي قد يخطئ أحياناً. يرجى مراجعة التقارير الطبية مع طبيبك المختص.',
                    style: TextStyle(
                      color: Color(0xFFBBC9CF),
                      fontSize: 10,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),

          // Bottom Nav (Mobile only)
          // if (MediaQuery.of(context).size.width < 600)
            // const BottomNavBar(),
        ],
      ),
    );
  }
}