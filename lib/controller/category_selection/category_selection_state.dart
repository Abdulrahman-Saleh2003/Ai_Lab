import 'package:ai_lab/models/home/lab_report_models.dart';

class CategorySelectionState {
  final bool isSelectionMode;
  final List<LabReportItem> selectedReports;

  const CategorySelectionState({
    this.isSelectionMode = false,
    this.selectedReports = const [],
  });

  bool isSelected(String reportId) {
    return selectedReports.any((r) => r.reportId == reportId);
  }

  int get count => selectedReports.length;
  bool get canCompare => selectedReports.length == 2;

  CategorySelectionState copyWith({
    bool? isSelectionMode,
    List<LabReportItem>? selectedReports,
  }) {
    return CategorySelectionState(
      isSelectionMode: isSelectionMode ?? this.isSelectionMode,
      selectedReports: selectedReports ?? this.selectedReports,
    );
  }
}
