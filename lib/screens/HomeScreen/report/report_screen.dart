import 'package:ai_lab/core/theme/medical_status_theme.dart';
import 'package:ai_lab/models/home/lab_report_models.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CBCReportScreen extends StatelessWidget {
  final LabAnalysisResult? reportData;

  const CBCReportScreen({super.key, this.reportData});

  List<LabTest> get _tests => reportData?.tests ?? [];

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
          'comprehensive_blood_panel'.tr(),
          style: const TextStyle(
            fontFamily: 'SpaceGrotesk',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF00D2FF),
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
                      'system_diagnostic_ai'.tr().toUpperCase(),
                      style: const TextStyle(
                        fontFamily: 'SpaceGrotesk',
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 2,
                        color: Color(0xFFBBC9CF),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'LabSync AI',
                      style: TextStyle(
                        fontFamily: 'SpaceGrotesk',
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
                      'tests_found'.tr().toUpperCase(),
                      style: const TextStyle(
                        fontFamily: 'SpaceGrotesk',
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 2,
                        color: Color(0xFFBBC9CF),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${tests.length}',
                      style: const TextStyle(
                        fontFamily: 'SpaceGrotesk',
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF00D2FF),
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
                  "no_extracted_tests".tr(),
                  style: const TextStyle(fontFamily: 'Cairo', color: Color(0xFFBBC9CF)),
                ),
              )
            else
              ...tests.map((test) {
                final theme = MedicalTestTheme.fromTest(test);
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A1C1F),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: theme.borderColor,
                      width: theme.hasWarningBorder ? 1.5 : 1.0,
                    ),
                    boxShadow: theme.hasWarningBorder
                        ? [
                            BoxShadow(
                              color: theme.borderColor.withValues(alpha: 0.12),
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
                          Text(
                            test.displayTitle,
                            style: const TextStyle(
                              fontFamily: 'SpaceGrotesk',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            test.value.isNotEmpty ? test.value : '-',
                            style: TextStyle(
                              fontFamily: 'SpaceGrotesk',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: theme.textColor,
                            ),
                          ),
                        ],
                      ),
                      if (test.testName.isNotEmpty &&
                          test.testName != test.displayTitle) ...[
                        const SizedBox(height: 4),
                        Text(
                          test.testName,
                          style: const TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 12,
                            color: Color(0xFFBBC9CF),
                          ),
                        ),
                      ],
                      const SizedBox(height: 12),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(999),
                        child: LinearProgressIndicator(
                          value: theme.ratio,
                          backgroundColor: const Color(0xFF333538),
                          valueColor:
                              AlwaysStoppedAnimation<Color>(theme.primaryColor),
                          minHeight: 6,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Ref: ${test.referenceRange} ${test.unit}'.trim(),
                            style: const TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 11,
                              color: Color(0xFFBBC9CF),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: theme.badgeBg,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                  color: theme.borderColor.withValues(alpha: 0.3)),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(theme.icon,
                                    size: 12, color: theme.textColor),
                                const SizedBox(width: 4),
                                Text(
                                  test.statusAr.isNotEmpty
                                      ? test.statusAr
                                      : theme.statusTextAr,
                                  style: TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: theme.textColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
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
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('start_ocr_analysis'.tr())),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.psychology, color: Colors.white, size: 28),
                      const SizedBox(width: 12),
                      Text(
                        'generate_ai_analysis'.tr(),
                        style: const TextStyle(
                          fontFamily: 'SpaceGrotesk',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}