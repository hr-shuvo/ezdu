import 'package:ezdu/features/quiz/models/mock_quiz_vm.dart';
import 'package:flutter/material.dart';

class QuizMockTab extends StatefulWidget {
  const QuizMockTab({super.key});

  @override
  State<StatefulWidget> createState() => _QuizMockTabState();
}

class _QuizMockTabState extends State<QuizMockTab> {
  late MockQuizViewModel viewModel;

  @override
  void initState() {
    super.initState();

    viewModel = MockQuizViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text(
            'Select Subject, Lessons & Topics',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),

          if (!viewModel.isQuizActive)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Choose Subject:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),

                ...viewModel.subjects.map((subject) {
                  bool isSelected = viewModel.selectedSubject == subject['id'];

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          viewModel.selectedSubject = subject['id'];
                          viewModel.selectedLessons.clear();
                          viewModel.selectedTopics.clear();
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: isSelected ? Colors.blue : Colors.grey[300]!,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                          color: isSelected ? Colors.blue[50] : Colors.white,
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              subject['name'],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[800],
                              ),
                            ),
                            const Icon(Icons.chevron_right, color: Colors.grey),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
                const SizedBox(height: 24),
              ],
            ),

          if (viewModel.selectedSubject != null && !viewModel.isQuizActive)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Choose Lessons (Multiple):',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),
                ...viewModel.getLessonsForSubject().map((lesson) {
                  bool isLessonSelected = viewModel.selectedLessons.contains(
                    lesson['id'],
                  );

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          if (isLessonSelected) {
                            viewModel.selectedLessons.remove(lesson['id']);
                            viewModel.selectedTopics.removeWhere(
                              (t) => t.startsWith('${lesson['id']}-'),
                            );
                          } else {
                            viewModel.selectedLessons.add(lesson['id']);
                          }
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: isLessonSelected
                                ? Colors.blue
                                : Colors.grey[300]!,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                          color: isLessonSelected
                              ? Colors.blue[50]
                              : Colors.white,
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              lesson['name'],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[800],
                              ),
                            ),
                            Checkbox(
                              value: isLessonSelected,
                              onChanged: (_) {},
                              activeColor: Colors.blue,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
                const SizedBox(height: 24),

                const Text(
                  'Choose Topics (Multiple):',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),

                ...viewModel.getTopicsForLessons().map((topic){
                  bool isTopicSelected = viewModel.selectedTopics.contains(topic['id']);

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          if (isTopicSelected) {
                            viewModel.selectedTopics.remove(topic['id']);
                          } else {
                            viewModel.selectedTopics.add(topic['id']);
                          }
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: isTopicSelected ? Colors.blue : Colors.grey[300]!,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                          color: isTopicSelected ? Colors.blue[50] : Colors.white,
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                topic['name'],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey[800],
                                ),
                              ),
                            ),
                            Checkbox(
                              value: isTopicSelected,
                              onChanged: (_) {},
                              activeColor: Colors.blue,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );

                }).toList(),
                const SizedBox(height: 24),

                if (viewModel.selectedTopics.isNotEmpty)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          viewModel.startQuiz();
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text(
                        'Start Quiz',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
              ],
            ),
        ],
      ),
    );
  }
}
