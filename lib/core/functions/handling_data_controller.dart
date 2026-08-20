import 'package:ai_lab/core/class/status_request.dart';

StatusRequest handingDataController(dynamic response) {
  if (response is StatusRequest) {
    return response;
  } else {
    return StatusRequest.success;
  }
}
