import 'package:ezdu/data/models/subject_model.dart';
import 'package:ezdu/features/archive/pages/exams_page.dart';
import 'package:ezdu/features/archive/widgets/archive_stat_card.dart';
import 'package:ezdu/features/archive/widgets/archive_subject_card.dart';
import 'package:flutter/material.dart';

class ArchivePage extends StatelessWidget {
  const ArchivePage({super.key});

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
                  // Text(
                  //   'Archive',
                  //   style: TextStyle(
                  //     fontSize: 36,
                  //     fontWeight: FontWeight.bold,
                  //     color: Color(0xFF1E293B),
                  //   ),
                  // ),
                  // const SizedBox(height: 16),
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

                  GridView.builder(
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

const List<Subject> subjects = [
  Subject(
    id: 1,
    name: 'Mathematics',
    emoji: '🧮',
    gradient: [const Color(0xFF3B82F6), const Color(0xFF1E40AF)],
    examCount: 8,
  ),
  Subject(
    id: 2,
    name: 'English',
    emoji: '📖',
    gradient: [const Color(0xFFA855F7), const Color(0xFF6D28D9)],
    examCount: 6,
  ),
  Subject(
    id: 3,
    name: 'Physics',
    emoji: '⚛️',
    gradient: [const Color(0xFF10B981), const Color(0xFF047857)],
    examCount: 5,
  ),
  Subject(
    id: 4,
    name: 'Chemistry',
    emoji: '🧪',
    gradient: [const Color(0xFFF97316), const Color(0xFFEA580C)],
    examCount: 7,
  ),
  Subject(
    id: 5,
    name: 'BCS',
    emoji: '💼',
    gradient: [const Color(0xFFEF4444), const Color(0xFFDC2626)],
    examCount: 9,
  ),
  Subject(
    id: 6,
    name: 'IELTS',
    emoji: '🎤',
    gradient: [const Color(0xFF06B6D4), const Color(0xFF0891B2)],
    examCount: 4,
  ),
];
