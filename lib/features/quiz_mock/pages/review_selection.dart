import 'package:ezdu/app/di/injector.dart';
import 'package:ezdu/core/constants/app_constants.dart';
import 'package:ezdu/data/models/lesson_model.dart';
import 'package:ezdu/data/repositories/question_repository.dart';
import 'package:ezdu/features/play/pages/quiz_play_page.dart';
import 'package:ezdu/features/play/widgets/quiz_setting_dialog.dart';
import 'package:ezdu/features/quiz_mock/widgets/revire_lesson_card.dart';
import 'package:flutter/material.dart';

class ReviewSelectionPage extends StatelessWidget {
  final List<LessonWithTopicModel> lessons;
  final Set<int> selectedTopicIds;

  final QuestionRepository questionRepository;

  const ReviewSelectionPage({
    super.key,
    required this.lessons,
    required this.selectedTopicIds,
    required this.questionRepository,
  });

  List<LessonWithTopicModel> _getSelectedLessons() {
    return lessons.where((lesson) {
      final topics = lesson.topics ?? [];
      return topics.any((topic) => selectedTopicIds.contains(topic.id));
    }).toList();
  }

  int _getSelectedTopicsCount() {
    return selectedTopicIds.length;
  }

  void _showQuizSettingsDialog(BuildContext context) async {
    final selectedTopicIdList = selectedTopicIds.toList();

    showDialog(
      context: context,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    final response = await questionRepository.getQuestionsByTopicIds(
      selectedTopicIdList,
    );
    Navigator.pop(context);

    if (response.success) {
      final questions = response.data!.items;

      if (questions.isEmpty) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('No Data'),
            content: const Text(
              'No questions found, choose more or different topics',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
        return;
      }

      showDialog(
        context: context,
        builder: (context) => ArchiveQuizSettingsDialog(
          questions: questions,
          onConfirm: (settings) {
            Navigator.pop(context);

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => QuizPlayPage(
                  questions: questions,
                  settings: settings,
                  progressRepository: sl(),
                  quizType: QuizType.Mock,
                  title: "Mock",
                  quizId: 0,
                ),
              ),
            );
          },
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Error'),
          content: Text(response.message ?? 'Failed to load questions.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedLessons = _getSelectedLessons();
    final selectedCount = _getSelectedTopicsCount();

    return Scaffold(
      appBar: AppBar(title: const Text('Review Selection'), centerTitle: true),
      body: Column(
        children: [
          // Summary Section
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.blue[50],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(
                      selectedLessons.length.toString(),
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    Text(
                      'Lesson${selectedLessons.length > 1 ? 's' : ''}',
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      selectedCount.toString(),
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    Text(
                      'Topic${selectedCount > 1 ? 's' : ''}',
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Selected Lessons & Topics List
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  for (var lesson in selectedLessons)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: ReviewLessonCard(
                        lesson: lesson,
                        selectedTopicIds: selectedTopicIds,
                      ),
                    ),
                ],
              ),
            ),
          ),
          // Start Quiz Button
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[300],
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: Text(
                      'Back',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[800],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _showQuizSettingsDialog(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text(
                      'Start Quiz',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
