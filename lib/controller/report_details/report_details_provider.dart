import 'package:ai_lab/controller/report_details/report_details_controller.dart';
import 'package:ai_lab/controller/report_details/report_details_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final reportDetailsProvider =
    NotifierProvider<ReportDetailsController, ReportDetailsState>(
  ReportDetailsController.new,
);
