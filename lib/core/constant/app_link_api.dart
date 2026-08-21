class AppLinkApi {
  // static const String urlSBase = "10.163.189.209";
  // static const String urlSBase = "10.227.32.209";
  static const String urlSBase = "192.168.1.107";

  // 192.168.1.107
  // 10.163.189.209
  // 127.0.0.1
  static const String urlServer = "http://$urlSBase:8000/";
  static const String urlServerImage = "http://$urlSBase:8000/api/";
  static const String urlServerGetImage = "http://$urlSBase:8000/";

  static const patients = 'patients/';

  static const register = '${patients}register/';
  static const login = '${patients}login/';

  static const analyze = "${urlServerImage}lab-reports/analyze/";
  static const result = "${urlServerImage}lab-reports/result/";
  static const reports = '${patients}my-reports/all/';

  // ─── Chatbot & RAG Endpoints ───
  /// POST http://...:8000/api/chatbot/llama/{report_id}/
  /// Body: {"question": "..."}
  static const String chatReportBase = '${urlServer}api/chatbot/llama/';
  static const String chatbotLlama = '${urlServer}api/chatbot/llama/';

  /// POST http://...:8000/api/chatbot/full-analysis/
  /// Body: {"question": "...", "lab_json": {...}, "previous_json": {...}}
  static const String chatbotFullAnalysis = '${urlServer}api/chatbot/full-analysis/';

  static const analyzeId = "${patients}my-reports/";
  static const String reportAnalyzeBase = '${patients}my-reports/';

  static const String reportsByType = '${patients}my-reports/type/';
  static const String reportsByCategory = '${patients}my-reports/category/';
  static const String reportsByPriority = '${patients}my-reports/priority/';
  static const String reportsByStatus = '${patients}my-reports/status/';
  static const String reportDetail = '${patients}my-reports/detail/';
}