import 'package:ezdu/data/models/lesson_model.dart';
import 'package:flutter/material.dart';

class ReviewLessonCard extends StatelessWidget {
  final LessonWithTopicModel lesson;
  final Set<int> selectedTopicIds;

  const ReviewLessonCard({
    super.key,
    required this.lesson,
    required this.selectedTopicIds,
  });

  @override
  Widget build(BuildContext context) {
    final topics = lesson.topics ?? [];
    final selectedTopics =
    topics.where((t) => selectedTopicIds.contains(t.id)).toList();

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue[200]!, width: 1.5),
        borderRadius: BorderRadius.circular(8),
        color: Colors.blue[50],
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Lesson Header
          Row(
            children: [
              Expanded(
                child: Text(
                  lesson.name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  selectedTopics.length.toString(),
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Selected Topics
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var i = 0; i < selectedTopics.length; i++)
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        size: 16,
                        color: Colors.green[600],
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          selectedTopics[i].name,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[700],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}