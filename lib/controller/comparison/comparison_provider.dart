import 'package:ai_lab/controller/comparison/comparison_controller.dart';
import 'package:ai_lab/controller/comparison/comparison_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final comparisonProvider =
    NotifierProvider<ComparisonController, ComparisonState>(
  ComparisonController.new,
);
