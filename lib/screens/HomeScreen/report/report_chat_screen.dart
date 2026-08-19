import 'package:ai_lab/controller/home/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';

// ─── رسالة واحدة بمحادثة هذا التقرير ───
class _ReportChatMessage {
  final String question;
  String? answerHtml;
  String? answer;
  bool isLoading;
  bool isError;

  _ReportChatMessage({
    required this.question,
    this.answerHtml,
    this.answer,
    this.isLoading = true,
    this.isError = false,
  });
}

class ReportChatScreen extends ConsumerStatefulWidget {
  final String reportId;
  final String? reportTitle; // اختياري، بيظهر بالـ AppBar

  const ReportChatScreen({
    super.key,
    required this.reportId,
    this.reportTitle,
  });

  @override
  ConsumerState<ReportChatScreen> createState() => _ReportChatScreenState();
}

class _ReportChatScreenState extends ConsumerState<ReportChatScreen> {
  static const _bg = Color(0xFF111317);
  static const _surface = Color(0xFF1A1C1F);
  static const _outlineVar = Color(0xFF3C494E);
  static const _primary = Color(0xFF00D2FF);
  static const _onSurfaceVar = Color(0xFFBBC9CF);

  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<_ReportChatMessage> _messages = [];
  bool _isSending = false;

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

  Future<void> _sendMessage() async {
    final question = _controller.text.trim();
    if (question.isEmpty || _isSending) return;

    _controller.clear();

    final message = _ReportChatMessage(question: question);
    setState(() {
      _messages.add(message);
      _isSending = true;
    });
    _scrollToBottom();

    final result = await ref.read(homeDataProvider).askReportQuestion(
      reportId: widget.reportId,
      question: question,
    );

    result.fold(
          (failure) {
        setState(() {
          message.isLoading = false;
          message.isError = true;
        });
      },
          (response) {
        final dynamic rawBody = response.data ?? response;
        if (rawBody is! Map) {
          setState(() {
            message.isLoading = false;
            message.isError = true;
          });
          return;
        }

        setState(() {
          message.isLoading = false;
          message.answerHtml = rawBody['answer_html']?.toString();
          message.answer = rawBody['answer']?.toString();
        });
      },
    );

    setState(() => _isSending = false);
    _scrollToBottom();
  }

  @override
  Widget build(BuildContext context) {
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
              'محادثة حول التحليل',
              style: GoogleFonts.spaceGrotesk(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: _primary,
              ),
            ),
            if (widget.reportTitle != null && widget.reportTitle!.isNotEmpty)
              Text(
                widget.reportTitle!,
                style: GoogleFonts.manrope(fontSize: 11, color: _onSurfaceVar),
              ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: _messages.isEmpty
                ? Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  "اسأل عن أي شي يخص نتائج هذا التحليل",
                  style: GoogleFonts.manrope(
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
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _buildMessageBlock(_messages[index]);
              },
            ),
          ),
          _buildInputArea(),
        ],
      ),
    );
  }

  Widget _buildMessageBlock(_ReportChatMessage message) {
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
              "تعذر جلب الرد، حاول مرة أخرى",
              style: GoogleFonts.manrope(
                color: const Color(0xFFFFB4AB),
                fontSize: 13,
              ),
            )
                : Directionality(
              textDirection: TextDirection.rtl,
              child: Html(
                data: message.answerHtml ??
                    message.answer ??
                    'لا توجد إجابة',
                style: {
                  "body": Style(
                    margin: Margins.zero,
                    padding: HtmlPaddings.zero,
                    color: Colors.white,
                    fontSize: FontSize(13.5),
                    lineHeight: LineHeight(1.6),
                  ),
                  "h2": Style(
                    color: _primary,
                    fontSize: FontSize(17),
                    fontWeight: FontWeight.bold,
                    margin: Margins.only(top: 12, bottom: 6),
                  ),
                  "h3": Style(
                    color: _primary,
                    fontSize: FontSize(15),
                    fontWeight: FontWeight.bold,
                    margin: Margins.only(top: 10, bottom: 4),
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
        SizedBox(
          width: 16,
          height: 16,
          child: CircularProgressIndicator(strokeWidth: 2, color: _primary),
        ),
        const SizedBox(width: 10),
        Text(
          "جاري التفكير...",
          style: GoogleFonts.manrope(color: _onSurfaceVar, fontSize: 13),
        ),
      ],
    );
  }

  Widget _buildInputArea() {
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
                      border: Border.all(color: _outlineVar.withValues(alpha: 0.3)),
                    ),
                    child: TextField(
                      controller: _controller,
                      maxLines: 4,
                      minLines: 1,
                      style: const TextStyle(color: Color(0xFFE2E2E6), fontSize: 14),
                      decoration: const InputDecoration(
                        hintText: 'اسأل عن نتيجة معينة بهذا التحليل...',
                        hintStyle: TextStyle(color: Color(0xFFBBC9CF)),
                        border: InputBorder.none,
                        contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      ),
                      textAlign: TextAlign.right,
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: _isSending ? null : _sendMessage,
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: _isSending
                            ? [Colors.grey, Colors.grey.shade700]
                            : const [Color(0xFFA5E7FF), Color(0xFF00D2FF)],
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.send,
                      size: 18,
                      color: const Color(0xFF00566A),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              'الذكاء الاصطناعي قد يخطئ أحياناً. يرجى مراجعة التقارير الطبية مع طبيبك المختص.',
              style: GoogleFonts.manrope(color: _onSurfaceVar, fontSize: 10),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}