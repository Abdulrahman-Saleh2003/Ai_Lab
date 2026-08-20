import 'package:ai_lab/controller/home/home_provider.dart';
import 'package:ai_lab/controller/home/home_state.dart';
import 'package:ai_lab/core/constant/app_color.dart';
import 'package:ai_lab/core/constant/app_size.dart';
import 'package:ai_lab/models/home/lab_report_models.dart';
import 'package:ai_lab/screens/HomeScreen/Home/health_trajectory.dart';
import 'package:ai_lab/screens/HomeScreen/Home/hero_section_widget.dart';
import 'package:ai_lab/screens/HomeScreen/Home/recent_analytics_header.dart';
import 'package:ai_lab/screens/HomeScreen/Home/result_item.dart';
import 'package:ai_lab/screens/HomeScreen/Home/top_app_bar_widget.dart';
import 'package:ai_lab/screens/HomeScreen/Home/vital_summary_widget.dart';
import 'package:ai_lab/screens/HomeScreen/report/category_reports_screen.dart';
import 'package:ai_lab/screens/HomeScreen/report/report_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  void _showImageSourceSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A1C1F),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(Icons.photo_library_outlined,
                    color: Color(0xFF00D2FF)),
                title: Text("choose_from_gallery".tr(),
                    style: const TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(ctx);
                  ref.read(homeProvider.notifier).pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera_outlined,
                    color: Color(0xFF00D2FF)),
                title: Text("take_photo_camera".tr(),
                    style: const TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(ctx);
                  ref.read(homeProvider.notifier).pickImage(ImageSource.camera);
                },
              ),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }

  HeroButtonState _mapButtonState(HomeState state) {
    if (!state.hasImage) return HeroButtonState.upload;
    switch (state.status) {
      case HomeStatus.uploading:
        return HeroButtonState.uploading;
      case HomeStatus.analyzing:
        return HeroButtonState.analyzing;
      case HomeStatus.ready:
        return HeroButtonState.resultsReady;
      case HomeStatus.initial:
      case HomeStatus.error:
        return HeroButtonState.readyToAnalyze;
    }
  }

  Map<String, List<LabReportItem>> _groupReportsByCategory(List<LabReportItem> reports) {
    final Map<String, List<LabReportItem>> grouped = {};
    for (final report in reports) {
      String key = report.reportType.trim().isNotEmpty
          ? report.reportType.trim().toLowerCase()
          : (report.category.trim().isNotEmpty
              ? report.category.trim().toLowerCase()
              : 'other');
      grouped.putIfAbsent(key, () => []).add(report);
    }
    return grouped;
  }

  String _categoryDisplayName(String key) {
    switch (key.toLowerCase()) {
      case 'blood':
        return 'cat_blood'.tr();
      case 'urine':
        return 'cat_urine'.tr();
      case 'stool':
        return 'cat_stool'.tr();
      case 'liver':
      case 'biochemistry':
        return 'cat_liver'.tr();
      case 'kidney':
        return 'cat_kidney'.tr();
      case 'hormones':
        return 'cat_hormones'.tr();
      case 'xray':
      case 'x-ray':
        return 'cat_xray'.tr();
      case 'ct':
      case 'mri':
        return 'cat_scans'.tr();
      case 'biopsy':
        return 'cat_biopsy'.tr();
      case 'ecg':
      case 'cardiac':
        return 'cat_cardiac'.tr();
      default:
        if (key == 'other') return 'cat_other'.tr();
        return key.toUpperCase();
    }
  }

  IconData _iconForCategory(String key) {
    switch (key.toLowerCase()) {
      case 'blood':
        return Icons.bloodtype_outlined;
      case 'urine':
        return Icons.water_drop_outlined;
      case 'stool':
      case 'biopsy':
        return Icons.biotech_outlined;
      case 'liver':
      case 'biochemistry':
      case 'kidney':
      case 'hormones':
        return Icons.science_outlined;
      case 'xray':
      case 'x-ray':
      case 'ct':
      case 'mri':
        return Icons.document_scanner_outlined;
      case 'ecg':
      case 'cardiac':
        return Icons.monitor_heart_outlined;
      default:
        return Icons.medical_services_outlined;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scale = AppSize.scale(context);

    final state = ref.watch(homeProvider);
    final controller = ref.read(homeProvider.notifier);

    ref.listen(homeProvider, (prev, next) {
      if (next.status == HomeStatus.error && next.errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.errorMessage!),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
      if (next.status == HomeStatus.ready && prev?.status != HomeStatus.ready) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("خلص التحليل! اضغط الزر الأخضر لمشاهدة النتائج ✅"),
            backgroundColor: Colors.green,
          ),
        );
      }
    });

    return Stack(
      children: [
        Positioned(
          top: -100 * scale,
          right: -80 * scale,
          child: Container(
            width: 400 * scale,
            height: 400 * scale,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  const Color(0xFF111317).withValues(alpha: 0.08),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: -120 * scale,
          left: -80 * scale,
          child: Container(
            width: 450 * scale,
            height: 450 * scale,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  const Color(0xFFEDB1FF).withValues(alpha: 0.06),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),

        SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(
                16 * scale, 12 * scale, 16 * scale, 20 * scale),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TopAppBarWidget(
                  userName: "Ahmed",
                  welcomeText: "operator_welcome",
                  onNotificationsPressed: () {},
                ),

                SizedBox(height: 30 * scale),

                HeroSectionWidget(
                  selectedImage: state.selectedImage,
                  buttonState: _mapButtonState(state),
                  onPickImagePressed: () =>
                      _showImageSourceSheet(context, ref),
                  onAnalyzePressed: controller.analyzeImage,
                  onRemoveImagePressed: controller.removeImage,
                  onViewResultsPressed: () async {
                    final resultData = state.analysisResult;
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            CBCReportScreen(reportData: resultData),
                      ),
                    );
                    controller.goToResults();
                  },
                ),

                SizedBox(height: 32 * scale),

                VitalSummaryWidget(
                  onTotalTestsTap: () {},
                  onNormalResultsTap: () {},
                  onNeedFollowUpTap: () {},
                  onFollowingDoctorsTap: () {},
                ),

                SizedBox(height: 32 * scale),

                RecentAnalyticsHeader(
                  title: "RECENT ANALYTICS",
                  buttonText: "View Ledger",
                  onViewLedgerPressed: () {
                    // الانتقال لصفحة كل التقارير
                    controller.changePage(1);
                  },
                ),

                // ✅ عرض التصنيفات والأقسام التجميعية للتحاليل
                if (state.reportsStatus == ReportsListStatus.loading &&
                    state.reports.isEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: Center(
                      child: CircularProgressIndicator(
                          color: Color(0xFF00D2FF)),
                    ),
                  )
                else if (state.reports.isEmpty)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16 * scale),
                    child: Text(
                      "لا توجد تحاليل مسجلة حالياً",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 13 * scale,
                      ),
                    ),
                  )
                else
                  Builder(builder: (context) {
                    final categoriesMap = _groupReportsByCategory(state.reports);
                    final categories = categoriesMap.entries.toList();

                    return Column(
                      children: [
                        for (int i = 0; i < categories.length; i++) ...[
                          if (i > 0) SizedBox(height: 10 * scale),
                          ResultItemWidget(
                            icon: _iconForCategory(categories[i].key),
                            title: _categoryDisplayName(categories[i].key),
                            subtitle: "عدد الفحوصات: ${categories[i].value.length} تقارير مسجلة",
                            status: "${categories[i].value.length} تقارير",
                            statusColor: const Color(0xFF00D2FF),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => CategoryReportsScreen(
                                    categoryKey: categories[i].key,
                                    categoryTitle: _categoryDisplayName(categories[i].key),
                                    icon: _iconForCategory(categories[i].key),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ],
                    );
                  }),

                SizedBox(height: 32 * scale),

                HealthTrajectoryWidget(
                  title: "Health Trajectory",
                  subtitle: "Stability index is up by 4.2%",
                  barHeights: const [36, 48, 60, 70, 54, 66, 81],
                  accentColor: const Color(0xFF00D2FF),
                  iconColor: AppMyColor.lightLavenderPinkColor,
                ),

                SizedBox(height: 4 * scale),
              ],
            ),
          ),
        ),
      ],
    );
  }
}