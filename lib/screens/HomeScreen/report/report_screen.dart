
import 'package:ai_lab/models/home/lab_report_models.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CBCReportScreen extends StatefulWidget {
  final LabAnalysisResult? reportData; // نتيجة التحليل القادمة من الـ API (state.analysisResult)

  const CBCReportScreen({super.key, this.reportData});

  @override
  State<CBCReportScreen> createState() => _CBCReportScreenState();
}

class _CBCReportScreenState extends State<CBCReportScreen> {
  // ─── كل الفحوصات جاهزة مباشرة من الموديل، ما في تفكيك يدوي ───
  List<LabTest> get _tests => widget.reportData?.tests ?? [];

  // ─── يحدد اللون حسب حالة الفحص ───
  Color _statusColor(String status) {
    final s = status.toLowerCase();
    if (s.contains('critical')) return const Color(0xFFEF4444); // أحمر
    if (s.contains('high') || s.contains('low')) {
      return const Color(0xFFF59E0B); // برتقالي
    }
    if (s.contains('normal')) return const Color(0xFF10B981); // أخضر
    return const Color(0xFF00D2FF); // افتراضي
  }

  @override
  Widget build(BuildContext context) {
    final tests = _tests;

    return Scaffold(
      backgroundColor: const Color(0xFF111317),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0C0E11),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF00D2FF)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Complete Blood Count',
          style: GoogleFonts.spaceGrotesk(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF00D2FF),
            letterSpacing: -0.5,
          ),
        ),
        actions: const [
          Icon(Icons.more_vert, color: Color(0xFFE2E2E6)),
          SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Report Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'AI VISION ENGINE',
                      style: GoogleFonts.manrope(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 2,
                        color: const Color(0xFFBBC9CF),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Diagnos AI',
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'TESTS FOUND',
                      style: GoogleFonts.manrope(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 2,
                        color: const Color(0xFFBBC9CF),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${tests.length}',
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF00D2FF),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 32),

            // ─── حالة ما في بيانات ───
            if (tests.isEmpty)
              Container(
                padding: const EdgeInsets.all(24),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1C1F),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFF333538)),
                ),
                child: Text(
                  "لا توجد نتائج لعرضها",
                  style: GoogleFonts.manrope(color: const Color(0xFFBBC9CF)),
                ),
              )
            else
            // ─── بطاقة لكل فحص، مبنية مباشرة من كائنات LabTest ───
              ...tests.map((test) {
                return _buildResultCard(
                  title: test.displayTitle,
                  subtitle: test.testName,
                  value: test.value.isNotEmpty ? test.value : '-',
                  unit: test.unit,
                  ref: test.referenceRange,
                  progress: test.progress,
                  statusColor: _statusColor(test.status),
                  statusText: test.statusAr.isNotEmpty ? test.statusAr : test.status,
                );
              }),

            const SizedBox(height: 40),

            // AI Analysis Button
            Container(
              width: double.infinity,
              height: 68,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(999),
                gradient: const LinearGradient(
                  colors: [Color(0xFF00D2FF), Color(0xFF6E208C)],
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF00D2FF).withValues(alpha: 0.3),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(999),
                  onTap: () {
                    // TODO: Generate AI Analysis (ملخص نصي شامل عن الحالة)
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('AI Analysis coming soon...')),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.psychology, color: Colors.white, size: 28),
                      const SizedBox(width: 12),
                      Text(
                        'Generate AI Analysis',
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.auto_awesome, color: Color(0xFFEDB1FF)),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildResultCard({
    required String title,
    required String subtitle,
    required String value,
    required String unit,
    required String ref,
    required double progress,
    required Color statusColor,
    required String statusText,
  }) {
    final isCritical = statusText.toLowerCase().contains("critical") ||
        statusText.contains("حرج") ||
        statusText.contains("خطر");

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1C1F),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF333538)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: GoogleFonts.spaceGrotesk(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    Text(subtitle,
                        style: GoogleFonts.manrope(
                            fontSize: 13.5, color: const Color(0xFFBBC9CF))),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Container(
                          width: 11,
                          height: 11,
                          decoration: BoxDecoration(
                              color: statusColor, shape: BoxShape.circle)),
                      const SizedBox(width: 8),
                      Text(
                        value,
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: statusColor,
                        ),
                      ),
                    ],
                  ),
                  Text("$ref $unit",
                      style: GoogleFonts.manrope(
                          fontSize: 12, color: const Color(0xFF859399))),
                ],
              ),
            ],
          ),

          const SizedBox(height: 18),

          // Progress Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: const Color(0xFF333538),
              valueColor: AlwaysStoppedAnimation<Color>(statusColor),
              minHeight: 7,
            ),
          ),

          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                statusText,
                style: GoogleFonts.manrope(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: statusColor,
                ),
              ),
              Text(
                isCritical ? "Immediate Review Required" : "Measured Value",
                style:
                GoogleFonts.manrope(fontSize: 12, color: const Color(0xFF859399)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}