import 'package:ezdu/app/di/injector.dart';
import 'package:ezdu/core/models/api_response.dart';
import 'package:ezdu/data/models/subject_model.dart';
import 'package:ezdu/data/repositories/subject_repository.dart';
import 'package:ezdu/features/quiz_mock/pages/lesson_topic_selection.dart';
import 'package:ezdu/features/quiz_mock/pages/subject_selection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuizMockTab extends ConsumerStatefulWidget {
  const QuizMockTab({super.key, required this.subjectRepository});

  final SubjectRepository subjectRepository;

  @override
  ConsumerState<QuizMockTab> createState() => _QuizMockTabState();
}

class _QuizMockTabState extends ConsumerState<QuizMockTab> {
  late Future<ApiResponse<PagedList<SubjectModel>>> _subjectListFuture;
  bool isQuizActive = false;

  @override
  void initState() {
    super.initState();
    _subjectListFuture = widget.subjectRepository.getSubjectList();
  }

  void _onSubjectSelected(SubjectModel subject) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            LessonTopicSelectionPage(subject: subject, lessonRepository: sl()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isQuizActive) {
      return const Center(child: Text('Quiz in progress...'));
    }

    return SubjectSelectionPage(
      subjectListFuture: _subjectListFuture,
      onSubjectSelected: _onSubjectSelected,
    );
  }
}
