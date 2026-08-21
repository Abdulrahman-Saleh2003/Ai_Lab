import 'dart:ui' as ui;
import 'package:ai_lab/controller/comparison/comparison_controller.dart';
import 'package:ai_lab/controller/comparison/comparison_provider.dart';
import 'package:ai_lab/controller/comparison/comparison_state.dart';
import 'package:ai_lab/core/constant/app_size.dart';
import 'package:ai_lab/models/home/Chat/message.dart';
import 'package:ai_lab/models/home/lab_report_models.dart';
import 'package:ai_lab/core/theme/medical_status_theme.dart';
import 'package:ai_lab/core/widgets/medical_markdown_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReportComparisonScreen extends ConsumerStatefulWidget {
  final LabReportItem report1;
  final LabReportItem report2;

  const ReportComparisonScreen({
    super.key,
    required this.report1,
    required this.report2,
  });

  @override
  ConsumerState<ReportComparisonScreen> createState() =>
      _ReportComparisonScreenState();
}

class _ReportComparisonScreenState
    extends ConsumerState<ReportComparisonScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _textController = TextEditingController();
  final ScrollController _chatScrollController = ScrollController();

  static const _bg = Color(0xFF111317);
  static const _surface = Color(0xFF1A1C1F);
  static const _surfaceHigh = Color(0xFF282A2D);
  static const _onSurface = Color(0xFFE2E2E6);
  static const _onSurfaceVar = Color(0xFFBBC9CF);
  static const _outlineVar = Color(0xFF3C494E);
  static const _primary = Color(0xFF00D2FF);
  static const _accentPurple = Color(0xFF9D50BB);
  static const _error = Color(0xFFFFB4AB);
  static const _success = Color(0xFF2ECC71);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(comparisonProvider.notifier).init(
            report1: widget.report1,
            report2: widget.report2,
          );
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _textController.dispose();
    _chatScrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_chatScrollController.hasClients) {
      _chatScrollController.animateTo(
        _chatScrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '—';
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(comparisonProvider);
    final controller = ref.read(comparisonProvider.notifier);
    final scale = AppSize.scale(context);

    ref.listen(comparisonProvider.select((s) => s.chatMessages.length),
        (_, _) {
      Future.delayed(const Duration(milliseconds: 100), _scrollToBottom);
    });

    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: const Color(0xFF0C0E11),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: _primary, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "compare_reports".tr(),
          style: const TextStyle(
            fontFamily: 'SpaceGrotesk',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: _onSurface,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: _primary,
          indicatorWeight: 3,
          labelColor: _primary,
          unselectedLabelColor: _onSurfaceVar,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          tabs: [
            Tab(text: "test_parameter".tr(), icon: const Icon(Icons.compare_arrows, size: 20)),
            Tab(text: "comparison_analysis".tr(), icon: const Icon(Icons.auto_awesome, size: 20)),
            Tab(text: "nav_chat".tr(), icon: const Icon(Icons.chat_bubble_outline, size: 20)),
          ],
        ),
      ),
      body: state.isLoading
          ? _buildLoadingState(scale)
          : TabBarView(
              controller: _tabController,
              children: [
                _buildMetricsComparisonTab(state, scale),
                _buildAiAnalysisTab(state, scale),
                _buildComparativeChatTab(state, controller, scale),
              ],
            ),
    );
  }

  Widget _buildLoadingState(double scale) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80 * scale,
              height: 80 * scale,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [_primary, _accentPurple],
                ),
                boxShadow: [
                  BoxShadow(
                    color: _primary.withValues(alpha: 0.3),
                    blurRadius: 20,
                    spreadRadius: 4,
                  ),
                ],
              ),
              child: const CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 3,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              "fetching_comparison_data".tr(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Cairo',
                color: _onSurface,
                fontSize: 15,
                fontWeight: FontWeight.w600,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────
  // TAB 1: METRICS & DELTA COMPARISON
  // ─────────────────────────────────────────────────────────────
  Widget _buildMetricsComparisonTab(ComparisonState state, double scale) {
    final currentTests = state.currentAnalysis?.tests ?? [];
    final previousTests = state.previousAnalysis?.tests ?? [];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildReportsSummaryCard(state, scale),
          const SizedBox(height: 20),
          Text(
            "test_parameter".tr(),
            style: const TextStyle(
              fontFamily: 'SpaceGrotesk',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: _onSurface,
            ),
          ),
          const SizedBox(height: 12),
          if (currentTests.isEmpty && previousTests.isEmpty)
            Container(
              padding: const EdgeInsets.all(24),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: _surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: _outlineVar),
              ),
              child: Text(
                "no_extracted_tests".tr(),
                style: const TextStyle(color: _onSurfaceVar),
              ),
            )
          else
            ..._buildMatchedTestCards(currentTests, previousTests, scale),
        ],
      ),
    );
  }

  Widget _buildReportsSummaryCard(ComparisonState state, double scale) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _outlineVar),
        gradient: LinearGradient(
          colors: [
            _surface,
            _surfaceHigh.withValues(alpha: 0.8),
          ],
        ),
      ),
      child: Row(
        children: [
          // Current Report Badge
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _primary.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: _primary.withValues(alpha: 0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.fiber_new, color: _primary, size: 18),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          "current_report".tr(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: _primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _formatDate(state.currentReport?.reportDate ??
                        state.currentReport?.createdAt),
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: _onSurface,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    state.currentReport?.labName ?? 'Lab',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 11, color: _onSurfaceVar),
                  ),
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Icon(Icons.arrow_forward, color: _onSurfaceVar, size: 20),
          ),
          // Previous Report Badge
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.04),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: _outlineVar),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.history, color: _onSurfaceVar, size: 18),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          "previous_report".tr(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: _onSurfaceVar,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _formatDate(state.previousReport?.reportDate ??
                        state.previousReport?.createdAt),
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: _onSurface,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    state.previousReport?.labName ?? 'Lab',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 11, color: _onSurfaceVar),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildMatchedTestCards(
      List<LabTest> currentList, List<LabTest> previousList, double scale) {
    // Map previous tests by normalized key
    final prevMap = <String, LabTest>{};
    for (final t in previousList) {
      final key = (t.alias.isNotEmpty ? t.alias : t.testName).toLowerCase().trim();
      prevMap[key] = t;
    }

    final widgets = <Widget>[];

    for (final curr in currentList) {
      final key = (curr.alias.isNotEmpty ? curr.alias : curr.testName).toLowerCase().trim();
      final prev = prevMap[key];

      final currVal = double.tryParse(curr.value.replaceAll(',', '.'));
      final prevVal = prev != null ? double.tryParse(prev.value.replaceAll(',', '.')) : null;

      String deltaText = '—';
      Color deltaColor = _onSurfaceVar;
      IconData? deltaIcon;

      if (currVal != null && prevVal != null) {
        final diff = currVal - prevVal;
        if (diff > 0) {
          deltaText = '+${diff.toStringAsFixed(1)} ↑';
          deltaColor = curr.isNormal ? _success : _error;
          deltaIcon = Icons.arrow_upward;
        } else if (diff < 0) {
          deltaText = '${diff.toStringAsFixed(1)} ↓';
          deltaColor = curr.isNormal ? _success : _error;
          deltaIcon = Icons.arrow_downward;
        } else {
          deltaText = '0.0 (ثابت)';
          deltaColor = _onSurfaceVar;
          deltaIcon = Icons.remove;
        }
      }

      final currTheme = MedicalTestTheme.fromTest(curr);

      widgets.add(
        Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: currTheme.borderColor,
              width: currTheme.hasWarningBorder ? 1.5 : 1.0,
            ),
            boxShadow: currTheme.hasWarningBorder
                ? [
                    BoxShadow(
                      color: currTheme.borderColor.withValues(alpha: 0.12),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    )
                  ]
                : null,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      curr.displayTitle,
                      style: const TextStyle(
                        fontFamily: 'SpaceGrotesk',
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: _onSurface,
                      ),
                    ),
                  ),
                  if (deltaIcon != null)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: deltaColor.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: deltaColor.withValues(alpha: 0.3)),
                      ),
                      child: Text(
                        deltaText,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: deltaColor,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Previous Value
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "previous_value".tr(),
                        style: const TextStyle(fontSize: 11, color: _onSurfaceVar),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        prev != null ? '${prev.value} ${prev.unit}'.trim() : '—',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: _onSurfaceVar,
                        ),
                      ),
                    ],
                  ),
                  const Icon(Icons.trending_flat, color: _onSurfaceVar, size: 20),
                  // Current Value
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "current_value".tr(),
                        style: TextStyle(fontSize: 11, color: currTheme.textColor),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${curr.value} ${curr.unit}'.trim(),
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: currTheme.textColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (curr.referenceRange.isNotEmpty)
                    Text(
                      'المعدل الطبيعي: ${curr.referenceRange} ${curr.unit}'.trim(),
                      style: const TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 11,
                        color: _onSurfaceVar,
                      ),
                    ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: currTheme.badgeBg,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: currTheme.borderColor.withValues(alpha: 0.3)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(currTheme.icon, size: 12, color: currTheme.textColor),
                        const SizedBox(width: 4),
                        Text(
                          currTheme.statusTextAr,
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 10.5,
                            fontWeight: FontWeight.bold,
                            color: currTheme.textColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    return widgets;
  }

  // ─────────────────────────────────────────────────────────────
  // TAB 2: AI CLINICAL COMPARISON ANALYSIS
  // ─────────────────────────────────────────────────────────────
  Widget _buildAiAnalysisTab(ComparisonState state, double scale) {
    final aiText = state.aiComparisonAnalysis;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  _primary.withValues(alpha: 0.15),
                  _accentPurple.withValues(alpha: 0.15),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: _primary.withValues(alpha: 0.3)),
            ),
            child: Row(
              children: [
                const Icon(Icons.auto_awesome, color: _primary, size: 28),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "comparison_analysis".tr(),
                        style: const TextStyle(
                          fontFamily: 'SpaceGrotesk',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 2),
                      const Text(
                        "توليد فوري ومقارنة ذكية مدعومة بنظام RAG الطبي",
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 12,
                          color: _onSurfaceVar,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          if (aiText == null || aiText.isEmpty)
            Center(
              child: Text(
                "لا توجد تفاصيل مقارنة حالياً.",
                style: const TextStyle(color: _onSurfaceVar),
              ),
            )
          else
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: _surface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: _outlineVar),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.35),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: MedicalMarkdownView(
                data: aiText,
                style: const TextStyle(
                  fontFamily: 'Cairo',
                  color: Color(0xFFE2E2E6),
                  fontSize: 14,
                  height: 1.7,
                ),
              ),
            ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.amber.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.amber.withValues(alpha: 0.3)),
            ),
            child: Row(
              children: [
                const Icon(Icons.info_outline, color: Colors.amber, size: 20),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "ai_disclaimer".tr(),
                    style: const TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 11,
                      color: Colors.amber,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────
  // TAB 3: COMPARATIVE INTERACTIVE CHATBOT
  // ─────────────────────────────────────────────────────────────
  Widget _buildComparativeChatTab(
      ComparisonState state, ComparisonController controller, double scale) {
    return Column(
      children: [
        Expanded(
          child: state.chatMessages.isEmpty
              ? Center(
                  child: Text(
                    "ask_about_comparison".tr(),
                    style: const TextStyle(color: _onSurfaceVar, fontSize: 13),
                  ),
                )
              : ListView.builder(
                  controller: _chatScrollController,
                  padding: const EdgeInsets.all(16),
                  itemCount: state.chatMessages.length,
                  itemBuilder: (context, index) {
                    final msg = state.chatMessages[index];
                    final isUser = msg.sender == MessageSender.user;

                    return Align(
                      alignment:
                          isUser ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(14),
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.sizeOf(context).width * 0.8,
                        ),
                        decoration: BoxDecoration(
                          color: isUser ? _primary : _surfaceHigh,
                          borderRadius: BorderRadius.circular(16).copyWith(
                            bottomRight:
                                isUser ? const Radius.circular(0) : const Radius.circular(16),
                            bottomLeft:
                                !isUser ? const Radius.circular(0) : const Radius.circular(16),
                          ),
                          border: isUser
                              ? null
                              : Border.all(color: _outlineVar.withValues(alpha: 0.5)),
                        ),
                        child: Directionality(
                          textDirection: ui.TextDirection.rtl,
                          child: isUser
                              ? Text(
                                  msg.text,
                                  style: const TextStyle(
                                    fontFamily: 'Cairo',
                                    color: Colors.black,
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              : MedicalMarkdownView(
                                  data: msg.text,
                                  style: const TextStyle(
                                    fontFamily: 'Cairo',
                                    color: Colors.white,
                                    fontSize: 13.5,
                                    height: 1.6,
                                  ),
                                ),
                        ),
                      ),
                    );
                  },
                ),
        ),
        if (state.isAiTyping)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2, color: _primary),
                ),
                const SizedBox(width: 8),
                Text(
                  "thinking".tr(),
                  style: const TextStyle(color: _primary, fontSize: 12),
                ),
              ],
            ),
          ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: const BoxDecoration(
            color: Color(0xFF16181C),
            border: Border(top: BorderSide(color: _outlineVar)),
          ),
          child: SafeArea(
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    onChanged: controller.updateInput,
                    onSubmitted: (_) {
                      controller.sendQuestion();
                      _textController.clear();
                    },
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                    decoration: InputDecoration(
                      hintText: "ask_about_comparison".tr(),
                      hintStyle: const TextStyle(color: _onSurfaceVar, fontSize: 12),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: _primary),
                  onPressed: () {
                    controller.sendQuestion();
                    _textController.clear();
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
