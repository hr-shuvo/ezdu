class OnboardingSelectionModel {
  final String? selectedSegment;
  final String? selectedClass;
  final String? selectedGroup;
  final bool isCompleted;

  OnboardingSelectionModel({
    this.selectedSegment,
    this.selectedClass,
    this.selectedGroup,
    this.isCompleted = false,
  });

  // Helper method for state immutability
  OnboardingSelectionModel copyWith({
    String? selectedSegment,
    String? selectedClass,
    String? selectedGroup,
    bool? isCompleted,
  }) {
    return OnboardingSelectionModel(
      selectedSegment: selectedSegment ?? this.selectedSegment,
      selectedClass: selectedClass ?? this.selectedClass,
      selectedGroup: selectedGroup ?? this.selectedGroup,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  // Debugging utility
  @override
  String toString() {
    return 'OnboardingSelectionModel('
        'segment: $selectedSegment, '
        'class: $selectedClass, '
        'group: $selectedGroup, '
        'completed: $isCompleted)';
  }
}
