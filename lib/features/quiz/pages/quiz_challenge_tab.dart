import 'package:ezdu/features/quiz/models/challenge_quiz_vm.dart';
import 'package:flutter/material.dart';

class QuizChallengeTab extends StatefulWidget {
  const QuizChallengeTab({super.key});

  @override
  State<QuizChallengeTab> createState() => _QuizChallengeTabState();
}

class _QuizChallengeTabState extends State<QuizChallengeTab> {
  late ChallengeQuizViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = ChallengeQuizViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Quick Challenge',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const Text(
            'Challenge yourself with quick questions based on your completed lessons!',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 24),

          if (!viewModel.isQuizActive)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    border: Border.all(color: Colors.blue[200]!, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Your Completed Lessons:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ...viewModel.completedLessons.map((lesson) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            children: [
                              Icon(Icons.check, color: Colors.green, size: 20),
                              const SizedBox(width: 8),
                              Text(lesson),
                            ],
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        viewModel.startQuiz();
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(
                      'Start Quick Challenge (${viewModel.questions.length} Questions)',
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            )
          else if (!viewModel.isQuizComplete)
            _buildQuizView(viewModel)
          else
            _buildResultsView(viewModel),
        ],
      ),
    );
  }

  Widget _buildQuizView(ChallengeQuizViewModel vm) {
    var currentQ = vm.questions[vm.currentQuestionIndex];
    double progress = (vm.currentQuestionIndex + 1) / vm.questions.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Question ${vm.currentQuestionIndex + 1} of ${vm.questions.length}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            Text(
              'Score: ${vm.score}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 6,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation(Colors.green[600]),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          currentQ['question'],
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        ...List.generate(currentQ['options'].length, (index) {
          bool isSelected = vm.selectedAnswerIndex == index;
          bool isCorrect = index == currentQ['correct'];

          Color bgColor = Colors.white;
          Color borderColor = Colors.grey[300]!;

          if (isSelected) {
            bgColor = isCorrect ? Colors.green[100]! : Colors.red[100]!;
            borderColor = isCorrect ? Colors.green : Colors.red;
          }

          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: GestureDetector(
              onTap: vm.selectedAnswerIndex == null
                  ? () {
                      setState(() {
                        vm.selectAnswer(index, isCorrect);
                      });
                    }
                  : null,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: borderColor, width: 2),
                  borderRadius: BorderRadius.circular(8),
                  color: bgColor,
                ),
                padding: const EdgeInsets.all(16),
                child: Text(
                  currentQ['options'][index],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[800],
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildResultsView(ChallengeQuizViewModel vm) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 40),
        Icon(Icons.check_circle, color: Colors.green, size: 80),
        const SizedBox(height: 16),
        const Text(
          'Challenge Complete!',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Text(
          'Your Score: ${vm.score} / ${vm.questions.length}',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 40),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                viewModel.resetQuiz();
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text(
              'Back to Challenge',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
