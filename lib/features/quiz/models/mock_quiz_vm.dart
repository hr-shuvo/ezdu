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

  dynamic selectedSubject;
  Set<dynamic> selectedLessons = {};
  Set<String> selectedTopics = {};
  bool isQuizActive = false;

  /// Get lessons for the selected subject
  List<Map> getLessonsForSubject() {
    if (selectedSubject == null) return [];
    return lessons[selectedSubject] ?? [];
  }

  /// Get topics for a specific lesson
  List<Map> getTopicsForLesson(dynamic lessonId) {
    String key = '$selectedSubject-$lessonId';
    return topics[key] ?? [];
  }

  /// Get all topics for selected lessons (kept for backward compatibility)
  List<Map> getTopicsForLessons() {
    if (selectedLessons.isEmpty) return [];
    List<Map> allTopics = [];
    for (var lessonId in selectedLessons) {
      String key = '$selectedSubject-$lessonId';
      allTopics.addAll(topics[key] ?? []);
    }
    return allTopics;
  }

  /// Start the quiz
  void startQuiz() {
    if (selectedTopics.isNotEmpty) {
      isQuizActive = true;
      // Add your quiz start logic here
    }
  }

  /// Reset the quiz
  void resetQuiz() {
    selectedSubject = null;
    selectedLessons.clear();
    selectedTopics.clear();
    isQuizActive = false;
  }
}