import 'package:ezdu/features/feed/entities/feed.dart';
import 'package:flutter/material.dart';

class AchievementCard extends StatelessWidget {
  final FeedEntry feedItem;
  final VoidCallback onLikeTap;

  const AchievementCard({
    Key? key,
    required this.feedItem,
    required this.onLikeTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Text(feedItem.avatar ?? '', style: const TextStyle(fontSize: 40)),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              feedItem.userName ?? '',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              feedItem.timestamp ?? '',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        feedItem.action ?? '',
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        feedItem.language ?? '',
                        style: TextStyle(
                          color: Colors.green[700],
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: onLikeTap,
                  icon: Icon(
                    feedItem.isLiked ? Icons.favorite : Icons.favorite_outline,
                    color: feedItem.isLiked ? Colors.red : Colors.grey,
                    size: 24,
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.grey[100],
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Icon(Icons.favorite, size: 16, color: Colors.red),
                const SizedBox(width: 4),
                Text(
                  '${feedItem.likeCount} likes',
                  style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}