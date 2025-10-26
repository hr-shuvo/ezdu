import 'package:ezdu/providers/onboarding_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final Map<String, Map<String, List<String>?>> _onboardingData = {
  'Student': {
    'Class 8': null,
    'Class 9-10': ['Science', 'Arts', 'Commerce'],
    'Class 11-12': ['Science', 'Humanities', 'Business Studies'],
    'University': ['Engineering', 'Medical', 'General'],
  },
  'Job': {
    'BCS Exam': ['General Cadre', 'Technical/Professional Cadre'],
    'Bank Jobs': ['Commercial Bank', 'Specialized Bank', 'Central Bank'],
    'IT/Software': ['Web Development', 'Mobile Development', 'Data Science'],
    'Civil Service': ['Administration', 'Foreign Affairs', 'Taxation'],
  },
  'International Exam': {
    'IELTS': ['Academic', 'General Training'],
    'GRE': ['General Test', 'Subject Test (Physics, Math, etc.)'],
    'TOEFL': null,
  },
};

class StepSegmentSelection extends ConsumerWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;

  const StepSegmentSelection({
    super.key,
    required this.onNext,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<String> segments = _onboardingData.keys.toList();

    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Choose your Main Focus',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: ListView(
            children: segments.map((segmentName) {
              return ListTile(
                leading: segmentName == 'Student'
                    ? const Icon(Icons.school)
                    : segmentName == 'Job'
                    ? const Icon(Icons.work)
                    : const Icon(Icons.language),
                title: Text(segmentName),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  ref
                      .read(onboardingSelectionProvider.notifier)
                      .updateSegment(segmentName);
                  onNext();
                },
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}


class StepClassSelection extends ConsumerWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;

  const StepClassSelection({
    super.key,
    required this.onNext,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentSelection = ref.watch(onboardingSelectionProvider);
    final String? selectedSegment = currentSelection.selectedSegment;

    if (selectedSegment == null) {
      return Center(child: Text("Please go back and select a segment."));
    }

    final Map<String, List<String>?>? classOptions =
        _onboardingData[selectedSegment];

    if (classOptions == null || classOptions.isEmpty) {
      return const Center(
        child: Text("Error: No class options available for this segment."),
      );
    }

    final List<String> classNames = classOptions.keys.toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Select your ${selectedSegment}',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: ListView(
            children: classNames.map((className) {
              return ListTile(
                title: Text(className),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  ref
                      .read(onboardingSelectionProvider.notifier)
                      .updateClass(className);
                  onNext();
                },
              );
            }).toList(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: TextButton(onPressed: onBack, child: const Text('Go Back')),
        ),
      ],
    );
  }
}

class StepGroupSelection extends ConsumerWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;

  const StepGroupSelection({
    super.key,
    required this.onNext,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentSelection = ref.watch(onboardingSelectionProvider);
    final String? segment = currentSelection.selectedSegment;
    final String? className = currentSelection.selectedClass;

    final List<String>? groupOptions = _onboardingData[segment]?[className];

    if (groupOptions == null || groupOptions.isEmpty) {
      return const Center(
        child: Text("Error: No group options available."),
      );
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Choose your Sub-field or Group for $className',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: ListView(
            children: groupOptions.map((groupName) {
              return ListTile(
                title: Text(groupName),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  ref
                      .read(onboardingSelectionProvider.notifier)
                      .updateGroup(groupName);
                  onNext();
                },
              );
            }).toList(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: TextButton(onPressed: onBack, child: const Text('Go Back')),
        ),
      ],
    );
  }
}


class StepFinal extends ConsumerWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;

  const StepFinal({
    super.key,
    required this.onNext,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentSelection = ref.watch(onboardingSelectionProvider);

    return Column(
      children: [
        Expanded(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green[100],
                    ),
                    child: Icon(
                      Icons.check_circle,
                      size: 60,
                      color: Colors.green[700],
                    ),
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    'You\'re All Set!',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Your personalized learning path is ready',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.blue[200]!),
                    ),
                    child: Column(
                      children: [
                        _buildSummaryRow(
                          'Focus Area',
                          currentSelection.selectedSegment ?? 'Not selected',
                          Icons.category,
                        ),
                        const SizedBox(height: 12),
                        _buildSummaryRow(
                          'Level',
                          currentSelection.selectedClass ?? 'Not selected',
                          Icons.layers,
                        ),
                        if (currentSelection.selectedGroup != null) ...[
                          const SizedBox(height: 12),
                          _buildSummaryRow(
                            'Specialization',
                            currentSelection.selectedGroup!,
                            Icons.star,
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[400],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    ref
                        .read(onboardingSelectionProvider.notifier)
                        .finalizeOnboarding();
                    Navigator.of(context).pushReplacementNamed('/home');
                  },
                  child: const Text(
                    'Complete Onboarding',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Back Button
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: onBack,
                  child: const Text(
                    'Go Back',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryRow(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.blue[400]),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}