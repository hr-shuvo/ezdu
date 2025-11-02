import 'package:ezdu/app/di/injector.dart';
import 'package:ezdu/features/archive/models/archive_model.dart';
import 'package:ezdu/features/archive/pages/archive_quiz_play_page.dart';
import 'package:ezdu/features/archive/widgets/archive_exam_header_card.dart';
import 'package:ezdu/features/archive/widgets/archive_exam_start_card.dart';
import 'package:ezdu/features/archive/widgets/archive_question_preview_card.dart';
import 'package:ezdu/features/archive/widgets/archive_quiz_setting_dialog.dart';
import 'package:flutter/material.dart';

class ArchiveQuizStartPage extends StatefulWidget {
  final ArchiveModel archivedExam;

  const ArchiveQuizStartPage({super.key, required this.archivedExam});

  @override
  State<ArchiveQuizStartPage> createState() => _ArchiveQuizStartPageState();
}

class _ArchiveQuizStartPageState extends State<ArchiveQuizStartPage> {
  late ArchiveModel examDetails;
  bool isLoading = false;

  void showQuizSettingsDialog() {
    showDialog(
      context: context,
      builder: (context) => ArchiveQuizSettingsDialog(
        examDetails: examDetails,
        onConfirm: (settings) {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ArchiveQuizPlayPage(
                archiveModel: examDetails,
                settings: settings,
                progressRepository: sl(),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    examDetails = widget.archivedExam;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Archive Exam Details'),
        centerTitle: true,
        elevation: 0,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ArchiveExamHeaderCard(archiveModel: examDetails),
                    const SizedBox(height: 24),
                    ArchiveExamStatsCard(archiveModel: examDetails),
                    const SizedBox(height: 24),
                    ArchiveQuestionsPreviewCard(archiveModel: examDetails),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: showQuizSettingsDialog,
                        icon: const Icon(Icons.play_arrow),
                        label: const Text('Start Quiz'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.primary,
                          foregroundColor: Theme.of(
                            context,
                          ).colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
