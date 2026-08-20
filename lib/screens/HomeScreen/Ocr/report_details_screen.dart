// import 'dart:io';
//
// import 'package:ai_lab/controller/home/home_provider.dart'; // عدّل المسار حسب مكان homeProvider عندك
// import 'package:ai_lab/controller/home/home_state.dart';
// import 'package:ai_lab/models/home/lab_report_models.dart';
// import 'package:ai_lab/screens/HomeScreen/report/report_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:http/http.dart' as http;
//
// class ReportDetailsScreen extends ConsumerStatefulWidget {
//   final LabReportItem report;
//
//   const ReportDetailsScreen({super.key, required this.report});
//
//   @override
//   ConsumerState<ReportDetailsScreen> createState() =>
//       _ReportDetailsScreenState();
// }
//
// class _ReportDetailsScreenState extends ConsumerState<ReportDetailsScreen> {
//   static const _bg = Color(0xFF111317);
//   static const _surface = Color(0xFF1A1C1F);
//   static const _outlineVar = Color(0xFF3C494E);
//   static const _primary = Color(0xFF00D2FF);
//   static const _onSurfaceVar = Color(0xFFBBC9CF);
//   static const _error = Color(0xFFFFB4AB);
//   static const _warning = Color(0xFFF59E0B);
//   static const _grey = Color(0xFF7A8A90);
//
//   bool _isDownloading = false;
//   // true فقط إذا إحنا يلي بلّشنا التحليل من هالصفحة (مشان ما نتفاعل مع
//   // تحليل ثاني عم يصير من مكان تاني بالتطبيق بالغلط)
//   bool _triggeredAnalysis = false;
//
//   Color _statusColor(ReportStatus s) {
//     switch (s) {
//       case ReportStatus.completed:
//       case ReportStatus.reviewed:
//         return _primary;
//       case ReportStatus.processing:
//       case ReportStatus.pending:
//         return _warning;
//       case ReportStatus.rejected:
//         return _error;
//       case ReportStatus.archived:
//         return _grey;
//       case ReportStatus.unknown:
//         return _onSurfaceVar;
//     }
//   }
//
//   String _statusLabel(ReportStatus s) {
//     switch (s) {
//       case ReportStatus.completed:
//         return 'Completed';
//       case ReportStatus.reviewed:
//         return 'Reviewed';
//       case ReportStatus.processing:
//         return 'Processing';
//       case ReportStatus.pending:
//         return 'Pending';
//       case ReportStatus.rejected:
//         return 'Rejected';
//       case ReportStatus.archived:
//         return 'Archived';
//       case ReportStatus.unknown:
//         return 'Unknown';
//     }
//   }
//
//   String _formatDate(DateTime? date) {
//     if (date == null) return '—';
//     const months = [
//       'JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN',
//       'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC'
//     ];
//     return '${months[date.month - 1]} ${date.day}, ${date.year}';
//   }
//
//
//   Future<File?> _downloadImageToTempFile(String url) async {
//     try {
//       debugPrint("IMAGE URL: $url");
//
//       final response = await http.get(Uri.parse(url));
//
//       debugPrint("IMAGE STATUS: ${response.statusCode}");
//       debugPrint("IMAGE SIZE: ${response.bodyBytes.length}");
//
//       if (response.statusCode == 200) {
//         final tempDir =
//         await Directory.systemTemp.createTemp('lab_report_analyze_');
//
//         final file = File('${tempDir.path}/report_image.jpg');
//
//         await file.writeAsBytes(response.bodyBytes);
//
//         debugPrint("TEMP FILE: ${file.path}");
//         debugPrint("TEMP FILE EXISTS: ${await file.exists()}");
//         debugPrint("TEMP FILE SIZE: ${await file.length()}");
//
//         return file;
//       }
//     } catch (e, st) {
//       debugPrint("Download report image error: $e");
//       debugPrint("STACK: $st");
//     }
//
//     return null;
//   }
//   // ─── ينزّل صورة التقرير من السيرفر لملف مؤقت محلي، مشان نقدر نبعتها لتحليل ───
//   // Future<File?> _downloadImageToTempFile(String url) async {
//   //   try {
//   //     final response = await http.get(Uri.parse(url));
//   //     if (response.statusCode == 200) {
//   //       final tempDir =
//   //       await Directory.systemTemp.createTemp('lab_report_analyze_');
//   //       final file = File('${tempDir.path}/report_image.jpg');
//   //       await file.writeAsBytes(response.bodyBytes);
//   //       return file;
//   //     }
//   //   } catch (e) {
//   //     debugPrint("Download report image error: $e");
//   //   }
//   //   return null;
//   // }
//
//   Future<void> _startAnalysis() async {
//     final imageUrl = widget.report.fullImageUrl;
//     if (imageUrl == null) return;
//
//     setState(() => _isDownloading = true);
//
//     print(widget.report.reportId);
//     final file = await _downloadImageToTempFile(imageUrl);
//     setState(() => _isDownloading = false);
//
//     if (file == null) {
//       if (!mounted) return;
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text("تعذر تحميل صورة التقرير، حاول مرة أخرى"),
//           backgroundColor: Colors.redAccent,
//         ),
//       );
//       return;
//     }
//
//     _triggeredAnalysis = true;
//     await ref.read(homeProvider.notifier).analyzeExistingImage(file);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final report = widget.report;
//     final state = ref.watch(homeProvider);
//
//     // ─── نفس آلية ref.listen تبع الهوم بالضبط ───
//     ref.listen<HomeState>(homeProvider, (prev, next) {
//       if (!_triggeredAnalysis) return; // تجاهل أي تحليل مش إحنا يلي بلشناه
//
//       if (next.status == HomeStatus.error && next.errorMessage != null) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(next.errorMessage!),
//             backgroundColor: Colors.redAccent,
//           ),
//         );
//       }
//       if (next.status == HomeStatus.ready && prev?.status != HomeStatus.ready) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text("خلص التحليل! اضغط الزر الأخضر لمشاهدة النتائج ✅"),
//             backgroundColor: Colors.green,
//           ),
//         );
//       }
//     });
//
//     return Scaffold(
//       backgroundColor: _bg,
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF0C0E11),
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: _primary),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: Text(
//           'Report Details',
//           style: GoogleFonts.spaceGrotesk(
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//             color: _primary,
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.fromLTRB(16, 20, 16, 40),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // ─── الصورة (إذا موجودة) ───
//             if (report.hasImage)
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(20),
//                 child: Image.network(
//                   report.fullImageUrl!,
//                   width: double.infinity,
//                   height: 220,
//                   fit: BoxFit.cover,
//                   errorBuilder: (_, __, ___) => _imagePlaceholder(),
//                   loadingBuilder: (context, child, progress) {
//                     if (progress == null) return child;
//                     return SizedBox(
//                       height: 220,
//                       child: Center(
//                         child: CircularProgressIndicator(
//                           color: _primary,
//                           value: progress.expectedTotalBytes != null
//                               ? progress.cumulativeBytesLoaded /
//                               progress.expectedTotalBytes!
//                               : null,
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               )
//             else
//               _imagePlaceholder(),
//
//             const SizedBox(height: 20),
//
//             // ─── العنوان + حالة التقرير ───
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Expanded(
//                   child: Text(
//                     report.title.isNotEmpty ? report.title : report.reportType,
//                     style: GoogleFonts.spaceGrotesk(
//                       fontSize: 22,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//                 Container(
//                   padding:
//                   const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                   decoration: BoxDecoration(
//                     color: _statusColor(report.status).withValues(alpha: 0.1),
//                     borderRadius: BorderRadius.circular(50),
//                   ),
//                   child: Text(
//                     _statusLabel(report.status).toUpperCase(),
//                     style: TextStyle(
//                       fontSize: 11,
//                       fontWeight: FontWeight.w800,
//                       color: _statusColor(report.status),
//                       letterSpacing: 0.5,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//
//             const SizedBox(height: 6),
//
//             if (report.description.isNotEmpty)
//               Text(
//                 report.description,
//                 style: GoogleFonts.manrope(
//                   fontSize: 14,
//                   color: _onSurfaceVar,
//                   height: 1.5,
//                 ),
//               ),
//
//             const SizedBox(height: 24),
//
//             // ─── بطاقة معلومات ───
//             Container(
//               padding: const EdgeInsets.all(18),
//               decoration: BoxDecoration(
//                 color: _surface,
//                 borderRadius: BorderRadius.circular(20),
//                 border: Border.all(color: _outlineVar),
//               ),
//               child: Column(
//                 children: [
//                   _infoRow(Icons.local_hospital_outlined, "المختبر",
//                       report.labName.isNotEmpty ? report.labName : '—'),
//                   _divider(),
//                   _infoRow(Icons.calendar_today_outlined, "تاريخ التقرير",
//                       _formatDate(report.reportDate)),
//                   _divider(),
//                   _infoRow(Icons.category_outlined, "التصنيف",
//                       report.category.isNotEmpty ? report.category : '—'),
//                   _divider(),
//                   _infoRow(Icons.accessibility_new_outlined, "الجزء",
//                       report.bodyPart.isNotEmpty ? report.bodyPart : '—'),
//                   _divider(),
//                   _infoRow(Icons.priority_high_rounded, "الأولوية",
//                       report.priority.isNotEmpty ? report.priority : '—'),
//                   if (report.cost != null) ...[
//                     _divider(),
//                     _infoRow(Icons.payments_outlined, "التكلفة",
//                         "${report.cost!.toStringAsFixed(2)} \$"),
//                   ],
//                 ],
//               ),
//             ),
//
//             const SizedBox(height: 32),
//
//             // ─── منطقة التحليل: تختفي بالكامل لو ما في صورة ───
//             _buildAnalysisArea(report, state),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _imagePlaceholder() {
//     return Container(
//       width: double.infinity,
//       height: 220,
//       decoration: BoxDecoration(
//         color: _surface,
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(color: _outlineVar),
//       ),
//       child: const Center(
//         child: Icon(Icons.image_not_supported_outlined,
//             color: _onSurfaceVar, size: 48),
//       ),
//     );
//   }
//
//   Widget _infoRow(IconData icon, String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10),
//       child: Row(
//         children: [
//           Icon(icon, color: _primary, size: 18),
//           const SizedBox(width: 12),
//           Text(label,
//               style: GoogleFonts.manrope(fontSize: 13, color: _onSurfaceVar)),
//           const Spacer(),
//           Text(
//             value,
//             style: GoogleFonts.manrope(
//               fontSize: 13,
//               fontWeight: FontWeight.w600,
//               color: Colors.white,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _divider() =>
//       Container(height: 1, color: _outlineVar.withValues(alpha: 0.4));
//
//   // ─── منطقة زر التحليل: كل الحالات ───
//   Widget _buildAnalysisArea(LabReportItem report, HomeState state) {
//     // ما في صورة أصلاً بهالتقرير → ما في خيار تحليل، خلص
//     if (!report.hasImage) {
//       return Container(
//         width: double.infinity,
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: _surface,
//           borderRadius: BorderRadius.circular(16),
//           border: Border.all(color: _outlineVar),
//         ),
//         child: Row(
//           children: [
//             const Icon(Icons.info_outline, color: _onSurfaceVar, size: 20),
//             const SizedBox(width: 10),
//             Expanded(
//               child: Text(
//                 "لا توجد صورة مرفقة بهذا التقرير لتحليلها",
//                 style: GoogleFonts.manrope(
//                     fontSize: 13, color: _onSurfaceVar),
//               ),
//             ),
//           ],
//         ),
//       );
//     }
//
//     // عم ننزّل الصورة
//     if (_isDownloading) {
//       return _busyButton("جاري تحميل الصورة...");
//     }
//
//     // إحنا بلّشنا تحليل من هالصفحة، وعم ينتظر
//     if (_triggeredAnalysis &&
//         (state.status == HomeStatus.uploading ||
//             state.status == HomeStatus.analyzing)) {
//       return _busyButton(
//         state.status == HomeStatus.uploading
//             ? "UPLOADING..."
//             : "جاري التحليل باستخدام AI",
//       );
//     }
//
//     // خلص وجاهز
//     if (_triggeredAnalysis && state.status == HomeStatus.ready) {
//       return SizedBox(
//         width: double.infinity,
//         child: ElevatedButton.icon(
//           onPressed: () async {
//             final resultData = state.analysisResult;
//             await Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (_) => CBCReportScreen(reportData: resultData),
//               ),
//             );
//             // نصفّر حالة التحليل العامة، ونرجع الزر لوضعه الأصلي بهالصفحة
//             ref.read(homeProvider.notifier).goToResults();
//             setState(() => _triggeredAnalysis = false);
//           },
//           icon: const Icon(Icons.check_circle, color: Colors.white),
//           label: const Text(
//             "اذهب معنا لمشاهدة النتائج",
//             style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
//           ),
//           style: ElevatedButton.styleFrom(
//             backgroundColor: const Color(0xFF2ECC71),
//             padding: const EdgeInsets.symmetric(vertical: 16),
//             shape:
//             RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
//           ),
//         ),
//       );
//     }
//
//     // صار خطأ بمحاولة سابقة من هالصفحة → إذا بدك تحاول تاني
//     final showRetryLabel =
//         _triggeredAnalysis && state.status == HomeStatus.error;
//
//     // ─── الحالة الافتراضية: زر ابدأ التحليل ───
//     return SizedBox(
//       width: double.infinity,
//       child: ElevatedButton.icon(
//         onPressed: () {
//           setState(() => _triggeredAnalysis = false); // إعادة ضبط قبل محاولة جديدة
//           _startAnalysis();
//         },
//         icon: const Icon(Icons.document_scanner_outlined, color: Colors.black),
//         label: Text(
//           showRetryLabel ? "حاول التحليل مرة أخرى" : "تحليل بالذكاء الاصطناعي (OCR)",
//           style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
//         ),
//         style: ElevatedButton.styleFrom(
//           backgroundColor: _primary,
//           padding: const EdgeInsets.symmetric(vertical: 16),
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
//         ),
//       ),
//     );
//   }
//
//   Widget _busyButton(String label) {
//     return SizedBox(
//       width: double.infinity,
//       child: ElevatedButton.icon(
//         onPressed: null,
//         icon: const SizedBox(
//           width: 18,
//           height: 18,
//           child: CircularProgressIndicator(strokeWidth: 2, color: Colors.black),
//         ),
//         label: Text(
//           label,
//           style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
//         ),
//         style: ElevatedButton.styleFrom(
//           backgroundColor: _primary.withValues(alpha: 0.6),
//           disabledBackgroundColor: _primary.withValues(alpha: 0.6),
//           padding: const EdgeInsets.symmetric(vertical: 16),
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
//         ),
//       ),
//     );
//   }
// }



// ######################
/// todo // تعديل 1 كلاود
// #######################
// import 'dart:io';
// import 'package:ai_lab/controller/home/home_provider.dart';
// import 'package:ai_lab/controller/home/home_state.dart';
// import 'package:ai_lab/models/home/lab_report_models.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:http/http.dart' as http;
//
// class ReportDetailsScreen extends ConsumerStatefulWidget {
//   final LabReportItem report;
//
//   const ReportDetailsScreen({super.key, required this.report});
//
//   @override
//   ConsumerState<ReportDetailsScreen> createState() =>
//       _ReportDetailsScreenState();
// }
//
// class _ReportDetailsScreenState extends ConsumerState<ReportDetailsScreen> {
//   static const _bg = Color(0xFF111317);
//   static const _surface = Color(0xFF1A1C1F);
//   static const _outlineVar = Color(0xFF3C494E);
//   static const _primary = Color(0xFF00D2FF);
//   static const _onSurfaceVar = Color(0xFFBBC9CF);
//   static const _error = Color(0xFFFFB4AB);
//   static const _warning = Color(0xFFF59E0B);
//   static const _grey = Color(0xFF7A8A90);
//
//   bool _isDownloading = false;
//   bool _triggeredAnalysis = false;
//   bool _showResults = false; // ← للتحكم بإظهار/إخفاء قسم النتائج
//
//   // نتيجة التحليل المحلية (إما من الـ report أو من الـ state بعد التحليل)
//   LabAnalysisResult? _localResult;
//
//   @override
//   void initState() {
//     super.initState();
//     // إذا التقرير محلل مسبقاً، نحط النتيجة جاهزة
//     if (widget.report.isAnalyzed && widget.report.aiResult != null) {
//       _localResult = widget.report.aiResult;
//     }
//   }
//
//   Color _statusColor(ReportStatus s) {
//     switch (s) {
//       case ReportStatus.completed:
//       case ReportStatus.reviewed:
//         return _primary;
//       case ReportStatus.processing:
//       case ReportStatus.pending:
//         return _warning;
//       case ReportStatus.rejected:
//         return _error;
//       case ReportStatus.archived:
//         return _grey;
//       case ReportStatus.unknown:
//         return _onSurfaceVar;
//     }
//   }
//
//   String _statusLabel(ReportStatus s) {
//     switch (s) {
//       case ReportStatus.completed:
//         return 'Completed';
//       case ReportStatus.reviewed:
//         return 'Reviewed';
//       case ReportStatus.processing:
//         return 'Processing';
//       case ReportStatus.pending:
//         return 'Pending';
//       case ReportStatus.rejected:
//         return 'Rejected';
//       case ReportStatus.archived:
//         return 'Archived';
//       case ReportStatus.unknown:
//         return 'Unknown';
//     }
//   }
//
//   String _formatDate(DateTime? date) {
//     if (date == null) return '—';
//     const months = [
//       'JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN',
//       'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC'
//     ];
//     return '${months[date.month - 1]} ${date.day}, ${date.year}';
//   }
//
//   Color _testStatusColor(String status) {
//     final s = status.toLowerCase();
//     if (s.contains('critical')) return const Color(0xFFEF4444);
//     if (s.contains('high') || s.contains('low')) return const Color(0xFFF59E0B);
//     if (s.contains('normal')) return const Color(0xFF10B981);
//     return const Color(0xFF00D2FF);
//   }
//
//   Future<File?> _downloadImageToTempFile(String url) async {
//     try {
//       final response = await http.get(Uri.parse(url));
//       if (response.statusCode == 200) {
//         final tempDir =
//         await Directory.systemTemp.createTemp('lab_report_analyze_');
//         final file = File('${tempDir.path}/report_image.jpg');
//         await file.writeAsBytes(response.bodyBytes);
//         return file;
//       }
//     } catch (e) {
//       debugPrint("Download report image error: $e");
//     }
//     return null;
//   }
//
//   Future<void> _startAnalysis() async {
//     final imageUrl = widget.report.fullImageUrl;
//     if (imageUrl == null) return;
//
//     setState(() => _isDownloading = true);
//     final file = await _downloadImageToTempFile(imageUrl);
//     setState(() => _isDownloading = false);
//
//     if (file == null) {
//       if (!mounted) return;
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text("تعذر تحميل صورة التقرير، حاول مرة أخرى"),
//           backgroundColor: Colors.redAccent,
//         ),
//       );
//       return;
//     }
//
//     _triggeredAnalysis = true;
//     await ref.read(homeProvider.notifier).analyzeExistingImage(file);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final report = widget.report;
//     final state = ref.watch(homeProvider);
//
//     // الاستماع لنتيجة التحليل
//     ref.listen<HomeState>(homeProvider, (prev, next) {
//       if (!_triggeredAnalysis) return;
//
//       if (next.status == HomeStatus.error && next.errorMessage != null) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(next.errorMessage!),
//             backgroundColor: Colors.redAccent,
//           ),
//         );
//       }
//
//       if (next.status == HomeStatus.ready && prev?.status != HomeStatus.ready) {
//         setState(() {
//           _localResult = next.analysisResult;
//           _showResults = true; // نفتح النتائج تلقائياً
//         });
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text("تم التحليل بنجاح ✅"),
//             backgroundColor: Colors.green,
//           ),
//         );
//       }
//     });
//
//     return Scaffold(
//       backgroundColor: _bg,
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF0C0E11),
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: _primary),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: Text(
//           'Report Details',
//           style: GoogleFonts.spaceGrotesk(
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//             color: _primary,
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.fromLTRB(16, 20, 16, 40),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // ─── الصورة ───
//             if (report.hasImage)
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(20),
//                 child: Image.network(
//                   report.fullImageUrl!,
//                   width: double.infinity,
//                   height: 220,
//                   fit: BoxFit.cover,
//                   errorBuilder: (_, __, ___) => _imagePlaceholder(),
//                 ),
//               )
//             else
//               _imagePlaceholder(),
//
//             const SizedBox(height: 20),
//
//             // ─── العنوان + الحالة ───
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Expanded(
//                   child: Text(
//                     report.title.isNotEmpty ? report.title : report.reportType,
//                     style: GoogleFonts.spaceGrotesk(
//                       fontSize: 22,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//                 Container(
//                   padding:
//                   const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                   decoration: BoxDecoration(
//                     color: _statusColor(report.status).withValues(alpha: 0.1),
//                     borderRadius: BorderRadius.circular(50),
//                   ),
//                   child: Text(
//                     _statusLabel(report.status).toUpperCase(),
//                     style: TextStyle(
//                       fontSize: 11,
//                       fontWeight: FontWeight.w800,
//                       color: _statusColor(report.status),
//                       letterSpacing: 0.5,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 6),
//             if (report.description.isNotEmpty)
//               Text(
//                 report.description,
//                 style: GoogleFonts.manrope(
//                   fontSize: 14,
//                   color: _onSurfaceVar,
//                   height: 1.5,
//                 ),
//               ),
//
//             const SizedBox(height: 24),
//
//             // ─── بطاقة المعلومات ───
//             Container(
//               padding: const EdgeInsets.all(18),
//               decoration: BoxDecoration(
//                 color: _surface,
//                 borderRadius: BorderRadius.circular(20),
//                 border: Border.all(color: _outlineVar),
//               ),
//               child: Column(
//                 children: [
//                   _infoRow(Icons.local_hospital_outlined, "المختبر",
//                       report.labName.isNotEmpty ? report.labName : '—'),
//                   _divider(),
//                   _infoRow(Icons.calendar_today_outlined, "تاريخ التقرير",
//                       _formatDate(report.reportDate)),
//                   _divider(),
//                   _infoRow(Icons.category_outlined, "التصنيف",
//                       report.category.isNotEmpty ? report.category : '—'),
//                   _divider(),
//                   _infoRow(Icons.accessibility_new_outlined, "الجزء",
//                       report.bodyPart.isNotEmpty ? report.bodyPart : '—'),
//                   _divider(),
//                   _infoRow(Icons.priority_high_rounded, "الأولوية",
//                       report.priority.isNotEmpty ? report.priority : '—'),
//                   if (report.cost != null) ...[
//                     _divider(),
//                     _infoRow(Icons.payments_outlined, "التكلفة",
//                         "${report.cost!.toStringAsFixed(2)} \$"),
//                   ],
//                 ],
//               ),
//             ),
//
//             const SizedBox(height: 32),
//
//             // ─── منطقة التحليل / النتائج ───
//             _buildAnalysisArea(report, state),
//
//             // ─── قسم النتائج (يظهر عند الضغط أو بعد التحليل) ───
//             if (_showResults && _localResult != null) ...[
//               const SizedBox(height: 24),
//               _buildResultsSection(_localResult!),
//             ],
//           ],
//         ),
//       ),
//     );
//   }
//
//   // ─────────────────────────────────────────────
//   // منطقة الأزرار (تحليل أو رؤية النتائج)
//   // ─────────────────────────────────────────────
//   Widget _buildAnalysisArea(LabReportItem report, HomeState state) {
//     if (!report.hasImage) {
//       return _infoBox("لا توجد صورة مرفقة بهذا التقرير لتحليلها");
//     }
//
//     // عم ينزّل الصورة أو عم يحلل
//     if (_isDownloading ||
//         (_triggeredAnalysis &&
//             (state.status == HomeStatus.uploading ||
//                 state.status == HomeStatus.analyzing))) {
//       return _busyButton(
//         _isDownloading
//             ? "جاري تحميل الصورة..."
//             : (state.status == HomeStatus.uploading
//             ? "UPLOADING..."
//             : "جاري التحليل باستخدام AI"),
//       );
//     }
//
//     // النتيجة موجودة (إما من السيرفر أو بعد التحليل)
//     final hasResult = _localResult != null;
//
//     if (hasResult) {
//       return Column(
//         children: [
//           SizedBox(
//             width: double.infinity,
//             child: ElevatedButton.icon(
//               onPressed: () {
//                 setState(() => _showResults = !_showResults);
//               },
//               icon: Icon(
//                 _showResults
//                     ? Icons.visibility_off_outlined
//                     : Icons.visibility_outlined,
//                 color: Colors.white,
//               ),
//               label: Text(
//                 _showResults ? "إخفاء نتائج التحليل" : "رؤية نتائج التحليل",
//                 style: const TextStyle(
//                     fontWeight: FontWeight.bold, color: Colors.white),
//               ),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFF2ECC71),
//                 padding: const EdgeInsets.symmetric(vertical: 16),
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(50)),
//               ),
//             ),
//           ),
//         ],
//       );
//     }
//
//     // ما في نتيجة → زر بدء التحليل
//     final showRetry = _triggeredAnalysis && state.status == HomeStatus.error;
//
//     return SizedBox(
//       width: double.infinity,
//       child: ElevatedButton.icon(
//         onPressed: () {
//           setState(() => _triggeredAnalysis = false);
//           _startAnalysis();
//         },
//         icon: const Icon(Icons.document_scanner_outlined, color: Colors.black),
//         label: Text(
//           showRetry
//               ? "حاول التحليل مرة أخرى"
//               : "تحليل بالذكاء الاصطناعي (OCR)",
//           style: const TextStyle(
//               fontWeight: FontWeight.bold, color: Colors.black),
//         ),
//         style: ElevatedButton.styleFrom(
//           backgroundColor: _primary,
//           padding: const EdgeInsets.symmetric(vertical: 16),
//           shape:
//           RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
//         ),
//       ),
//     );
//   }
//
//   // ─────────────────────────────────────────────
//   // قسم عرض النتائج (بنفس الصفحة)
//   // ─────────────────────────────────────────────
//   Widget _buildResultsSection(LabAnalysisResult result) {
//     final tests = result.tests;
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'نتائج التحليل',
//           style: GoogleFonts.spaceGrotesk(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//             color: _primary,
//           ),
//         ),
//         const SizedBox(height: 12),
//
//         if (tests.isEmpty)
//           _infoBox("لا توجد فحوصات مستخرجة")
//         else
//           ...tests.map((test) {
//             final color = _testStatusColor(test.status);
//             return Container(
//               margin: const EdgeInsets.only(bottom: 12),
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: _surface,
//                 borderRadius: BorderRadius.circular(16),
//                 border: Border.all(color: _outlineVar),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Expanded(
//                         child: Text(
//                           test.displayTitle,
//                           style: GoogleFonts.spaceGrotesk(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                       Text(
//                         test.value.isNotEmpty ? test.value : '-',
//                         style: GoogleFonts.spaceGrotesk(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                           color: color,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     '${test.referenceRange} ${test.unit}',
//                     style: GoogleFonts.manrope(
//                         fontSize: 12, color: _onSurfaceVar),
//                   ),
//                   const SizedBox(height: 8),
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(999),
//                     child: LinearProgressIndicator(
//                       value: test.progress,
//                       backgroundColor: const Color(0xFF333538),
//                       valueColor: AlwaysStoppedAnimation<Color>(color),
//                       minHeight: 6,
//                     ),
//                   ),
//                   const SizedBox(height: 6),
//                   Text(
//                     test.statusAr.isNotEmpty ? test.statusAr : test.status,
//                     style: GoogleFonts.manrope(
//                       fontSize: 13,
//                       fontWeight: FontWeight.w600,
//                       color: color,
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           }),
//
//         const SizedBox(height: 20),
//
//         // زر التحدث مع الشات
//         SizedBox(
//           width: double.infinity,
//           child: ElevatedButton.icon(
//             onPressed: () {
//               // TODO: روح على الشات مع سياق التقرير
//               // مثال: Navigator.push(... ChatScreen(reportId: widget.report.reportId));
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(
//                     content: Text('سيتم فتح الشات مع نتائج هذا التقرير قريباً')),
//               );
//             },
//             icon: const Icon(Icons.chat_bubble_outline, color: Colors.white),
//             label: const Text(
//               'تحدث مع الشات حول هذا التحليل',
//               style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
//             ),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: const Color(0xFF6E208C),
//               padding: const EdgeInsets.symmetric(vertical: 16),
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(50)),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   // ─── Helpers ───
//   Widget _imagePlaceholder() {
//     return Container(
//       width: double.infinity,
//       height: 220,
//       decoration: BoxDecoration(
//         color: _surface,
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(color: _outlineVar),
//       ),
//       child: const Center(
//         child: Icon(Icons.image_not_supported_outlined,
//             color: _onSurfaceVar, size: 48),
//       ),
//     );
//   }
//
//   Widget _infoRow(IconData icon, String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10),
//       child: Row(
//         children: [
//           Icon(icon, color: _primary, size: 18),
//           const SizedBox(width: 12),
//           Text(label,
//               style: GoogleFonts.manrope(fontSize: 13, color: _onSurfaceVar)),
//           const Spacer(),
//           Text(
//             value,
//             style: GoogleFonts.manrope(
//               fontSize: 13,
//               fontWeight: FontWeight.w600,
//               color: Colors.white,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _divider() =>
//       Container(height: 1, color: _outlineVar.withValues(alpha: 0.4));
//
//   Widget _infoBox(String text) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: _surface,
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: _outlineVar),
//       ),
//       child: Row(
//         children: [
//           const Icon(Icons.info_outline, color: _onSurfaceVar, size: 20),
//           const SizedBox(width: 10),
//           Expanded(
//             child: Text(text,
//                 style: GoogleFonts.manrope(fontSize: 13, color: _onSurfaceVar)),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _busyButton(String label) {
//     return SizedBox(
//       width: double.infinity,
//       child: ElevatedButton.icon(
//         onPressed: null,
//         icon: const SizedBox(
//           width: 18,
//           height: 18,
//           child: CircularProgressIndicator(strokeWidth: 2, color: Colors.black),
//         ),
//         label: Text(
//           label,
//           style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
//         ),
//         style: ElevatedButton.styleFrom(
//           backgroundColor: _primary.withValues(alpha: 0.6),
//           disabledBackgroundColor: _primary.withValues(alpha: 0.6),
//           padding: const EdgeInsets.symmetric(vertical: 16),
//           shape:
//           RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
//         ),
//       ),
//     );
//   }
// }

