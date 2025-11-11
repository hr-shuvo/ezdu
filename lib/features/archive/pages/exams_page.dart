import 'package:ezdu/app/di/injector.dart';
import 'package:ezdu/core/models/api_response.dart';
import 'package:ezdu/core/utils/route_helper.dart';
import 'package:ezdu/data/models/subject_model.dart';
import 'package:ezdu/data/repositories/archive_repository.dart';
import 'package:ezdu/features/archive/models/archive_model.dart';
import 'package:ezdu/features/archive/pages/archive_review_page.dart';
import 'package:flutter/material.dart';

class ExamListScreen extends StatefulWidget {
  const ExamListScreen({
    super.key,
    required this.subject,
    required this.archiveRepository,
  });

  final SubjectModel subject;
  final ArchiveRepository archiveRepository;

  @override
  State<ExamListScreen> createState() => _ExamListScreenState();
}

class _ExamListScreenState extends State<ExamListScreen> {
  late Future<ApiResponse<PagedList<ArchiveModel>>> archivedExamsFuture;

  // late List<ArchiveModel> filteredExams;

  String searchQuery = '';
  String selectedFilter = 'all';
  String selectedSort = 'recent';

  final List<String> filterOptions = ['all', 'mcq', 'cq', 'mixed'];
  final List<String> sortOptions = [
    'recent',
    'oldest',
    'score_high',
    'score_low',
  ];

  @override
  void initState() {
    super.initState();
    final subjectId = widget.subject.id;
    archivedExamsFuture = widget.archiveRepository.getArchivedExamList(
      subjectId,
    );
    // filteredExams = List.from(allArchivedExamsFuture);
    // filteredExams = archivedExamsFuture
    // filteredExams = List.from([]);
  }

  void _applyFiltersAndSearch() {
    // filteredExams = allExams.where((exam) {
    //   final matchesSearch = exam.title.toLowerCase().contains(
    //     searchQuery.toLowerCase(),
    //   );
    //   final matchesFilter =
    //       selectedFilter == 'all' || exam.type == selectedFilter;
    //   return matchesSearch && matchesFilter;
    // }).toList();
    //
    // // Apply sorting
    // switch (selectedSort) {
    //   case 'oldest':
    //     filteredExams.sort((a, b) {
    //       final dateOrder = [
    //         'Jan',
    //         'Feb',
    //         'Mar',
    //         'Apr',
    //         'May',
    //         'Jun',
    //         'Jul',
    //         'Aug',
    //         'Sep',
    //         'Oct',
    //         'Nov',
    //         'Dec',
    //       ];
    //       final monthA = dateOrder.indexOf(a.date.split(' ')[0]);
    //       final monthB = dateOrder.indexOf(b.date.split(' ')[0]);
    //       final yearA = int.tryParse(a.date.split(' ')[1]) ?? 0;
    //       final yearB = int.tryParse(b.date.split(' ')[1]) ?? 0;
    //
    //       if (yearA != yearB) return yearA.compareTo(yearB);
    //       return monthA.compareTo(monthB);
    //     });
    //     break;
    //   case 'score_high':
    //     filteredExams.sort((a, b) {
    //       final scoreA = a.status == 'new' ? 0.0 : a.score / a.total;
    //       final scoreB = b.status == 'new' ? 0.0 : b.score / b.total;
    //       return scoreB.compareTo(scoreA);
    //     });
    //     break;
    //   case 'score_low':
    //     filteredExams.sort((a, b) {
    //       final scoreA = a.status == 'new' ? 100.0 : a.score / a.total;
    //       final scoreB = b.status == 'new' ? 100.0 : b.score / b.total;
    //       return scoreA.compareTo(scoreB);
    //     });
    //     break;
    //   default: // recent
    //     break;
    // }

    setState(() {});
  }

  String _getTypeIcon(String type) {
    switch (type) {
      case 'mcq':
        return '🧩';
      case 'cq':
        return '✍️';
      case 'mixed':
        return '📋';
      default:
        return '📝';
    }
  }

  String _getTypeLabel(String type) {
    switch (type) {
      case 'mcq':
        return 'MCQ';
      case 'cq':
        return 'CQ';
      case 'mixed':
        return 'Mixed';
      default:
        return 'Other';
    }
  }

