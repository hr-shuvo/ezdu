class ChallengeQuizViewModel {
  final List<String> completedLessons = [
    'Mathematics - Algebra',
    'English - Grammar',
    'Science - Physics',
  ];

  final List<Map> questions = [
    {
      'question': 'Quick: What is 7 × 8?',
      'options': ['54', '56', '58', '60'],
      'correct': 1,
    },
    {
      'question': 'Quick: What is the past tense of "go"?',
      'options': ['goed', 'went', 'going', 'gone'],
      'correct': 1,
    },
    {
      'question': 'Quick: What does DNA stand for?',
      'options': [
        'Dynamic Nucleic Acid',
        'Deoxyribonucleic Acid',
        'Digital Nucleic Assembly',
        'Deoxyribo Nuclear Assembly',
      ],
      'correct': 1,
    },
    {
      'question': 'Quick: What is 15 + 27?',
      'options': ['40', '41', '42', '43'],
      'correct': 2,
    },
    {
      'question': 'Quick: What is the capital of France?',
      'options': ['London', 'Berlin', 'Paris', 'Madrid'],
      'correct': 2,
    },
  ];

  bool isQuizActive = false;
  bool isQuizComplete = false;
  int currentQuestionIndex = 0;
  int score = 0;
  int? selectedAnswerIndex;

  void startQuiz() {
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
      if (currentQuestionIndex + 1 < questions.length) {
        currentQuestionIndex++;
        selectedAnswerIndex = null;
      } else {
        isQuizComplete = true;
      }
    });
  }

  void resetQuiz() {
    isQuizActive = false;
    isQuizComplete = false;
    currentQuestionIndex = 0;
    score = 0;
    selectedAnswerIndex = null;
  }
}
