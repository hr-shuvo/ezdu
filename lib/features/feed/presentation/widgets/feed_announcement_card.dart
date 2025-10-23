import 'package:ezdu/features/feed/domain/entities/feed.dart';
import 'package:flutter/material.dart';

class AnnouncementCard extends StatelessWidget {
  final FeedEntry feedItem;
  final VoidCallback onDismiss;

  const AnnouncementCard({
    Key? key,
    required this.feedItem,
    required this.onDismiss,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.yellow[50]!, Colors.orange[50]!],
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border(
            left: BorderSide(color: Colors.yellow[400]!, width: 4),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.yellow[400],
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'NEW',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.yellow[900],
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          feedItem.timestamp ?? '',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      feedItem.title ?? '',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      feedItem.message ?? '',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: onDismiss,
                icon: Icon(Icons.close, size: 20, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}