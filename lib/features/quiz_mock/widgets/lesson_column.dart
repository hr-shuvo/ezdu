import 'package:ezdu/data/models/lesson_model.dart';
import 'package:flutter/material.dart';
import 'topic_card.dart';

class LessonColumn extends StatelessWidget {
  final LessonWithTopicModel lesson;
  final bool isSelected;
  final Set<int> selectedTopicIds;
  final Function(int, List<int>) onLessonSelected;
  final Function(int) onTopicSelected;

  const LessonColumn({
    super.key,
    required this.lesson,
    required this.isSelected,
    required this.selectedTopicIds,
    required this.onLessonSelected,
    required this.onTopicSelected,
  });

  @override
  Widget build(BuildContext context) {
    final topics = lesson.topics ?? [];
    final allTopicsSelected =
        topics.isNotEmpty && topics.every((t) => selectedTopicIds.contains(t.id));

    return Column(
      children: [
        // Lesson Card
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelected ? Colors.blue : Colors.grey[300]!,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(6),
            color: isSelected ? Colors.blue[50] : Colors.white,
          ),
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => onLessonSelected(lesson.id, topics.map((t) => t.id).toList()),
                  child: Text(
                    lesson.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[800],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => onLessonSelected(lesson.id, topics.map((t) => t.id).toList()),
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: Checkbox(
                    value: allTopicsSelected,
                    onChanged: (_) {},
                    activeColor: Colors.blue,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
              ),
            ],
          ),
        ),
        // Topics
        if (topics.isNotEmpty)
          Container(
            margin: const EdgeInsets.only(top: 6),
            child: Column(
              children: [
                for (var topic in topics)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4, left: 12),
                    child: TopicCard(
                      topic: topic,
                      isSelected: selectedTopicIds.contains(topic.id),
                      onTap: () => onTopicSelected(topic.id),
                    ),
                  ),
              ],
            ),
          ),
      ],
    );
  }
}