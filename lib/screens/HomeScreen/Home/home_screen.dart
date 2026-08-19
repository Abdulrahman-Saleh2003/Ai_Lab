
import 'package:ai_lab/controller/home/home_provider.dart'; // عدّل المسار حسب مكان homeProvider عندك
import 'package:ai_lab/controller/home/home_state.dart';
import 'package:ai_lab/core/constant/app_color.dart';
import 'package:ai_lab/screens/HomeScreen/Home/health_trajectory.dart';
import 'package:ai_lab/screens/HomeScreen/Home/hero_section_widget.dart';
import 'package:ai_lab/screens/HomeScreen/Home/recent_analytics_header.dart';
import 'package:ai_lab/screens/HomeScreen/Home/result_item.dart';
import 'package:ai_lab/screens/HomeScreen/Home/top_app_bar_widget.dart';
import 'package:ai_lab/screens/HomeScreen/Home/vital_summary_widget.dart';
import 'package:ai_lab/screens/HomeScreen/report/report_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:easy_localization/easy_localization.dart';

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
                title: const Text("اختيار من المعرض",
                    style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(ctx);
                  ref.read(homeProvider.notifier).pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera_outlined,
                    color: Color(0xFF00D2FF)),
                title: const Text("التقاط صورة بالكاميرا",
                    style: TextStyle(color: Colors.white)),
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

  // تحويل حالة الـ state لحالة الزر يلي الـ widget فاهمها
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.sizeOf(context);
    final scale = size.width / 375;

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
        // Background Glows
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
            padding:
            EdgeInsets.fromLTRB(16 * scale, 12 * scale, 16 * scale, 20 * scale),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TopAppBarWidget(
                  userName: "Ahmed",
                  welcomeText: "operator_welcome".tr(),
                  onNotificationsPressed: () => print("تم الضغط على الإشعارات"),
                ),

                SizedBox(height: 30 * scale),

                HeroSectionWidget(
                  selectedImage: state.selectedImage,
                  buttonState: _mapButtonState(state),
                  onPickImagePressed: () => _showImageSourceSheet(context, ref),
                  onAnalyzePressed: controller.analyzeImage,
                  onRemoveImagePressed: controller.removeImage,
                  onViewResultsPressed: () async {
                    // ناخد نسخة من النتيجة قبل ما نصفّر الحالة
                    final resultData = state.analysisResult;

                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CBCReportScreen(reportData: resultData),
                      ),
                    );

                    // لما يرجع من صفحة النتائج (زر الرجوع)، الهوم بترجع
                    // تلقائياً لوضعها الأصلي (زر Upload)
                    controller.goToResults();
                  },
                ),

                SizedBox(height: 32 * scale),

                VitalSummaryWidget(
                  onTotalTestsTap: () => print("Total Tests tapped"),
                  onNormalResultsTap: () => print("Normal Results tapped"),
                  onNeedFollowUpTap: () => print("Need Follow-up tapped"),
                  onFollowingDoctorsTap: () => print("Following Doctors tapped"),
                ),

                SizedBox(height: 32 * scale),

                RecentAnalyticsHeader(
                  title: "RECENT ANALYTICS",
                  buttonText: "View Ledger",
                  onViewLedgerPressed: () => print("View Ledger Pressed"),
                ),

                Column(
                  children: [
                    ResultItemWidget(
                      icon: Icons.bloodtype,
                      title: "Comprehensive Blood Panel",
                      subtitle: "Oct 12, 2023 • Quest Diagnostics",
                      status: "NORMAL",
                      statusColor: const Color(0xFF00D2FF),
                      onTap: () => print("تم الضغط على البند الأول"),
                    ),
                    SizedBox(height: 10 * scale),
                    ResultItemWidget(
                      icon: Icons.biotech,
                      title: "Thyroid Stimulating Hormone",
                      subtitle: "Oct 08, 2023 • LabCorp HQ",
                      status: "ELEVATED",
                      statusColor: Colors.red,
                      onTap: () {},
                    ),
                    SizedBox(height: 10 * scale),
                    ResultItemWidget(
                      icon: Icons.science,
                      title: "Lipid Profile Beta-Test",
                      subtitle: "Sep 29, 2023 • Bio-Medical Systems",
                      status: "NORMAL",
                      statusColor: const Color(0xFF00D2FF),
                      onTap: () {},
                    ),
                  ],
                ),

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