  Color _getScoreColor(int percentage) {
    if (percentage >= 80) return const Color(0xFF10B981);
    if (percentage >= 60) return const Color(0xFFF59E0B);
    return const Color(0xFFEF4444);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF8FAFC), Color(0xFFF1F5F9)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header with back button
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.arrow_back,
                        size: 24,
                        color: Color(0xFF475569),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              // Text(
                              //   widget.subject.emoji,
                              //   style: const TextStyle(fontSize: 28),
                              // ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  widget.subject.name,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF1E293B),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '12 exams available',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Search Box
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextField(
                    onChanged: (value) {
                      searchQuery = value;
                      _applyFiltersAndSearch();
                    },
                    decoration: InputDecoration(
                      hintText: 'Search exam or topic...',
                      hintStyle: const TextStyle(
                        color: Color(0xFFAEB0BC),
                        fontSize: 14,
                      ),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Color(0xFF94A3B8),
                        size: 20,
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Filter and Sort Row
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    // Filter Dropdown
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: selectedFilter,
                          underline: const SizedBox(),
                          items: filterOptions
                              .map(
                                (filter) => DropdownMenuItem(
                                  value: filter,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 12),
                                    child: Text(
                                      filter == 'all'
                                          ? '📋 All'
                                          : filter == 'mcq'
                                          ? '🧩 MCQ'
                                          : filter == 'cq'
                                          ? '✍️ CQ'
                                          : '📝 Mixed',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            if (value != null) {
                              selectedFilter = value;
                              _applyFiltersAndSearch();
                            }
                          },
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    // Sort Dropdown
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: selectedSort,
                          underline: const SizedBox(),
                          items: sortOptions
                              .map(
                                (sort) => DropdownMenuItem(
                                  value: sort,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 12),
                                    child: Text(
                                      sort == 'recent'
                                          ? '🕐 Recent'
                                          : sort == 'oldest'
                                          ? '📅 Oldest'
                                          : sort == 'score_high'
                                          ? '📈 Best Score'
                                          : '📉 Low Score',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            if (value != null) {
                              selectedSort = value;
                              _applyFiltersAndSearch();
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Exam List
              Expanded(
                child: FutureBuilder(
                  future: archivedExamsFuture,
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
                      final items = snapshot.data!.data!.items;

                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final item = items[index];
                          // final percentage = exam.status == 'new'
                          //     ? 0
                          //     : ((exam.score / exam.total) * 100).toInt();

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                SlideRightToLeftRoute(
                                  page: ArchiveReviewPage(
                                    archivedExam: item,
                                    archiveRepository: sl(),
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: .08),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  // Left Section
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              // _getTypeIcon(exam.type),
                                              "exam.type",
                                              style: const TextStyle(
                                                fontSize: 24,
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 8,
                                                    vertical: 4,
                                                  ),
                                              decoration: BoxDecoration(
                                                color: const Color(0xFFF1F5F9),
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Text(
                                                "exam.type",
                                                style: const TextStyle(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0xFF475569),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          item.name,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF1E293B),
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.calendar_today,
                                              size: 14,
                                              color: Color(0xFF94A3B8),
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              'date',
                                              style: const TextStyle(
                                                fontSize: 12,
                                                color: Color(0xFF64748B),
                                              ),
                                            ),
                                            const SizedBox(width: 16),
                                            // if (exam.status == 'attempted')
                                            if (true)
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.check_circle,
                                                    size: 14,
                                                    color: Color(0xFF10B981),
                                                  ),
                                                  const SizedBox(width: 4),
                                                  Text(
                                                    '${2}/${7}',
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                      color: Color(0xFF10B981),
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            else
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.lock,
                                                    size: 14,
                                                    color: Color(0xFFCBD5E1),
                                                  ),
                                                  const SizedBox(width: 4),
                                                  const Text(
                                                    'New',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Color(0xFF94A3B8),
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),

                                  // Right Section - Score
                                  if (true) //
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 70,
                                          height: 70,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            gradient: LinearGradient(
                                              colors: [
                                                _getScoreColor(
                                                  77,
                                                ).withOpacity(0.2),
                                                _getScoreColor(77),
                                              ],
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                            ),
                                          ),
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  '77%',
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: _getScoreColor(77),
                                                  ),
                                                ),
                                                Text(
                                                  'Score',
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    color: _getScoreColor(77),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  else
                                    Container(
                                      width: 70,
                                      height: 70,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xFFF1F5F9),
                                      ),
                                      child: const Center(
                                        child: Icon(
                                          Icons.lock,
                                          color: Color(0xFF94A3B8),
                                          size: 32,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }

                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('🔍', style: TextStyle(fontSize: 48)),
                          const SizedBox(height: 12),
                          Text(
                            '${widget.subject.id.toString()} - ${widget.subject.name}',
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'No exams found',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF64748B),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
