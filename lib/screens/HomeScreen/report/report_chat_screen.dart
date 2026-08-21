import 'dart:ui' as ui;
import 'package:ai_lab/controller/report_chat/report_chat_provider.dart';
import 'package:ai_lab/controller/report_chat/report_chat_state.dart';
import 'package:ai_lab/core/constant/app_size.dart';
import 'package:ai_lab/core/widgets/medical_markdown_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_html/flutter_html.dart';

class ReportChatScreen extends ConsumerWidget {
  final String reportId;
  final String? reportTitle;

  ReportChatScreen({
    super.key,
    required this.reportId,
    this.reportTitle,
  });

  static const _bg = Color(0xFF111317);
  static const _surface = Color(0xFF1A1C1F);
  static const _outlineVar = Color(0xFF3C494E);
  static const _primary = Color(0xFF00D2FF);
  static const _onSurfaceVar = Color(0xFFBBC9CF);

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

  void _submit(WidgetRef ref) {
    final text = _inputController.text.trim();
    if (text.isEmpty) return;
    _inputController.clear();
    ref.read(reportChatProvider.notifier).sendQuestion(text, reportId: reportId);
    _scrollToBottom();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatState = ref.watch(reportChatProvider);
    final scale = AppSize.scale(context);

    // Auto initialize reportId
    if (chatState.reportId != reportId) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(reportChatProvider.notifier).initialize(reportId);
      });
    }

    ref.listen<ReportChatState>(reportChatProvider, (prev, next) {
      if (prev?.messages.length != next.messages.length ||
          (prev?.isSending == false && next.isSending == true)) {
        _scrollToBottom();
      }
      if (next.status == ReportChatStatus.failure &&
          next.errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.errorMessage!),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    });

    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: const Color(0xFF0C0E11),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: _primary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'chat_about_report'.tr(),
              style: const TextStyle(
                fontFamily: 'SpaceGrotesk',
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: _primary,
              ),
            ),
            if (reportTitle != null && reportTitle!.isNotEmpty)
              Text(
                reportTitle!,
                style: const TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 11,
                  color: _onSurfaceVar,
                ),
              ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: chatState.messages.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text(
                        "ask_anything_about_report".tr(),
                        style: const TextStyle(
                          fontFamily: 'Cairo',
                          color: _onSurfaceVar,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                : ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
                    itemCount: chatState.messages.length,
                    itemBuilder: (context, index) {
                      return _buildMessageBlock(
                        context,
                        chatState.messages[index],
                        scale,
                      );
                    },
                  ),
          ),
          _buildInputArea(ref, chatState.isSending),
        ],
      ),
    );
  }

  Widget _buildMessageBlock(
    BuildContext context,
    ReportChatMessage message,
    double scale,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // ─── سؤال المستخدم ───
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.sizeOf(context).width * 0.75,
            ),
            decoration: BoxDecoration(
              color: _primary,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Text(
              message.question,
              style: const TextStyle(color: Colors.black, fontSize: 14),
              textAlign: TextAlign.right,
            ),
          ),
        ),

        // ─── رد الذكاء الاصطناعي ───
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            margin: const EdgeInsets.only(bottom: 20),
            padding: const EdgeInsets.all(16),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.sizeOf(context).width * 0.9,
            ),
            decoration: BoxDecoration(
              color: _surface,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: _outlineVar),
            ),
            child: message.isLoading
                ? _buildTypingIndicator()
                : message.isError
                    ? Text(
                        "failed_to_get_response_retry".tr(),
                        style:  TextStyle(
                          fontFamily: 'Cairo',
                          color: Color(0xFFFFB4AB),
                          fontSize: 13,
                        ),
                      )
                    : (message.answerHtml != null &&
                            message.answerHtml!.contains('<'))
                        ? Directionality(
                            textDirection: ui.TextDirection.rtl,
                            child: Html(
                              data: message.answerHtml!,
                              style: {
                                "body": Style(
                                  margin: Margins.zero,
                                  padding: HtmlPaddings.zero,
                                  color: Colors.white,
                                  fontSize: FontSize(13.5),
                                  lineHeight: const LineHeight(1.6),
                                  fontFamily: 'Cairo',
                                ),
                                "h2": Style(
                                  color: _primary,
                                  fontSize: FontSize(17),
                                  fontWeight: FontWeight.bold,
                                  margin: Margins.only(top: 12, bottom: 6),
                                  fontFamily: 'Cairo',
                                ),
                                "h3": Style(
                                  color: _primary,
                                  fontSize: FontSize(15),
                                  fontWeight: FontWeight.bold,
                                  margin: Margins.only(top: 10, bottom: 4),
                                  fontFamily: 'Cairo',
                                ),
                                "table": Style(
                                  border: Border.all(color: _outlineVar),
                                  backgroundColor: const Color(0xFF0F1215),
                                ),
                                "th": Style(
                                  padding: HtmlPaddings.all(6),
                                  backgroundColor: _primary.withValues(alpha: 0.1),
                                  color: _primary,
                                  fontWeight: FontWeight.bold,
                                  textAlign: TextAlign.center,
                                ),
                                "td": Style(
                                  padding: HtmlPaddings.all(6),
                                  color: Colors.white70,
                                  textAlign: TextAlign.center,
                                ),
                                "strong": Style(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              },
                            ),
                          )
                        : MedicalMarkdownView(
                            data: message.answer ?? 'لا توجد إجابة',
                            style: const TextStyle(
                              fontFamily: 'Cairo',
                              color: Colors.white,
                              fontSize: 13.5,
                              height: 1.6,
                            ),
                          ),
          ),
        ),
      ],
    );
  }

  Widget _buildTypingIndicator() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          width: 16,
          height: 16,
          child: CircularProgressIndicator(strokeWidth: 2, color: _primary),
        ),
        const SizedBox(width: 10),
        Text(
          "thinking".tr(),
          style: const TextStyle(
            fontFamily: 'Cairo',
            color: _onSurfaceVar,
            fontSize: 13,
          ),
        ),
      ],
    );
  }

  Widget _buildInputArea(WidgetRef ref, bool isSending) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      decoration: const BoxDecoration(
        color: Color(0xFF0C0E11),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF282A2D),
                      borderRadius: BorderRadius.circular(24),
                      border:
                          Border.all(color: _outlineVar.withValues(alpha: 0.3)),
                    ),
                    child: TextField(
                      controller: _inputController,
                      maxLines: 4,
                      minLines: 1,
                      style: const TextStyle(
                        fontFamily: 'Cairo',
                        color: Color(0xFFE2E2E6),
                        fontSize: 14,
                      ),
                      decoration: InputDecoration(
                        hintText: 'ask_question_placeholder'.tr(),
                        hintStyle: const TextStyle(
                          fontFamily: 'Cairo',
                          color: Color(0xFFBBC9CF),
                        ),
                        border: InputBorder.none,
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      ),
                      textAlign: TextAlign.right,
                      onSubmitted: (_) => _submit(ref),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: isSending ? null : () => _submit(ref),
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: isSending
                            ? [Colors.grey, Colors.grey.shade700]
                            : const [Color(0xFFA5E7FF), Color(0xFF00D2FF)],
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
              ],
            ),
            const SizedBox(height: 6),
            Text(
              'ai_disclaimer'.tr(),
              style: const TextStyle(
                fontFamily: 'Cairo',
                color: _onSurfaceVar,
                fontSize: 10,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}