// ######################
/// todo // تعديل 2 كلاود
// ######################

import 'dart:io';
import 'package:ai_lab/controller/home/home_provider.dart';
import 'package:ai_lab/controller/home/home_state.dart';
import 'package:ai_lab/models/home/lab_report_models.dart';
import 'package:ai_lab/screens/HomeScreen/report/report_chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class ReportDetailsScreen extends ConsumerStatefulWidget {
  final LabReportItem report;

  const ReportDetailsScreen({super.key, required this.report});

  @override
  ConsumerState<ReportDetailsScreen> createState() =>
      _ReportDetailsScreenState();
}

class _ReportDetailsScreenState extends ConsumerState<ReportDetailsScreen> {
  static const _bg = Color(0xFF111317);
  static const _surface = Color(0xFF1A1C1F);
  static const _outlineVar = Color(0xFF3C494E);
  static const _primary = Color(0xFF00D2FF);
  static const _onSurfaceVar = Color(0xFFBBC9CF);
  static const _error = Color(0xFFFFB4AB);
  static const _warning = Color(0xFFF59E0B);
  static const _grey = Color(0xFF7A8A90);

  bool _isDownloading = false;
  bool _triggeredAnalysis = false;
  bool _showResults = false; // ← للتحكم بإظهار/إخفاء قسم النتائج

