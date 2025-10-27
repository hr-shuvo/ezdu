import 'package:ezdu/data/models/class_model.dart';
import 'package:ezdu/providers/onboarding_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

    final String className = currentSelection.className!;
    final int classId = currentSelection.classId!;
    final List<ClassModel> classes = currentSelection.classList;

    final List<String> groupOptions = classes
        .firstWhere((x) => x.id == classId)
        .groups;

    if (groupOptions.isEmpty) {
      return const Center(child: Text("Error: No group options available."));
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
