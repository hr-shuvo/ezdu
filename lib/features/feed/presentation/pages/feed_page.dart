import 'package:ezdu/app/di/injector.dart';
import 'package:ezdu/features/feed/domain/usecases/get_feed.dart';
import 'package:ezdu/features/feed/presentation/bloc/feed_bloc.dart';
import 'package:ezdu/features/feed/presentation/bloc/feed_event.dart';
import 'package:ezdu/features/feed/presentation/bloc/feed_state.dart';
import 'package:ezdu/features/feed/presentation/widgets/feed_achievement_card.dart';
import 'package:ezdu/features/feed/presentation/widgets/feed_announcement_card.dart';
import 'package:ezdu/features/feed/presentation/widgets/feed_friend_suggestion_slider.dart';
import 'package:ezdu/features/feed/presentation/widgets/feed_notification_card.dart';
import 'package:ezdu/features/feed/presentation/widgets/feed_sentence_shared_card.dart';
import 'package:ezdu/features/feed/presentation/widgets/feed_single_recommended_friend.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<FeedBloc>()
        ..add(const LoadFeed())
        ..add(const LoadSuggestedFriend()),
      child: const LoadFeedView(),
    );
  }
}

class LoadFeedView extends StatefulWidget {
  const LoadFeedView({super.key});

  @override
  State<LoadFeedView> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<LoadFeedView> {
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
          child: BlocBuilder<FeedBloc, FeedState>(
            builder: (context, state) {
              if (state is FeedLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is FeedError) {
                return Center(child: Text(state.message));
              }

              if (state is FeedLoaded) {
                return CustomScrollView(
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
                        final item = state.feedItems[index];

                        switch (item.type) {
                          case 'achievement':
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: AchievementCard(
                                feedItem: item,
                                onLikeTap: () {
                                  context.read<FeedBloc>().add(
                                    ToggleLikeEvent(item.id),
                                  );
                                },
                              ),
                            );
                          case 'sentence_share':
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: SentenceShareCard(
                                feedItem: item,
                                onLikeTap: () {
                                  context.read<FeedBloc>().add(
                                    ToggleLikeEvent(item.id),
                                  );
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
                                  context.read<FeedBloc>().add(
                                    RemoveFeedItemEvent(itemId),
                                  );
                                },
                              ),
                            );
                          case 'single_friend':
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: SingleRecommendedFriend(
                                feedItem: item,
                                onAddFriend: () {
                                  context.read<FeedBloc>().add(
                                    RemoveFeedItemEvent(item.id),
                                  );
                                },
                              ),
                            );
                          case 'notification':
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: NotificationCard(
                                feedItem: item,
                                onDismiss: () {
                                  context.read<FeedBloc>().add(
                                    RemoveFeedItemEvent(item.id),
                                  );
                                },
                              ),
                            );
                          case 'announcement':
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: AnnouncementCard(
                                feedItem: item,
                                onDismiss: () {
                                  context.read<FeedBloc>().add(
                                    RemoveFeedItemEvent(item.id),
                                  );
                                },
                              ),
                            );
                          default:
                            return const SizedBox.shrink();
                        }
                      }, childCount: state.feedItems.length),
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
                );
              }

              return const Center(child: Text('No data available'));
            },
          ),
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
