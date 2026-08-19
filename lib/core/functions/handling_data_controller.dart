

import 'package:ai_lab/core/class/status_request.dart';

StatusRequest handingDataController( response) {
  if (response is StatusRequest) {
    // print("handlingDataController");
    // print(response);
    return response;
  } else {
    return StatusRequest
    .success;
  }
}





