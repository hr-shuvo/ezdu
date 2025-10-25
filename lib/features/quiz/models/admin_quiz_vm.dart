class AdminQuizViewModel {
  final List<Map> quizzes = [
    {
      'id': 1,
      'title': 'Math Final Test',
      'subject': 'Mathematics',
      'description': 'Final examination for algebra and geometry',
      'expiryDate': '2025-12-30',
      'questions': [
        {'question': 'What is 15 × 12?', 'options': ['150', '180', '200', '210'], 'correct': 1},
        {'question': 'What is the square root of 144?', 'options': ['10', '11', '12', '13'], 'correct': 2},
        {'question': 'What is 50 ÷ 2.5?', 'options': ['15', '20', '25', '30'], 'correct': 1}
      ]
    },
    {
      'id': 2,
      'title': 'English Essay Quiz',
      'subject': 'English',
      'description': 'Test your understanding of essay writing',
      'expiryDate': '2025-10-15',
      'questions': []
    },
    {
      'id': 3,
      'title': 'Science Midterm',
      'subject': 'Science',
      'description': 'Physics and chemistry fundamentals',
      'expiryDate': '2025-12-20',
      'questions': [
        {'question': 'What is the SI unit of force?', 'options': ['Joule', 'Newton', 'Pascal', 'Watt'], 'correct': 1},
        {'question': 'What is the atomic number of Carbon?', 'options': ['4', '5', '6', '7'], 'correct': 2},
        {'question': 'What is the formula for kinetic energy?', 'options': ['mgh', '½mv²', 'ma', 'F=ma'], 'correct': 1}
      ]
    }
  ];

  Map? selectedQuiz;
  bool isQuizActive = false;
  bool isQuizComplete = false;
  int currentQuestionIndex = 0;
  int score = 0;
  int? selectedAnswerIndex;

  void startQuiz(Map quiz) {
    selectedQuiz = quiz;
    isQuizActive = true;
    isQuizComplete = false;
    currentQuestionIndex = 0;
    score = 0;
  }

  void selectAnswer(int index, bool isCorrect) {
    selectedAnswerIndex = index;
    if (isCorrect) {
      score++;
    }

    Future.delayed(const Duration(milliseconds: 500), () {
      if (currentQuestionIndex + 1 < selectedQuiz!['questions'].length) {
        currentQuestionIndex++;
        selectedAnswerIndex = null;
      } else {
        isQuizComplete = true;
      }
    });
  }

  void resetQuiz() {
    selectedQuiz = null;
    isQuizActive = false;
    isQuizComplete = false;
    currentQuestionIndex = 0;
    score = 0;
    selectedAnswerIndex = null;
  }
}