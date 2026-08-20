import 'package:ai_lab/controller/category_selection/category_selection_state.dart';
import 'package:ai_lab/models/home/lab_report_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategorySelectionController extends Notifier<CategorySelectionState> {
  @override
  CategorySelectionState build() {
    return const CategorySelectionState();
  }

  void startSelection(LabReportItem initialReport) {
    state = state.copyWith(
      isSelectionMode: true,
      selectedReports: [initialReport],
    );
  }

  /// Returns true if toggled successfully, false if limit of 2 was reached.
  bool toggleReport(LabReportItem report) {
    if (!state.isSelectionMode) {
      startSelection(report);
      return true;
    }

    final isAlreadySelected = state.isSelected(report.reportId);
    if (isAlreadySelected) {
      final updated = state.selectedReports
          .where((r) => r.reportId != report.reportId)
          .toList();
      state = state.copyWith(
        selectedReports: updated,
        isSelectionMode: updated.isNotEmpty,
      );
      return true;
    } else {
      if (state.selectedReports.length >= 2) {
        return false; // Reached maximum limit of 2 reports
      }
      state = state.copyWith(
        selectedReports: [...state.selectedReports, report],
      );
      return true;
    }
  }

  bool selectLatestTwo(List<LabReportItem> reports) {
    if (reports.length < 2) return false;
    // Assume reports are ordered by newest first, take the first two
    state = state.copyWith(
      isSelectionMode: true,
      selectedReports: [reports[0], reports[1]],
    );
    return true;
  }

  void clearSelection() {
    state = const CategorySelectionState(
      isSelectionMode: false,
      selectedReports: [],
    );
  }
}
