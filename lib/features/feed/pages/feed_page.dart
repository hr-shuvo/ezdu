import 'package:ezdu/features/feed/entities/feed.dart';
import 'package:ezdu/features/feed/widgets/feed_achievement_card.dart';
import 'package:ezdu/features/feed/widgets/feed_announcement_card.dart';
import 'package:ezdu/features/feed/widgets/feed_friend_suggestion_slider.dart';
import 'package:ezdu/features/feed/widgets/feed_notification_card.dart';
import 'package:ezdu/features/feed/widgets/feed_sentence_shared_card.dart';
import 'package:ezdu/features/feed/widgets/feed_single_recommended_friend.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<StatefulWidget> createState() => _FeedPageState();

}

class _FeedPageState extends State<FeedPage> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.green[50]!, Colors.blue[50]!],
          ),
        ),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              // Header
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Feed',
                        style: Theme.of(context).textTheme.headlineLarge
                            ?.copyWith(
                          color: Colors.green[700],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Celebrate your friends' learning journey",
                        style: Theme.of(context).textTheme.bodyMedium
                            ?.copyWith(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              ),
              // Feed Items
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final item = feedItems[index];

                  switch (item.type) {
                    case 'achievement':
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: AchievementCard(
                          feedItem: item,
                          onLikeTap: () {

                          },
                        ),
                      );
                    case 'sentence_share':
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: SentenceShareCard(
                          feedItem: item,
                          onLikeTap: () {
                          },
                        ),
                      );
                    case 'friend_suggestions_slider':
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: FriendSuggestionsSlider(
                          pageController: _pageController,
                          onPageChanged: (page) {
                            setState(() => _currentPage = page);
                          },
                          onRemoveItem: (itemId) {
                          },
                        ),
                      );
                    case 'single_friend':
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: SingleRecommendedFriend(
                          feedItem: item,
                          onAddFriend: () {
                          },
                        ),
                      );
                    case 'notification':
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: NotificationCard(
                          feedItem: item,
                          onDismiss: () {
                          },
                        ),
                      );
                    case 'announcement':
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: AnnouncementCard(
                          feedItem: item,
                          onDismiss: () {
                          },
                        ),
                      );
                    default:
                      return const SizedBox.shrink();
                  }
                }, childCount: feedItems.length),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Text(
                    'No more updates from the past week',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          )
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

const feedItems = [
  FeedEntry(
    id: '1',
    type: 'achievement',
    userName: 'Sarah Chen',
    avatar: '👩‍🦰',
    action: 'reached a 30-day streak!',
    timestamp: '2 hours ago',
    language: '🇪🇸 Spanish',
    likeCount: 24,
    isLiked: false,
  ),
  FeedEntry(
    id: '2',
    type: 'sentence_share',
    userName: 'Alex Rodriguez',
    avatar: '👨‍💼',
    action: 'shared a sentence',
    sentence: 'El gato está durmiendo en el sofá',
    translation: 'The cat is sleeping on the sofa',
    timestamp: '4 hours ago',
    language: '🇫🇷 French',
    likeCount: 42,
    isLiked: false,
  ),
  FeedEntry(
    id: '3',
    type: 'friend_suggestions_slider',
    likeCount: 0,
    isLiked: false,
  ),
  FeedEntry(
    id: '4',
    type: 'single_friend',
    userName: 'Jordan Lee',
    avatar: '👩‍🎓',
    language: '🇯🇵 Japanese',
    mutualFriends: 3,
    likeCount: 0,
    isLiked: false,
  ),
  FeedEntry(
    id: '5',
    type: 'notification',
    title: 'Daily Practice Reminder',
    message: "You haven't practiced today. Keep your streak alive!",
    timestamp: '1 hour ago',
    likeCount: 0,
    isLiked: false,
  ),
  FeedEntry(
    id: '6',
    type: 'achievement',
    userName: 'Marcus Thompson',
    avatar: '👨‍🎯',
    action: 'is now in 2nd place in Gold League!',
    timestamp: '3 hours ago',
    language: '🇩🇪 German',
    likeCount: 56,
    isLiked: false,
  ),
  FeedEntry(
    id: '7',
    type: 'announcement',
    title: '🎉 New Challenge Available',
    message: 'Try the new Monthly Challenge and earn special rewards!',
    timestamp: '6 hours ago',
    likeCount: 0,
    isLiked: false,
  ),
  FeedEntry(
    id: '8',
    type: 'achievement',
    userName: 'Emma Wilson',
    avatar: '👩‍🔬',
    action: 'completed 1,000 XP this week!',
    timestamp: '7 hours ago',
    language: '🇮🇹 Italian',
    likeCount: 38,
    isLiked: false,
  ),
];
