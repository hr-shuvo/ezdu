import 'package:ezdu/features/quiz/models/admin_quiz_vm.dart';
import 'package:flutter/material.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _AdminQuizTabState();
}

class _AdminQuizTabState extends State<QuizPage> {
  late AdminQuizViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = AdminQuizViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Admin Created Quizzes',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),

          if (!viewModel.isQuizActive)
            Column(
              children: viewModel.quizzes.map((quiz) {
                bool isExpired = DateTime.parse(quiz['expiryDate']).isBefore(
                    DateTime.now());

                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!, width: 2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    quiz['title'],
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    quiz['subject'],
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: isExpired ? Colors.red[100] : Colors
                                    .green[100],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    isExpired ? Icons.error : Icons
                                        .check_circle,
                                    color: isExpired ? Colors.red : Colors
                                        .green,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    isExpired ? 'Expired' : 'Active',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: isExpired ? Colors.red : Colors
                                          .green,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          quiz['description'],
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Icon(Icons.schedule, size: 16,
                                color: Colors.grey[600]),
                            const SizedBox(width: 6),
                            Text(
                              'Expires: ${quiz['expiryDate']}',
                              style: TextStyle(
                                  fontSize: 12, color: Colors.grey[600]),
                            ),
                            const SizedBox(width: 16),
                            Text(
                              '${quiz['questions'].length} Questions',
                              style: TextStyle(
                                  fontSize: 12, color: Colors.grey[600]),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: !isExpired
                                ? () {
                              setState(() {
                                viewModel.startQuiz(quiz);
                              });
                            }
                                : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isExpired ? Colors.grey : Colors
                                  .purple,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: Text(
                              isExpired ? 'Quiz Expired' : 'Start Quiz',
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            )
          else
            if (!viewModel.isQuizComplete)
              _buildQuizView(viewModel)
            else
              _buildResultsView(viewModel),
        ],
      ),
    );
  }

  Widget _buildQuizView(AdminQuizViewModel vm) {
    var currentQ = vm.selectedQuiz!['questions'][vm.currentQuestionIndex];
    double progress = (vm.currentQuestionIndex + 1) /
        vm.selectedQuiz!['questions'].length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                vm.selectedQuiz!['title'],
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w600),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              'Q${vm.currentQuestionIndex + 1}/${vm.selectedQuiz!['questions']
                  .length}',
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
            valueColor: AlwaysStoppedAnimation(Colors.purple[600]),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Score: ${vm.score}',
          style: const TextStyle(fontSize: 14, color: Colors.grey),
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


  Widget _buildResultsView(AdminQuizViewModel vm) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 40),
        Icon(Icons.check_circle, color: Colors.green, size: 80),
        const SizedBox(height: 16),
        const Text(
          'Quiz Complete!',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          vm.selectedQuiz!['title'],
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        Text(
          'Your Score: ${vm.score} / ${vm.selectedQuiz!['questions'].length}',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 40),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                vm.resetQuiz();
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text(
              'Retake Quiz',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.purple),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text(
              'Back to Quizzes',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.purple),
            ),
          ),
        ),
      ],
    );
  }

}