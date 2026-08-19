import 'dart:io';

checkInternet() async {
  try {
    print("google.com");
    var result = await InternetAddress.lookup("google.com");
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      print("Internet  : yes ");

      return true;
    }
    print("Internet  : no ");

    return false;

  } on SocketException {
    print("Internet  : no ");

    return false;
  }
}
