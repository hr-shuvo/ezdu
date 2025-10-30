import 'package:ezdu/features/archive/models/archive_model.dart';
import 'package:flutter/material.dart';

class ArchiveReviewPage extends StatefulWidget {
  const ArchiveReviewPage({super.key, required ArchiveModel archivedExam});

  @override
  State<ArchiveReviewPage> createState() => _ArchiveReviewPageState();
}

class _ArchiveReviewPageState extends State<ArchiveReviewPage> {
  // load examDetails from futurerepository(archivedExam.id)
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Archive Exam details")));
  }
}
