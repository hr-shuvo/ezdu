import 'package:ezdu/core/models/api_response.dart';
import 'package:ezdu/data/models/subject_model.dart';
import 'package:ezdu/data/repositories/subject_repository.dart';
import 'package:ezdu/features/archive/pages/exams_page.dart';
import 'package:ezdu/features/archive/widgets/archive_stat_card.dart';
import 'package:ezdu/features/archive/widgets/archive_subject_card.dart';
import 'package:flutter/material.dart';

class ArchivePage extends StatefulWidget {
  const ArchivePage({super.key, required this.subjectRepository});

  final SubjectRepository subjectRepository;

  @override
  State<ArchivePage> createState() => _ArchivePageState();
}

class _ArchivePageState extends State<ArchivePage> {
  late Future<ApiResponse<PagedList<SubjectModel>>> _subjectListFuture;

  @override
  void initState() {
    super.initState();

    // if (widget.subjectRepository == null) {
    // } else {
    //   _subjectListFuture = widget.subjectRepository!.getSubjectList();
    // }
    _subjectListFuture = widget.subjectRepository.getSubjectList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Archive',
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E293B),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF8FAFC), Color(0xFFF1F5F9)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: StatCard(
                          label: 'Streak',
                          value: '79',
                          icon: '🔥',
                          backgroundColor: Color(0xFFFEF3C7),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: StatCard(
                          label: 'Points',
                          value: '2.5K',
                          icon: '⭐',
                          backgroundColor: Color(0xFFFEF08A),
                        ),
                      ),

                      SizedBox(width: 12),
                      Expanded(
                        child: StatCard(
                          icon: '✅',
                          label: 'Answered',
                          value: '145',
                          backgroundColor: Color(0xFFDCFCE7),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),

                  const Text(
                    '📚 Explore Subjects',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF475569),
                    ),
                  ),
                  const SizedBox(height: 12),

                  FutureBuilder(
                    future: _subjectListFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(),
                              Padding(
                                padding: EdgeInsets.only(top: 16.0),
                                child: Text('Loading subjects...'),
                              ),
                            ],
                          ),
                        );
                      }

                      if (snapshot.hasError) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              'Error loading data: ${snapshot.error}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.red),
                            ),
                          ),
                        );
                      }

                      if (snapshot.hasData &&
                          snapshot.data!.data!.totalCount > 0) {
                        final subjects = snapshot.data!.data!.items;

                        return GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                                childAspectRatio: 0.85,
                              ),
                          itemCount: subjects.length,
                          itemBuilder: (context, index) {
                            final subject = subjects[index];
                            return SubjectCard(
                              subject: subject,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ExamListScreen(subject: subject),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      }

                      return const Center(child: Text('No subjects found.'));
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// const List<SubjectModel> subjects = [
//   SubjectModel(id: 1, name: 'Mathematics', activeQuizCount: 8),
//   SubjectModel(id: 2, name: 'English', activeQuizCount: 6),
//   SubjectModel(id: 3, name: 'Physics', activeQuizCount: 5),
//   SubjectModel(id: 4, name: 'Chemistry', activeQuizCount: 7),
//   SubjectModel(id: 5, name: 'BCS', activeQuizCount: 9),
//   SubjectModel(id: 6, name: 'IELTS', activeQuizCount: 4),
// ];
