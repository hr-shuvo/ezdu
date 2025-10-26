import 'package:ezdu/data/models/onboarding_selection_model.dart';
import 'package:ezdu/services/app_status_service.dart';
import 'package:flutter_riverpod/legacy.dart';

class OnboardingSelectionNotifier extends StateNotifier<OnboardingSelectionModel> {
  OnboardingSelectionNotifier()
    : super(
        OnboardingSelectionModel(
          selectedSegment: null,
          selectedClass: null,
          selectedGroup: null,
        ),
      );

  void updateSegment(String segment) {
    state = state.copyWith(
      selectedSegment: segment,
      selectedClass: null,
      selectedGroup: null,
    );
    _logState('Segment updated to: $segment');
  }

  void updateClass(String classLevel) {
    state = state.copyWith(
        selectedClass: classLevel,
        selectedGroup: null);
    _logState('Class updated to: $classLevel');
  }

  void updateGroup(String? group) {
    state = state.copyWith(selectedGroup: group);
    _logState('Group updated to: $group');
  }

  void finalizeOnboarding() {
    state = state.copyWith(isCompleted: true);
    _logState('Onboarding Finalized!');
  }

  void _logState(String action) {
    print('--- $action ---');
    print(state.toString());
  }
}

final onboardingSelectionProvider =
    StateNotifierProvider<
      OnboardingSelectionNotifier,
      OnboardingSelectionModel
    >((ref) {
      return OnboardingSelectionNotifier();
    });
