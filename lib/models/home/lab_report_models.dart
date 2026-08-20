import 'package:ai_lab/core/constant/app_link_api.dart';

// ═══════════════════════════════════════════════════════════
// القسم 1: موديلات نتيجة تحليل صورة واحدة (Job Polling)
// ═══════════════════════════════════════════════════════════

class LabTest {
  final String alias;
  final String testName;
  final String value;
  final String unit;
  final String referenceRange;
  final String flag;
  final String referenceRangeSource;
  final String? matchedReferenceTest;
  final double? matchConfidence;
  final String status;
  final String statusAr;
  final num? distanceFromNormal;
  final int? timestamp;

  const LabTest({
    required this.alias,
    required this.testName,
    required this.value,
    required this.unit,
    required this.referenceRange,
    this.flag = '',
    this.referenceRangeSource = '',
    this.matchedReferenceTest,
    this.matchConfidence,
    this.status = '',
    this.statusAr = '',
    this.distanceFromNormal,
    this.timestamp,
  });

  factory LabTest.fromJson(Map<String, dynamic> json) {
    return LabTest(
      alias: json['alias']?.toString() ?? '',
      testName: json['test_name']?.toString() ?? '',
      value: json['value']?.toString() ?? '',
      unit: json['unit']?.toString() ?? '',
      referenceRange: json['reference_range']?.toString() ?? '',
      flag: json['flag']?.toString() ?? '',
      referenceRangeSource: json['reference_range_source']?.toString() ?? '',
      matchedReferenceTest: json['matched_reference_test']?.toString(),
      matchConfidence: (json['match_confidence'] as num?)?.toDouble(),
      status: json['status']?.toString() ?? '',
      statusAr: json['status_ar']?.toString() ?? '',
      distanceFromNormal: json['distance_from_normal'] as num?,
      timestamp: json['timestamp'] as int?,
    );
  }

  String get displayTitle => alias.isNotEmpty ? alias : testName;
  bool get isNormal => status.toLowerCase().contains('normal');
  bool get isCritical => status.toLowerCase().contains('critical');
  bool get isHighOrLow =>
      status.toLowerCase().contains('high') || status.toLowerCase().contains('low');

  double get progress {
    try {
      final val = double.tryParse(value.replaceAll(',', '.'));
      final parts = referenceRange.split('-');
      if (val == null || parts.length != 2) return 0.5;
      final lo = double.tryParse(parts[0].trim());
      final hi = double.tryParse(parts[1].trim());
      if (lo == null || hi == null || hi <= lo) return 0.5;
      return ((val - lo) / (hi - lo)).clamp(0.0, 1.0);
    } catch (_) {
      return 0.5;
    }
  }
}

class ReportPanel {
  final String panelName;
  final List<LabTest> tests;

  const ReportPanel({required this.panelName, required this.tests});

  factory ReportPanel.fromJson(Map<String, dynamic> json) {
    final testsJson = json['tests'];
    return ReportPanel(
      panelName: json['panel_name']?.toString() ?? '',
      tests: testsJson is List
          ? testsJson
              .whereType<Map>()
              .map((t) => LabTest.fromJson(Map<String, dynamic>.from(t)))
              .toList()
          : const [],
    );
  }
}

class CurrentReport {
  final List<ReportPanel> panels;

  const CurrentReport({required this.panels});

  factory CurrentReport.fromJson(Map<String, dynamic> json) {
    final panelsJson = json['panels'];
    return CurrentReport(
      panels: panelsJson is List
          ? panelsJson
              .whereType<Map>()
              .map((p) => ReportPanel.fromJson(Map<String, dynamic>.from(p)))
              .toList()
          : const [],
    );
  }

  List<LabTest> get allTests => panels.expand((p) => p.tests).toList();
}

class LabAnalysisResult {
  final CurrentReport currentReport;

  const LabAnalysisResult({required this.currentReport});

  factory LabAnalysisResult.fromJson(Map<String, dynamic> json) {
    final currentReportJson = json['current_report'];
    return LabAnalysisResult(
      currentReport: CurrentReport.fromJson(
        currentReportJson is Map
            ? Map<String, dynamic>.from(currentReportJson)
            : const {},
      ),
    );
  }

