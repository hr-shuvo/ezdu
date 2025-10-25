import 'package:ezdu/data/models/lesson_model.dart';
import 'package:ezdu/data/models/subject_model.dart';
import 'package:ezdu/data/models/topic_model.dart';
import 'package:ezdu/features/forum/models/forum_model.dart';
import 'package:flutter/material.dart';

class CreatePostScreen extends StatefulWidget {
  final List<Subject> subjects;
  final Map<int, List<Lesson>> lessons;
  final Map<int, List<Topic>> topics;
  final Function(ForumPost) onPostCreated;

  const CreatePostScreen({
    super.key,
    required this.subjects,
    required this.lessons,
    required this.topics,
    required this.onPostCreated,
  });

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}
