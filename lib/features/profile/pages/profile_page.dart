// self profile page

import 'package:ezdu/core/utils/route_helper.dart';
import 'package:ezdu/data/repositories/user_repository.dart';
import 'package:ezdu/features/profile/models/progress.dart';
import 'package:ezdu/features/settings/pages/settings_page.dart';
import 'package:ezdu/features/profile/widgets/profile_overview.dart';
import 'package:ezdu/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key, required this.userRepository});

  final UserRepository userRepository;

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  Future<void> _refreshProfile() async {
    setState(() {
      // widget.userRepository.getUserDetails(auth);
    });
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider).data;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leadingWidth: double.infinity,
        leading: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              authState!.userName,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.output),
            onPressed: () {
              // Show calendar view
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            // Changed to Settings icon
            onPressed: () {
              Navigator.of(
                context,
              ).push(SlideUpRoute(page: const SettingsPage()));
            },
          ),
        ],
        flexibleSpace: Container(
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
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: FutureBuilder(
        future: widget.userRepository.getUserDetails(authState.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  Text('Error: ${snapshot.error}'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _refreshProfile,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data?.data == null) {
            return const Center(child: Text('No user data found'));
          }

          final user = snapshot.data!.data!;
          return RefreshIndicator(
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
                              Theme.of(
                                context,
                              ).primaryColor.withValues(alpha: 0.6),
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
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 4,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(
                                        alpha: 0.2,
                                      ),
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
                  // Overview Card
                  UserProfileWidget(
                    displayName: user.name ?? 'User',
                    username: user.userName ?? '@user',
                    joinedDate: user.createdAt ?? 'Jan 15, 2024',
                    profileImageUrl:
                        user.photoUrl ??
                        'https://api.dicebear.com/9.x/avataaars/svg?seed=User',
                    followers: user.followers ?? 0,
                    following: user.following ?? 0,
                    totalXP: user.totalXp ?? 0,
                    currentStreak: user.streak ?? 0,
                    level: 17,
                    totalQuizzes: 13,
                    isFollowing: user.isFollowing,
                    isMyself: authState.id == user.id,
                    lastQuizzes: [],
                    onFollowPressed: () {},
                    onFriendPressed: () => {},
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ProgressOverviewCard extends StatelessWidget {
  final Progress progress;

  const _ProgressOverviewCard({required this.progress});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).primaryColor.withValues(alpha: 0.7),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Total Progress',
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${progress.totalXP}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'Total XP',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    const Icon(
                      Icons.local_fire_department,
                      color: Colors.white,
                      size: 32,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${progress.currentStreak}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'day streak',
                      style: TextStyle(color: Colors.white70, fontSize: 12),
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