  List<LabTest> get tests => currentReport.allTests;
}

class LabJobStatus {
  final String status;
  final LabAnalysisResult? result;

  const LabJobStatus({required this.status, this.result});

  factory LabJobStatus.fromJson(Map<String, dynamic> json) {
    final resultJson = json['result'];
    return LabJobStatus(
      status: json['status']?.toString() ?? '',
      result: resultJson is Map
          ? LabAnalysisResult.fromJson(Map<String, dynamic>.from(resultJson))
          : null,
    );
  }

  bool get isDone =>
      status == 'done' || status == 'completed' || status == 'success';
  bool get isFailed => status == 'failed' || status == 'error';
}

// ═══════════════════════════════════════════════════════════
// القسم 2: موديلات قائمة كل التقارير (History List)
// ═══════════════════════════════════════════════════════════

class ReportUser {
  final String id;
  final String email;
  final String name;
  final String role;
  final String gender;
  final DateTime? birthDate;
  final String phone;
  final DateTime? createdAt;
  final DateTime? lastLogin;
  final String randomCode;
  final String nationalId;

  const ReportUser({
    required this.id,
    required this.email,
    required this.name,
    required this.role,
    required this.gender,
    this.birthDate,
    required this.phone,
    this.createdAt,
    this.lastLogin,
    required this.randomCode,
    required this.nationalId,
  });

  factory ReportUser.fromJson(Map<String, dynamic> json) {
    return ReportUser(
      id: json['id']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      role: json['role']?.toString() ?? '',
      gender: json['gender']?.toString() ?? '',
      birthDate: DateTime.tryParse(json['birth_date']?.toString() ?? ''),
      phone: json['phone']?.toString() ?? '',
      createdAt: DateTime.tryParse(json['created_at']?.toString() ?? ''),
      lastLogin: DateTime.tryParse(json['last_login']?.toString() ?? ''),
      randomCode: json['random_code']?.toString() ?? '',
      nationalId: json['national_id']?.toString() ?? '',
    );
  }
}

class ReportPatient {
  final String patientId;
  final ReportUser user;
  final String bloodType;
  final double? height;
  final double? bmi;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const ReportPatient({
    required this.patientId,
    required this.user,
    required this.bloodType,
    this.height,
    this.bmi,
    this.createdAt,
    this.updatedAt,
  });

  factory ReportPatient.fromJson(Map<String, dynamic> json) {
    final userJson = json['user'];
    return ReportPatient(
      patientId: json['patient_id']?.toString() ?? '',
      user: userJson is Map
          ? ReportUser.fromJson(Map<String, dynamic>.from(userJson))
          : const ReportUser(
              id: '',
              email: '',
              name: '',
              role: '',
              gender: '',
              phone: '',
              randomCode: '',
              nationalId: '',
            ),
      bloodType: json['blood_type']?.toString() ?? '',
      height: (json['height'] as num?)?.toDouble(),
      bmi: (json['bmi'] as num?)?.toDouble(),
      createdAt: DateTime.tryParse(json['created_at']?.toString() ?? ''),
      updatedAt: DateTime.tryParse(json['updated_at']?.toString() ?? ''),
    );
  }
}

enum ReportStatus {
  pending,
  processing,
  completed,
  reviewed,
  archived,
  rejected,
  unknown;

  static ReportStatus fromString(String? value) {
    switch (value) {
      case 'pending':
        return ReportStatus.pending;
      case 'processing':
        return ReportStatus.processing;
      case 'completed':
        return ReportStatus.completed;
      case 'reviewed':
        return ReportStatus.reviewed;
      case 'archived':
        return ReportStatus.archived;
      case 'rejected':
        return ReportStatus.rejected;
      default:
        return ReportStatus.unknown;
    }
  }
}

class LabReportItem {
  final String reportId;
  final ReportPatient patient;
  final DateTime? reportDate;
  final DateTime? uploadDate;
  final String? filePath;
  final ReportStatus status;
  final String createdBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool isRecent;
  final String reportType;
  final String title;
  final String description;
  final String priority;
  final double? cost;
  final String internalNotes;
  final String labName;
  final String category;
  final String bodyPart;
  final bool isAnalyzed;
  final LabAnalysisResult? aiResult;

