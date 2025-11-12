import 'package:ezdu/features/quiz/models/mock_quiz_vm.dart';
import 'package:flutter/material.dart';

class QuizMockTab extends StatefulWidget {
  const QuizMockTab({super.key});

  @override
  State<StatefulWidget> createState() => _QuizMockTabState();
}

class _QuizMockTabState extends State<QuizMockTab> {
  late MockQuizViewModel viewModel;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    viewModel = MockQuizViewModel();
  }

  @override
  Widget build(BuildContext context) {
    if (viewModel.isQuizActive) {
      return const Center(child: Text('Quiz in progress...'));
    }

    return _currentPage == 0
        ? _buildSubjectPage()
        : _buildLessonTopicTreePage();
  }

  // Page 1: Subject Selection
  Widget _buildSubjectPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text(
            'Choose Subject',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
                    _currentPage = 1;
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
        ],
      ),
    );
  }

  // Page 2: Lessons & Topics Tree View
  Widget _buildLessonTopicTreePage() {
    return Column(
      children: [
        // Header
        Container(
          padding: const EdgeInsets.all(12),
          color: Colors.grey[50],
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _currentPage = 0;
                  });
                },
                child: Row(
                  children: [
                    const Icon(Icons.arrow_back, color: Colors.blue, size: 20),
                    const SizedBox(width: 4),
                    Text(
                      'Back',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.blue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Text(
                'Choose Lessons & Topics:',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
        ),
        // Content
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: _buildLessonTopicTree(),
            ),
          ),
        ),
        // Start Button
        if (viewModel.selectedTopics.isNotEmpty)
          Padding(
            padding: const EdgeInsets.all(12),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    viewModel.startQuiz();
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Text(
                  'Start Quiz',
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
            ),
          ),
      ],
    );
  }

  // Tree View Builder
  List<Widget> _buildLessonTopicTree() {
    List<Widget> treeWidgets = [];
    List<Map> lessonsForSubject = viewModel.getLessonsForSubject();

    for (int i = 0; i < lessonsForSubject.length; i += 2) {
      List<Widget> rowChildren = [];

      // First lesson column
      var lesson = lessonsForSubject[i];
      rowChildren.add(
        Expanded(
          child: _buildLessonColumn(lesson),
        ),
      );

      rowChildren.add(const SizedBox(width: 8));

      // Second lesson column (if exists)
      if (i + 1 < lessonsForSubject.length) {
        var lesson2 = lessonsForSubject[i + 1];
        rowChildren.add(
          Expanded(
            child: _buildLessonColumn(lesson2),
          ),
        );
      } else {
        rowChildren.add(const Expanded(child: SizedBox()));
      }

      treeWidgets.add(Row(children: rowChildren));
      treeWidgets.add(const SizedBox(height: 8));
    }

    return treeWidgets;
  }

  // Build lesson with its topics as tree
  Widget _buildLessonColumn(Map lesson) {
    bool isSelected = viewModel.selectedLessons.contains(lesson['id']);
    List<Map> lessonTopics = viewModel.getTopicsForLesson(lesson['id']);

    // Check if all topics are selected
    bool allTopicsSelected = lessonTopics.isNotEmpty &&
        lessonTopics.every((topic) => viewModel.selectedTopics.contains(topic['id']));

    return Column(
      children: [
        // Lesson Card
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelected ? Colors.blue : Colors.grey[300]!,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(6),
            color: isSelected ? Colors.blue[50] : Colors.white,
          ),
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isSelected) {
                        viewModel.selectedLessons.remove(lesson['id']);
                        // Remove all topics from this lesson
                        for (var topic in lessonTopics) {
                          viewModel.selectedTopics.remove(topic['id']);
                        }
                      } else {
                        viewModel.selectedLessons.add(lesson['id']);
                        // Select all topics under this lesson
                        for (var topic in lessonTopics) {
                          viewModel.selectedTopics.add(topic['id']);
                        }
                      }
                    });
                  },
                  child: Text(
                    lesson['name'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[800],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (isSelected) {
                      viewModel.selectedLessons.remove(lesson['id']);
                      // Remove all topics from this lesson
                      for (var topic in lessonTopics) {
                        viewModel.selectedTopics.remove(topic['id']);
                      }
                    } else {
                      viewModel.selectedLessons.add(lesson['id']);
                      // Select all topics under this lesson
                      for (var topic in lessonTopics) {
                        viewModel.selectedTopics.add(topic['id']);
                      }
                    }
                  });
                },
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: Checkbox(
                    value: allTopicsSelected,
                    onChanged: (_) {},
                    activeColor: Colors.blue,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
              ),
            ],
          ),
        ),
        // Topics (always shown, indented under lesson)
        if (lessonTopics.isNotEmpty)
          Container(
            margin: const EdgeInsets.only(top: 6),
            child: Column(
              children: [
                for (var topic in lessonTopics)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4, left: 12),
                    child: _buildTopicCard(topic),
                  ),
              ],
            ),
          ),
      ],
    );
  }

  // Build individual topic card
  Widget _buildTopicCard(Map topic) {
    bool isSelected = viewModel.selectedTopics.contains(topic['id']);

    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            viewModel.selectedTopics.remove(topic['id']);
          } else {
            viewModel.selectedTopics.add(topic['id']);
          }
        });
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Colors.green : Colors.grey[300]!,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(5),
          color: isSelected ? Colors.green[50] : Colors.white,
        ),
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                topic['name'],
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[700],
                ),
              ),
            ),
            SizedBox(
              width: 18,
              height: 18,
              child: Checkbox(
                value: isSelected,
                onChanged: (_) {},
                activeColor: Colors.green,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
          ],
        ),
      ),
    );
  }
}