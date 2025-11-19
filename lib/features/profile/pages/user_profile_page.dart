// all other user profile page

import 'package:ezdu/features/profile/widgets/profile_overview.dart';
import 'package:flutter/material.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key, required this.userId});

  final int userId;

  @override
  State<StatefulWidget> createState() => _UserProfilePage();
}

class _UserProfilePage extends State<UserProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: RefreshIndicator(
        onRefresh: () async {},
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                children: [
                  Container(
                    height: 120,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context).primaryColor,
                          Theme.of(context).primaryColor.withValues(alpha: 0.6),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 4),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.2),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: CircleAvatar(
                              backgroundImage: AssetImage(
                                'assets/images/avatars/1.png',
                              ),
                              backgroundColor: Colors.grey[300],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              UserProfileWidget(
                displayName: 'authState.name',
                username: 'userName',
                joinedDate: 'Jan 15, 2024',
                profileImageUrl:
                    'https://api.dicebear.com/9.x/avataaars/svg?seed=Christopher',
                followers: 1250,
                following: 320,
                totalXP: 15420,
                currentStreak: 42,
                level: 18,
                totalQuizzes: 156,
                isFollowing: false,
                isFriend: true,
                lastQuizzes: [
                  {'title': 'Spanish Basics', 'date': 'Today', 'score': 95},
                  {'title': 'French Verbs', 'date': 'Yesterday', 'score': 88},
                  {
                    'title': 'German Grammar',
                    'date': '2 days ago',
                    'score': 76,
                  },
                ],
                onFollowPressed: () {},
                onFriendPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