  const LabReportItem({
    required this.reportId,
    required this.patient,
    this.reportDate,
    this.uploadDate,
    this.filePath,
    this.status = ReportStatus.unknown,
    required this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.isRecent = false,
    required this.reportType,
    required this.title,
    required this.description,
    required this.priority,
    this.cost,
    required this.internalNotes,
    required this.labName,
    required this.category,
    required this.bodyPart,
    this.isAnalyzed = false,
    this.aiResult,
  });

  factory LabReportItem.fromJson(Map<String, dynamic> json) {
    final patientJson = json['patient'];
    final aiResultJson = json['ai_result'];

    return LabReportItem(
      reportId: json['report_id']?.toString() ?? '',
      patient: patientJson is Map
          ? ReportPatient.fromJson(Map<String, dynamic>.from(patientJson))
          : ReportPatient.fromJson(const {}),
      reportDate: DateTime.tryParse(json['report_date']?.toString() ?? ''),
      uploadDate: DateTime.tryParse(json['upload_date']?.toString() ?? ''),
      filePath: json['file_path']?.toString(),
      status: ReportStatus.fromString(json['status']?.toString()),
      createdBy: json['created_by']?.toString() ?? '',
      createdAt: DateTime.tryParse(json['created_at']?.toString() ?? ''),
      updatedAt: DateTime.tryParse(json['updated_at']?.toString() ?? ''),
      isRecent: json['is_recent'] == true,
      reportType: json['report_type']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      priority: json['priority']?.toString() ?? '',
      cost: double.tryParse(json['cost']?.toString() ?? ''),
      internalNotes: json['internal_notes']?.toString() ?? '',
      labName: json['lab_name']?.toString() ?? '',
      category: json['category']?.toString() ?? '',
      bodyPart: json['body_part']?.toString() ?? '',
      isAnalyzed: json['is_analyzed'] == true,
      aiResult: (aiResultJson is Map && aiResultJson.isNotEmpty)
          ? LabAnalysisResult.fromJson(Map<String, dynamic>.from(aiResultJson))
          : null,
    );
  }

  String? get fullImageUrl {
    if (filePath == null || filePath!.isEmpty) return null;
    final base = AppLinkApi.urlServerGetImage.endsWith('/')
        ? AppLinkApi.urlServerGetImage
            .substring(0, AppLinkApi.urlServerGetImage.length - 1)
        : AppLinkApi.urlServerGetImage;
    final path = filePath!.startsWith('/') ? filePath! : '/$filePath';
    return '$base$path';
  }

  bool get hasImage => fullImageUrl != null;

  LabReportItem copyWith({
    bool? isAnalyzed,
    LabAnalysisResult? aiResult,
  }) {
    return LabReportItem(
      reportId: reportId,
      patient: patient,
      reportDate: reportDate,
      uploadDate: uploadDate,
      filePath: filePath,
      status: status,
      createdBy: createdBy,
      createdAt: createdAt,
      updatedAt: updatedAt,
      isRecent: isRecent,
      reportType: reportType,
      title: title,
      description: description,
      priority: priority,
      cost: cost,
      internalNotes: internalNotes,
      labName: labName,
      category: category,
      bodyPart: bodyPart,
      isAnalyzed: isAnalyzed ?? this.isAnalyzed,
      aiResult: aiResult ?? this.aiResult,
    );
  }
}

class LabReportsResponse {
  final String message;
  final String patientName;
  final int totalCount;
  final List<LabReportItem> results;

  const LabReportsResponse({
    required this.message,
    required this.patientName,
    required this.totalCount,
    required this.results,
  });

  factory LabReportsResponse.fromJson(Map<String, dynamic> json) {
    final resultsJson = json['results'];
    return LabReportsResponse(
      message: json['message']?.toString() ?? '',
      patientName: json['patient_name']?.toString() ?? '',
      totalCount: (json['total_count'] as num?)?.toInt() ?? 0,
      results: resultsJson is List
          ? resultsJson
              .whereType<Map>()
              .map((r) => LabReportItem.fromJson(Map<String, dynamic>.from(r)))
              .toList()
          : const [],
    );
  }
}