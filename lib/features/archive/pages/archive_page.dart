import 'package:ezdu/app/di/injector.dart';
import 'package:ezdu/core/models/api_response.dart';
import 'package:ezdu/core/utils/route_helper.dart';
import 'package:ezdu/data/models/subject_model.dart';
import 'package:ezdu/data/repositories/subject_repository.dart';
import 'package:ezdu/features/archive/pages/exams_page.dart';
import 'package:ezdu/features/archive/widgets/archive_stat_card.dart';
import 'package:ezdu/features/archive/widgets/archive_subject_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ArchivePage extends ConsumerStatefulWidget {
  const ArchivePage({super.key, required this.subjectRepository});

  final SubjectRepository subjectRepository;

  @override
  ConsumerState<ArchivePage> createState() => _ArchivePageState();
}

class _ArchivePageState extends ConsumerState<ArchivePage> {
  late Future<ApiResponse<PagedList<SubjectModel>>> _subjectListFuture;

  @override
  void initState() {
    super.initState();

    _subjectListFuture = widget.subjectRepository.getSubjectList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Archive',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
                          backgroundColor: const Color(0xFFD4765F), // Deep Terracotta (matching theme)
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: StatCard(
                          label: 'Points',
                          value: '2.5K',
                          icon: '⭐',
                          backgroundColor: const Color(0xFFD4B84E), // Deep Gold
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: StatCard(
                          icon: '✅',
                          label: 'Answered',
                          value: '145',
                          backgroundColor: const Color(0xFF70AD47), // Deep Green
                        ),
                      ),
                    ],
                ),
                const SizedBox(height: 28),

                const Text(
                  'Explore Subjects',
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
                        snapshot.data!.data != null &&
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
                          final cardColor = _cardColors[index % _cardColors.length];

                          return SubjectCard(
                            subject: subject,
                            cardColor: cardColor,
                            onTap: () {
                              Navigator.push(
                                context,
                                SlideRightToLeftRoute(
                                  page: ExamListScreen(
                                    subject: subject,
                                    archiveRepository: sl(),
                                  ),
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
    );
  }
}

final List<Color> _cardColors = [
  const Color(0xFFFF9800), // Deep Orange
  const Color(0xFF2196F3), // Deep Blue
  const Color(0xFF4CAF50), // Deep Green
  const Color(0xFFE91E63), // Deep Pink
  const Color(0xFFFF5722), // Deep Red-Orange
  const Color(0xFF00BCD4), // Deep Cyan
  const Color(0xFF9C27B0), // Deep Purple
  const Color(0xFFFBC02D), // Deep Amber
];