  // نتيجة التحليل المحلية (إما من الـ report أو من الـ state بعد التحليل)
  LabAnalysisResult? _localResult;

  @override
  void initState() {
    super.initState();
    // إذا التقرير محلل مسبقاً، نحط النتيجة جاهزة ونعرضها فوراً بدون ضغطة إضافية
    if (widget.report.isAnalyzed && widget.report.aiResult != null) {
      _localResult = widget.report.aiResult;
      _showResults = true; // ✅ جديد: يفتح مباشرة لأنو المستخدم أصلاً ضغط "عرض النتائج" ليوصل لهون
    }
  }

  Color _statusColor(ReportStatus s) {
    switch (s) {
      case ReportStatus.completed:
      case ReportStatus.reviewed:
        return _primary;
      case ReportStatus.processing:
      case ReportStatus.pending:
        return _warning;
      case ReportStatus.rejected:
        return _error;
      case ReportStatus.archived:
        return _grey;
      case ReportStatus.unknown:
        return _onSurfaceVar;
    }
  }

  String _statusLabel(ReportStatus s) {
    switch (s) {
      case ReportStatus.completed:
        return 'Completed';
      case ReportStatus.reviewed:
        return 'Reviewed';
      case ReportStatus.processing:
        return 'Processing';
      case ReportStatus.pending:
        return 'Pending';
      case ReportStatus.rejected:
        return 'Rejected';
      case ReportStatus.archived:
        return 'Archived';
      case ReportStatus.unknown:
        return 'Unknown';
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '—';
    const months = [
      'JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN',
      'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC'
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  Color _testStatusColor(String status) {
    final s = status.toLowerCase();
    if (s.contains('critical')) return const Color(0xFFEF4444);
    if (s.contains('high') || s.contains('low')) return const Color(0xFFF59E0B);
    if (s.contains('normal')) return const Color(0xFF10B981);
    return const Color(0xFF00D2FF);
  }

  Future<File?> _downloadImageToTempFile(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final tempDir =
        await Directory.systemTemp.createTemp('lab_report_analyze_');
        final file = File('${tempDir.path}/report_image.jpg');
        await file.writeAsBytes(response.bodyBytes);
        return file;
      }
    } catch (e) {
      debugPrint("Download report image error: $e");
    }
    return null;
  }

  Future<void> _startAnalysis() async {
    final imageUrl = widget.report.fullImageUrl;
    if (imageUrl == null) return;

    setState(() => _isDownloading = true);
    final file = await _downloadImageToTempFile(imageUrl);
    setState(() => _isDownloading = false);

    if (file == null) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("تعذر تحميل صورة التقرير، حاول مرة أخرى"),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    _triggeredAnalysis = true;
    await ref.read(homeProvider.notifier).analyzeExistingImage(file);
  }

  @override
  Widget build(BuildContext context) {
    final report = widget.report;
    final state = ref.watch(homeProvider);

    // الاستماع لنتيجة التحليل
    ref.listen<HomeState>(homeProvider, (prev, next) {
      if (!_triggeredAnalysis) return;

      if (next.status == HomeStatus.error && next.errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.errorMessage!),
            backgroundColor: Colors.redAccent,
          ),
        );
      }

      if (next.status == HomeStatus.ready && prev?.status != HomeStatus.ready) {
        setState(() {
          _localResult = next.analysisResult;
          _showResults = true; // نفتح النتائج تلقائياً
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("تم التحليل بنجاح ✅"),
            backgroundColor: Colors.green,
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
        title: Text(
          'Report Details',
          style: GoogleFonts.spaceGrotesk(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: _primary,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── الصورة ───
            if (report.hasImage)
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  report.fullImageUrl!,
                  width: double.infinity,
                  height: 220,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => _imagePlaceholder(),
                ),
              )
            else
              _imagePlaceholder(),

            const SizedBox(height: 20),

            // ─── العنوان + الحالة ───
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    report.title.isNotEmpty ? report.title : report.reportType,
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: _statusColor(report.status).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text(
                    _statusLabel(report.status).toUpperCase(),
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: _statusColor(report.status),
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            if (report.description.isNotEmpty)
              Text(
                report.description,
                style: GoogleFonts.manrope(
                  fontSize: 14,
                  color: _onSurfaceVar,
                  height: 1.5,
                ),
              ),

            const SizedBox(height: 24),

            // ─── بطاقة المعلومات ───
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: _surface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: _outlineVar),
              ),
              child: Column(
                children: [
                  _infoRow(Icons.local_hospital_outlined, "المختبر",
                      report.labName.isNotEmpty ? report.labName : '—'),
                  _divider(),
                  _infoRow(Icons.calendar_today_outlined, "تاريخ التقرير",
                      _formatDate(report.reportDate)),
                  _divider(),
                  _infoRow(Icons.category_outlined, "التصنيف",
                      report.category.isNotEmpty ? report.category : '—'),
                  _divider(),
                  _infoRow(Icons.accessibility_new_outlined, "الجزء",
                      report.bodyPart.isNotEmpty ? report.bodyPart : '—'),
                  _divider(),
                  _infoRow(Icons.priority_high_rounded, "الأولوية",
                      report.priority.isNotEmpty ? report.priority : '—'),
                  if (report.cost != null) ...[
                    _divider(),
                    _infoRow(Icons.payments_outlined, "التكلفة",
                        "${report.cost!.toStringAsFixed(2)} \$"),
                  ],
                ],
              ),
            ),

            const SizedBox(height: 32),

            // ─── منطقة التحليل / النتائج ───
            _buildAnalysisArea(report, state),

            // ─── قسم النتائج (يظهر عند الضغط أو بعد التحليل) ───
            if (_showResults && _localResult != null) ...[
              const SizedBox(height: 24),
              _buildResultsSection(_localResult!),
            ],
          ],
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────
  // منطقة الأزرار (تحليل أو رؤية النتائج)
  // ─────────────────────────────────────────────
  Widget _buildAnalysisArea(LabReportItem report, HomeState state) {
    if (!report.hasImage) {
      return _infoBox("لا توجد صورة مرفقة بهذا التقرير لتحليلها");
    }

    // عم ينزّل الصورة أو عم يحلل
    if (_isDownloading ||
        (_triggeredAnalysis &&
            (state.status == HomeStatus.uploading ||
                state.status == HomeStatus.analyzing))) {
      return _busyButton(
        _isDownloading
            ? "جاري تحميل الصورة..."
            : (state.status == HomeStatus.uploading
            ? "UPLOADING..."
            : "جاري التحليل باستخدام AI"),
      );
    }

    // النتيجة موجودة (إما من السيرفر أو بعد التحليل)
    final hasResult = _localResult != null;

    if (hasResult) {
      return Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                setState(() => _showResults = !_showResults);
              },
              icon: Icon(
                _showResults
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: Colors.white,
              ),
              label: Text(
                _showResults ? "إخفاء نتائج التحليل" : "رؤية نتائج التحليل",
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2ECC71),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
              ),
            ),
          ),
        ],
      );
    }

    // ما في نتيجة → زر بدء التحليل
    final showRetry = _triggeredAnalysis && state.status == HomeStatus.error;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {
          setState(() => _triggeredAnalysis = false);
          _startAnalysis();
        },
        icon: const Icon(Icons.document_scanner_outlined, color: Colors.black),
        label: Text(
          showRetry
              ? "حاول التحليل مرة أخرى"
              : "تحليل بالذكاء الاصطناعي (OCR)",
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: _primary,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────
  // قسم عرض النتائج (بنفس الصفحة)
  // ─────────────────────────────────────────────
  Widget _buildResultsSection(LabAnalysisResult result) {
    final tests = result.tests;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'نتائج التحليل',
          style: GoogleFonts.spaceGrotesk(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: _primary,
          ),
        ),
        const SizedBox(height: 12),

        if (tests.isEmpty)
          _infoBox("لا توجد فحوصات مستخرجة")
        else
          ...tests.map((test) {
            final color = _testStatusColor(test.status);
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: _outlineVar),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          test.displayTitle,
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Text(
                        test.value.isNotEmpty ? test.value : '-',
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${test.referenceRange} ${test.unit}',
                    style: GoogleFonts.manrope(
                        fontSize: 12, color: _onSurfaceVar),
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(999),
                    child: LinearProgressIndicator(
                      value: test.progress,
                      backgroundColor: const Color(0xFF333538),
                      valueColor: AlwaysStoppedAnimation<Color>(color),
                      minHeight: 6,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    test.statusAr.isNotEmpty ? test.statusAr : test.status,
                    style: GoogleFonts.manrope(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: color,
                    ),
                  ),
                ],
              ),
            );
          }),

        const SizedBox(height: 20),

        // // زر التحدث مع الشات
        // SizedBox(
        //   width: double.infinity,
        //   child: ElevatedButton.icon(
        //     onPressed: () {
        //       // TODO: روح على الشات مع سياق التقرير
        //       // مثال: Navigator.push(... ChatScreen(reportId: widget.report.reportId));
        //       ScaffoldMessenger.of(context).showSnackBar(
        //         const SnackBar(
        //             content: Text('سيتم فتح الشات مع نتائج هذا التقرير قريباً')),
        //       );
        //     },
        //     icon: const Icon(Icons.chat_bubble_outline, color: Colors.white),
        //     label: const Text(
        //       'تحدث مع الشات حول هذا التحليل',
        //       style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        //     ),
        //     style: ElevatedButton.styleFrom(
        //       backgroundColor: const Color(0xFF6E208C),
        //       padding: const EdgeInsets.symmetric(vertical: 16),
        //       shape: RoundedRectangleBorder(
        //           borderRadius: BorderRadius.circular(50)),
        //     ),
        //   ),
        // ),


        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ReportChatScreen(
                    reportId: widget.report.reportId, // أو widget.report.reportId
                    reportTitle: widget.report.title.isNotEmpty
                        ? widget.report.title
                        : widget.report.reportType,
                  ),
                ),
              );
            },
            icon: const Icon(Icons.chat_bubble_outline, color: Colors.white),
            label: const Text(
              'تحدث مع الشات حول هذا التحليل',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6E208C),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
        )
      ],
    );
  }

  // ─── Helpers ───
  Widget _imagePlaceholder() {
    return Container(
      width: double.infinity,
      height: 220,
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _outlineVar),
      ),
      child: const Center(
        child: Icon(Icons.image_not_supported_outlined,
            color: _onSurfaceVar, size: 48),
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(icon, color: _primary, size: 18),
          const SizedBox(width: 12),
          Text(label,
              style: GoogleFonts.manrope(fontSize: 13, color: _onSurfaceVar)),
          const Spacer(),
          Text(
            value,
            style: GoogleFonts.manrope(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() =>
      Container(height: 1, color: _outlineVar.withValues(alpha: 0.4));

  Widget _infoBox(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _outlineVar),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline, color: _onSurfaceVar, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(text,
                style: GoogleFonts.manrope(fontSize: 13, color: _onSurfaceVar)),
          ),
        ],
      ),
    );
  }

  Widget _busyButton(String label) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: null,
        icon: const SizedBox(
          width: 18,
          height: 18,
          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.black),
        ),
        label: Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: _primary.withValues(alpha: 0.6),
          disabledBackgroundColor: _primary.withValues(alpha: 0.6),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        ),
      ),
    );
  }
}