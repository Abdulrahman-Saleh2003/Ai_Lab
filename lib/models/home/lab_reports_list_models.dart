// import 'package:ai_lab/core/constant/app_link_api.dart';
//
// /// ─────────────────────────────────────────────
// /// معلومات المستخدم (جوا الـ patient)
// /// ─────────────────────────────────────────────
// class ReportUser {
//   final String id;
//   final String email;
//   final String name;
//   final String role;
//   final String gender;
//   final DateTime? birthDate;
//   final String phone;
//   final DateTime? createdAt;
//   final DateTime? lastLogin;
//   final String randomCode;
//   final String nationalId;
//
//   const ReportUser({
//     required this.id,
//     required this.email,
//     required this.name,
//     required this.role,
//     required this.gender,
//     this.birthDate,
//     required this.phone,
//     this.createdAt,
//     this.lastLogin,
//     required this.randomCode,
//     required this.nationalId,
//   });
//
//   factory ReportUser.fromJson(Map<String, dynamic> json) {
//     return ReportUser(
//       id: json['id']?.toString() ?? '',
//       email: json['email']?.toString() ?? '',
//       name: json['name']?.toString() ?? '',
//       role: json['role']?.toString() ?? '',
//       gender: json['gender']?.toString() ?? '',
//       birthDate: DateTime.tryParse(json['birth_date']?.toString() ?? ''),
//       phone: json['phone']?.toString() ?? '',
//       createdAt: DateTime.tryParse(json['created_at']?.toString() ?? ''),
//       lastLogin: DateTime.tryParse(json['last_login']?.toString() ?? ''),
//       randomCode: json['random_code']?.toString() ?? '',
//       nationalId: json['national_id']?.toString() ?? '',
//     );
//   }
// }
//
// /// ─────────────────────────────────────────────
// /// معلومات المريض (جوا كل تقرير)
// /// ─────────────────────────────────────────────
// class ReportPatient {
//   final String patientId;
//   final ReportUser user;
//   final String bloodType;
//   final double? height;
//   final double? bmi;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//
//   const ReportPatient({
//     required this.patientId,
//     required this.user,
//     required this.bloodType,
//     this.height,
//     this.bmi,
//     this.createdAt,
//     this.updatedAt,
//   });
//
//   factory ReportPatient.fromJson(Map<String, dynamic> json) {
//     final userJson = json['user'];
//     return ReportPatient(
//       patientId: json['patient_id']?.toString() ?? '',
//       user: userJson is Map
//           ? ReportUser.fromJson(Map<String, dynamic>.from(userJson))
//           : const ReportUser(
//         id: '',
//         email: '',
//         name: '',
//         role: '',
//         gender: '',
//         phone: '',
//         randomCode: '',
//         nationalId: '',
//       ),
//       bloodType: json['blood_type']?.toString() ?? '',
//       height: (json['height'] as num?)?.toDouble(),
//       bmi: (json['bmi'] as num?)?.toDouble(),
//       createdAt: DateTime.tryParse(json['created_at']?.toString() ?? ''),
//       updatedAt: DateTime.tryParse(json['updated_at']?.toString() ?? ''),
//     );
//   }
// }
//
// /// ─────────────────────────────────────────────
// /// حالة التقرير (enum بدل Strings حرة عرضة للغلط)
// /// ─────────────────────────────────────────────
// enum ReportStatus {
//   pending,
//   processing,
//   completed,
//   reviewed,
//   archived,
//   rejected,
//   unknown;
//
//   static ReportStatus fromString(String? value) {
//     switch (value) {
//       case 'pending':
//         return ReportStatus.pending;
//       case 'processing':
//         return ReportStatus.processing;
//       case 'completed':
//         return ReportStatus.completed;
//       case 'reviewed':
//         return ReportStatus.reviewed;
//       case 'archived':
//         return ReportStatus.archived;
//       case 'rejected':
//         return ReportStatus.rejected;
//       default:
//         return ReportStatus.unknown;
//     }
//   }
// }
//
// /// ─────────────────────────────────────────────
// /// التقرير الواحد
// /// ─────────────────────────────────────────────
// class LabReportItem {
//   final String reportId;
//   final ReportPatient patient;
//   final DateTime? reportDate;
//   final DateTime? uploadDate;
//   final String? filePath; // نسبي، لازم نضيفله الـ host
//   final ReportStatus status;
//   final String createdBy;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//   final bool isRecent;
//   final String reportType;
//   final String title;
//   final String description;
//   final String priority;
//   final double? cost;
//   final String internalNotes;
//   final String labName;
//   final String category;
//   final String bodyPart;
//
//   const LabReportItem({
//     required this.reportId,
//     required this.patient,
//     this.reportDate,
//     this.uploadDate,
//     this.filePath,
//     this.status = ReportStatus.unknown,
//     required this.createdBy,
//     this.createdAt,
//     this.updatedAt,
//     this.isRecent = false,
//     required this.reportType,
//     required this.title,
//     required this.description,
//     required this.priority,
//     this.cost,
//     required this.internalNotes,
//     required this.labName,
//     required this.category,
//     required this.bodyPart,
//   });
//
//   factory LabReportItem.fromJson(Map<String, dynamic> json) {
//     final patientJson = json['patient'];
//     return LabReportItem(
//       reportId: json['report_id']?.toString() ?? '',
//       patient: patientJson is Map
//           ? ReportPatient.fromJson(Map<String, dynamic>.from(patientJson))
//           : ReportPatient.fromJson(const {}),
//       reportDate: DateTime.tryParse(json['report_date']?.toString() ?? ''),
//       uploadDate: DateTime.tryParse(json['upload_date']?.toString() ?? ''),
//       filePath: json['file_path']?.toString(),
//       status: ReportStatus.fromString(json['status']?.toString()),
//       createdBy: json['created_by']?.toString() ?? '',
//       createdAt: DateTime.tryParse(json['created_at']?.toString() ?? ''),
//       updatedAt: DateTime.tryParse(json['updated_at']?.toString() ?? ''),
//       isRecent: json['is_recent'] == true,
//       reportType: json['report_type']?.toString() ?? '',
//       title: json['title']?.toString() ?? '',
//       description: json['description']?.toString() ?? '',
//       priority: json['priority']?.toString() ?? '',
//       cost: double.tryParse(json['cost']?.toString() ?? ''),
//       internalNotes: json['internal_notes']?.toString() ?? '',
//       labName: json['lab_name']?.toString() ?? '',
//       category: json['category']?.toString() ?? '',
//       bodyPart: json['body_part']?.toString() ?? '',
//     );
//   }
//
//   /// ─── الرابط الكامل للصورة، جاهز يتحط مباشرة بـ Image.network ───
//   /// بيرجع null إذا ما في file_path أصلاً (متل بعض التقارير بالـ JSON)
//   String? get fullImageUrl {
//     if (filePath == null || filePath!.isEmpty) return null;
//     // AppLinkApi.urlServerGetImage لازم تنتهي بـ "/"، وfilePath عادةً بيبلش بـ "/"
//     // فمنشيل التكرار لو صار
//     final base = AppLinkApi.urlServerGetImage.endsWith('/')
//         ? AppLinkApi.urlServerGetImage.substring(
//         0, AppLinkApi.urlServerGetImage.length - 1)
//         : AppLinkApi.urlServerGetImage;
//     final path = filePath!.startsWith('/') ? filePath! : '/$filePath';
//     return '$base$path';
//   }
//
//   bool get hasImage => fullImageUrl != null;
// }
//
// /// ─────────────────────────────────────────────
// /// الرد الكامل من endpoint قائمة التقارير
// /// ─────────────────────────────────────────────
// class LabReportsResponse {
//   final String message;
//   final String patientName;
//   final int totalCount;
//   final List<LabReportItem> results;
//
//   const LabReportsResponse({
//     required this.message,
//     required this.patientName,
//     required this.totalCount,
//     required this.results,
//   });
//
//   factory LabReportsResponse.fromJson(Map<String, dynamic> json) {
//     final resultsJson = json['results'];
//     return LabReportsResponse(
//       message: json['message']?.toString() ?? '',
//       patientName: json['patient_name']?.toString() ?? '',
//       totalCount: (json['total_count'] as num?)?.toInt() ?? 0,
//       results: resultsJson is List
//           ? resultsJson
//           .whereType<Map>()
//           .map((r) => LabReportItem.fromJson(Map<String, dynamic>.from(r)))
//           .toList()
//           : const [],
//     );
//   }
// }