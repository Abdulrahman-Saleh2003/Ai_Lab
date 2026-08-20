class AppLinkApi {

  // 10.227.32.209

  static const String urlServer = "http://10.227.32.209:8000/";
  static const String urlServerImage = "http://10.227.32.209:8000/api/";
  static const String urlServerGetImage = "http://10.227.32.209:8000/";


  // 192.168.1.107
  // static const String urlServer = "http://192.168.1.107:8000/";
  // static const String urlServerImage = "http://192.168.1.107:8000/api/";
  // static const String urlServerGetImage = "http://192.168.1.107:8000/";



  // 10.126.104.209
  // static const String urlServer = "http://10.126.104.209:8000/";
  // static const String urlServerImage = "http://10.126.104.209:8000/api/";
  // static const String urlServerGetImage = "http://10.126.104.209:8000/";


  static const patients = 'patients/';

  static const register = '${patients}register/';
  static const login = '${patients}login/';

  static const analyze = "${urlServerImage}lab-reports/analyze/";
  static const result = "${urlServerImage}lab-reports/result/";
  static const reports = '${patients}my-reports/all/';




  static const String chatReportBase = '${urlServer}api/chatbot/llama/';


  static const analyzeId = "${patients}my-reports/";
  // ✅ جديد: تحليل تقرير موجود بالـ report_id
  // POST  patients/my-reports/{id}/analyze/
  // GET   patients/my-reports/{id}/status/
  // GET   patients/my-reports/{id}/analysis-result/
  static const String reportAnalyzeBase = '${patients}my-reports/';



  // ✅ فلاتر التقارير
  static const String reportsByType = '${patients}my-reports/type/';
  static const String reportsByCategory = '${patients}my-reports/category/';
  static const String reportsByPriority = '${patients}my-reports/priority/';
  static const String reportsByStatus = '${patients}my-reports/status/';
  static const String reportDetail = '${patients}my-reports/detail/';




}