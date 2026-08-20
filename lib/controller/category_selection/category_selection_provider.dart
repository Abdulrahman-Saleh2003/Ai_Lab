import 'package:ai_lab/controller/category_selection/category_selection_controller.dart';
import 'package:ai_lab/controller/category_selection/category_selection_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final categorySelectionProvider =
    NotifierProvider<CategorySelectionController, CategorySelectionState>(
  CategorySelectionController.new,
);
