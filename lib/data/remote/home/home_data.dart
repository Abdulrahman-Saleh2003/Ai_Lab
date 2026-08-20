import 'package:ai_lab/core/class/crud.dart';
import 'package:ai_lab/core/constant/app_link_api.dart';

class HomeData {
  final Crud crud;

  HomeData({
    required this.crud,
  });

  Future postData({
    required dynamic image,
  }) async {
    return await crud.addRequestWithImageOne(
      linkUrl: AppLinkApi.analyze,
      image: image,
      data: {},
    );
  }

  Future checkResult(String jobId) async {
    return await crud.getData(
      linkUrl: "${AppLinkApi.result}$jobId/",
    );
  }

  Future getAllReports() async {
    return await crud.getData(
      linkUrl: AppLinkApi.reports,
    );
  }

  Future getReportsByType(String type) async {
    return await crud.getData(
      linkUrl: "${AppLinkApi.reportsByType}$type/",
    );
  }

  Future getReportsByCategory(String category) async {
    return await crud.getData(
      linkUrl: "${AppLinkApi.reportsByCategory}$category/",
    );
  }

  Future getReportsByPriority(String priority) async {
    return await crud.getData(
      linkUrl: "${AppLinkApi.reportsByPriority}$priority/",
    );
  }

  Future getReportsByStatus(String status) async {
    return await crud.getData(
      linkUrl: "${AppLinkApi.reportsByStatus}$status/",
    );
  }

  Future getReportDetail(String reportId) async {
    return await crud.getData(
      linkUrl: "${AppLinkApi.reportDetail}$reportId/",
    );
  }

  Future askReportQuestion({
    required String reportId,
    required String question,
  }) async {
    return await crud.postData(
      linkUrl: "${AppLinkApi.chatbotLlama}$reportId/",
      data: <String, dynamic>{
        "question": question,
      },
    );
  }

  Future askFullAnalysisComparison({
    required String reportId,
    required String previousReportId,
    required String question,
    Map<String, dynamic>? labJson,
    Map<String, dynamic>? previousJson,
  }) async {
    final payload = <String, dynamic>{
      "question": question,
      if (labJson != null) "lab_json": labJson,
      if (previousJson != null) "previous_json": previousJson,
    };
    return await crud.postData(
      linkUrl: "${AppLinkApi.chatbotFullAnalysis}$reportId/$previousReportId/",
      data: payload,
    );
  }

  /// POST /patients/my-reports/{reportId}/analyze/
  Future startReportAnalysis(String reportId) async {
    return await crud.postData(
      linkUrl: "${AppLinkApi.reportAnalyzeBase}$reportId/analyze/",
      data: <String, dynamic>{},
    );
  }

  /// GET /patients/my-reports/{reportId}/status/
  Future getReportAnalysisStatus(String reportId) async {
    return await crud.getData(
      linkUrl: "${AppLinkApi.reportAnalyzeBase}$reportId/status/",
    );
  }

  /// GET /patients/my-reports/{reportId}/analysis-result/
  Future getReportAnalysisResult(String reportId) async {
    return await crud.getData(
      linkUrl: "${AppLinkApi.reportAnalyzeBase}$reportId/analysis-result/",
    );
  }
}