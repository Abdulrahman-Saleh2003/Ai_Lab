class AppLinkApi {
  // static const String urlServer = "http://192.168.16.209:8000/api/";
  // static const String urlServer = "http://192.168.1.106:8000/";
  //  10.227.32.209
  // 192.168.1.102
  // static const String urlServer = "http://192.168.1.102:8000/";

  static const String urlServer = "http://10.227.32.209:8000/";
  static const String urlServerImage = "http://10.227.32.209:8000/api/";
  static const String urlServerGetImage = "http://10.227.32.209:8000/";


  // static const String urlServer = "http://192.168.1.107:8000/";


  // static const String urlServer = "http://10.224.142.209:8000/api/";


  // static const String urlServerImage = "http://192.168.1.107:8000/api/";
  // static const String urlServerGetImage = "http://192.168.1.107:8000/";


  // 10.224.142.209:8000
  // static const String urlServer = "http://10.126.104.209:8000/api/";
  // static const String urlServerImage = "http://10.126.104.209:8000";
// http://127.0.0.1:8000/patients/login/
//auth


  static const patients = 'patients/';

  static const register = '${patients}register/';
  static const login = '${patients}login/';

  static const analyze = "${urlServerImage}lab-reports/analyze/";
  static const result = "${urlServerImage}lab-reports/result/";
  static const reports = '${patients}my-reports/all/';
  // داخل class AppLinkApi
  static const String chatReportBase = '$urlServer/api/chatbot/llama/'; // ⚠️ عدّل baseUrl حسب المتغير الموجود عندك فعلياً

// http://127.0.0.1:8000/api/lab-reports/analyze/
// http://127.0.0.1:8000/api/lab-reports/result/935812a6-aa96-49d1-86da-d23990b071b8/


}