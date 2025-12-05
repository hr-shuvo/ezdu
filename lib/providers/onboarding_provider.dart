import 'package:ezdu/app/di/injector.dart';
import 'package:ezdu/data/models/class_model.dart';
import 'package:ezdu/data/repositories/classRepository.dart';
import 'package:ezdu/services/user_onboarding_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class OnboardingState {
  final bool isLoading;
  final int? segment;
  final int? classId;
  final String? className;
  final String? group;
  final List<ClassModel> classList;
  final String? error;

  OnboardingState({
    required this.isLoading,
    required this.segment,
    required this.classId,
    required this.className,
    required this.group,
    required this.classList,
    required this.error,
  });

  const OnboardingState.initial()
    : isLoading = false,
      segment = null,
      classId = null,
      className = null,
      group = null,
      classList = const [],
      error = null;

  OnboardingState copyWithLoading() {
    return OnboardingState(
      isLoading: true,
      segment: null,
      classId: null,
      className: null,
      group: null,
      classList: const [],
      error: null,
    );
  }

  OnboardingState copyWithError(String errorMsg) {
    return OnboardingState(
      isLoading: false,
      segment: null,
      classId: null,
      className: null,
      group: null,
      classList: const [],
      error: errorMsg,
    );
  }

  OnboardingState copyWith({
    bool? isLoading,
    int? segment,
    int? classId,
    String? className,
    List<ClassModel>? classList,
    String? error,
    String? selectedGroup,
  }) {
    return OnboardingState(
      isLoading: isLoading ?? this.isLoading,
      segment: segment ?? this.segment,
      classId: classId ?? this.classId,
      className: className ?? this.className,
      classList: classList ?? this.classList,
      group: selectedGroup ?? group,
      error: error ?? this.error,
    );
  }
}

class OnboardingSelectionNotifier extends StateNotifier<OnboardingState> {
  OnboardingSelectionNotifier(this._classRepository)
    : super(const OnboardingState.initial());

  final ClassRepository _classRepository;

  void updateSegment(int segment) async {
    state = state.copyWithLoading();

    final response = await _classRepository.getOnboardingClassList(segment);

    if (response.success) {
      final classList = response.data!.items;

      state = state.copyWith(
        isLoading: false,
        segment: segment,
        classList: classList,
        classId: null,
        className: null,
        selectedGroup: null,
        error: null,
      );

      // _logState('Segment updated to: $segment');
      // _logState('Classes updated to: $classList');

      // UserOnboardingService.saveSegment(segment);
    } else {
      state = state.copyWithError(response.message ?? "Failed to fetch data");
    }
  }

  void updateClass(int classId) {
    var selectedClassName = state.classList
        .firstWhere((x) => x.id == classId)
        .name;

    state = state.copyWith(
      isLoading: false,
      classId: classId,
      className: selectedClassName,
      selectedGroup: null,
    );

    // _logState('Class updated to: $selectedClassName');
  }

  void updateGroup(String? group) {
    state = state.copyWith(isLoading: false, selectedGroup: group);

    // _logState('Group updated to: $group');
  }

  void finalizeOnboarding() {
    // state = state.copyWith(isCompleted: true);

    UserOnboardingService.saveSegment(state.segment!);
    UserOnboardingService.saveClassId(state.classId!);
    UserOnboardingService.saveClass(state.className!);
    if (state.group != null) {
      UserOnboardingService.saveGroup(state.group!);
    }

    _logState('Onboarding Finalized!');
  }

  void _logState(String action) {
    print('--- onboarding log ---');
    print(action);
    print(
      'segment: ${state.segment}, classId: ${state.classId}, className: ${state.className}, group: ${state.group}',
    );
  }

  Future<void> restoreSession() async {
    final segment = await UserOnboardingService.getSegment();
    final classId = await UserOnboardingService.getClassId();
    final className = await UserOnboardingService.getClass();
    final group = await UserOnboardingService.getGroup();

    if (segment > 0 && classId != null && classId > 0) {
      state = state.copyWith(
        isLoading: false,
        segment: segment,
        classId: classId,
        className: className,
        selectedGroup: group,
      );
    }
  }
}

final onboardingSelectionProvider =
    StateNotifierProvider<OnboardingSelectionNotifier, OnboardingState>((ref) {
      return OnboardingSelectionNotifier(sl<ClassRepository>());
    });

final onboardingInitProvider = FutureProvider<void>((ref) async {
  await ref.read(onboardingSelectionProvider.notifier).restoreSession();
});
