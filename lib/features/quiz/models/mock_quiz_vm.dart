class MockQuizViewModel {
  final List<Map> subjects = [
    {'id': 1, 'name': 'Mathematics'},
    {'id': 2, 'name': 'English'},
    {'id': 3, 'name': 'Science'}
  ];

  final Map<int, List<Map>> lessons = {
    1: [
      {'id': 1, 'name': 'Algebra'},
      {'id': 2, 'name': 'Geometry'}
    ],
    2: [
      {'id': 1, 'name': 'Grammar'},
      {'id': 2, 'name': 'Literature'}
    ],
    3: [
      {'id': 1, 'name': 'Physics'},
      {'id': 2, 'name': 'Chemistry'}
    ]
  };

  final Map<String, List<Map>> topics = {
    '1-1': [
      {'id': '1-1-1', 'name': 'Linear Equations'},
      {'id': '1-1-2', 'name': 'Quadratic Equations'}
    ],
    '1-2': [
      {'id': '1-2-1', 'name': 'Triangles'},
      {'id': '1-2-2', 'name': 'Circles'}
    ],
    '2-1': [
      {'id': '2-1-1', 'name': 'Tenses'},
      {'id': '2-1-2', 'name': 'Articles'}
    ],
    '2-2': [
      {'id': '2-2-1', 'name': 'Shakespeare'},
      {'id': '2-2-2', 'name': 'Modern Novels'}
    ],
    '3-1': [
      {'id': '3-1-1', 'name': 'Motion'},
      {'id': '3-1-2', 'name': 'Forces'}
    ],
    '3-2': [
      {'id': '3-2-1', 'name': 'Periodic Table'},
      {'id': '3-2-2', 'name': 'Bonding'}
    ]
  };

  final Map<String, List<Map>> quizzes = {
    '1-1-1': [
      {'question': 'Solve: 2x + 5 = 13', 'options': ['x = 4', 'x = 5', 'x = 3', 'x = 6'], 'correct': 0},
      {'question': 'What is the value of x if 3x - 7 = 2?', 'options': ['x = 2', 'x = 3', 'x = 4', 'x = 5'], 'correct': 1},
      {'question': 'Solve: x/2 = 10', 'options': ['x = 5', 'x = 10', 'x = 20', 'x = 30'], 'correct': 2}
    ],
    '1-1-2': [
      {'question': 'What is the discriminant of x² - 5x + 6?', 'options': ['1', '2', '3', '4'], 'correct': 0},
      {'question': 'Solve: x² = 16', 'options': ['x = 4', 'x = ±4', 'x = -4', 'x = 8'], 'correct': 1}
    ],
    '1-2-1': [
      {'question': 'What is the sum of angles in a triangle?', 'options': ['90°', '180°', '270°', '360°'], 'correct': 1},
      {'question': 'What is the area formula for a triangle?', 'options': ['l×w', '½×b×h', 'πr²', 's²'], 'correct': 1}
    ],
    '1-2-2': [
      {'question': 'What is the circumference formula?', 'options': ['πr²', '2πr', 'πr', 'd²'], 'correct': 1},
      {'question': 'What is the area of a circle with radius 5?', 'options': ['25π', '10π', '50π', '100π'], 'correct': 0}
    ],
    '2-1-1': [
      {'question': 'What is the past tense of "go"?', 'options': ['goed', 'went', 'going', 'gone'], 'correct': 1},
      {'question': 'Which is correct?', 'options': ['She go', 'She goes', 'She going', 'She gone'], 'correct': 1}
    ],
    '2-1-2': [
      {'question': 'Use the correct article: "I saw ___ elephant"', 'options': ['a', 'an', 'the', 'none'], 'correct': 1},
      {'question': 'Which is correct?', 'options': ['a unique', 'an unique', 'the unique', 'unique'], 'correct': 0}
    ]
  };

  int? selectedSubject;
  Set<int> selectedLessons = {};
  Set<String> selectedTopics = {};

  bool isQuizActive = false;
  bool isQuizComplete = false;
  int currentQuestionIndex = 0;
  int score = 0;
  int? selectedAnswerIndex;

  List<Map> getLessonsForSubject() {
    if (selectedSubject == null) return [];
    return lessons[selectedSubject] ?? [];
  }

  List<Map> getTopicsForLessons() {
    List<Map> allTopics = [];
    for (int lessonId in selectedLessons) {
      String key = '$selectedSubject-$lessonId';
      allTopics.addAll(topics[key] ?? []);
    }
    return allTopics;
  }

  List<Map> getSelectedQuestions() {
    List<Map> allQuestions = [];
    for (String topicId in selectedTopics) {
      allQuestions.addAll(quizzes[topicId] ?? []);
    }
    return allQuestions;
  }

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
      List<Map> questions = getSelectedQuestions();
      if (currentQuestionIndex + 1 < questions.length) {
        currentQuestionIndex++;
        selectedAnswerIndex = null;
      } else {
        isQuizComplete = true;
      }
    });
  }

  void resetQuiz() {
    selectedSubject = null;
    selectedLessons.clear();
    selectedTopics.clear();
    isQuizActive = false;
    isQuizComplete = false;
    currentQuestionIndex = 0;
    score = 0;
    selectedAnswerIndex = null;
  }
}