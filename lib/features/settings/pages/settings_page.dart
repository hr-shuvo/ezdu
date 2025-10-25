import 'package:ezdu/core/utils/route_helper.dart';
import 'package:ezdu/features/home/pages/home_page.dart';
import 'package:ezdu/features/settings/pages/update_profile_page.dart';
import 'package:ezdu/features/settings/widgets/settings_item.dart';
import 'package:ezdu/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  bool _isSpeakerOn = true;
  bool _isMicrophoneOn = true;
  bool _isDailyReminderOn = true;
  bool _isProActive = true;

  Widget _buildSectionHeader(String title, Color onSurface) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          color: onSurface.withValues(alpha: 0.5),
          fontWeight: FontWeight.w800,
          fontSize: 13,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildDuolingoSwitch(
    bool value,
    ValueChanged<bool> onChanged,
    Color primaryColor,
  ) {
    return Switch(
      value: value,
      onChanged: onChanged,
      activeThumbColor: Colors.white,
      // Use theme primary color for active track
      activeTrackColor: primaryColor,
      inactiveThumbColor: Colors.white,
      inactiveTrackColor: Colors.grey.shade600.withValues(alpha: 0.5),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final authNotifier = ref.read(authProvider.notifier);

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            leading: IconButton(
              icon: Icon(Icons.close, color: colorScheme.onSurface, size: 28),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text(
              'Settings',
              style: TextStyle(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            centerTitle: true,
            backgroundColor: colorScheme.surface,
            elevation: 0,
          ),

          SliverList(
            delegate: SliverChildListDelegate([
              // --- Account Section ---
              _buildSectionHeader('Account', colorScheme.onSurface),
              SettingsItem(
                icon: Icons.person_outline,
                title: 'Username',
                subtitle: 'DuoFan123',
                trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                onTap: () {
                  Navigator.of(context).push(
                    SlideRightToLeftRoute(page: const UpdateProfilePage()),
                  );
                },
              ),
              Divider(
                height: 0,
                thickness: 1,
                indent: 16,
                endIndent: 16,
                color: colorScheme.surfaceContainerHighest,
              ),
              SettingsItem(
                icon: Icons.email_outlined,
                title: 'Email',
                subtitle: 'duo.fan@example.com',
                trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                onTap: () {},
              ),

              // --- Subscription Section (NEW) ---
              _buildSectionHeader('Subscription', colorScheme.onSurface),
              SettingsItem(
                icon: Icons.workspace_premium_outlined,
                title: 'Duolingo Super',
                subtitle: _isProActive
                    ? 'Active until Oct 2026'
                    : 'Upgrade now for unlimited hearts',
                trailing: _isProActive
                    ? Text(
                        'PRO',
                        style: TextStyle(
                          color: colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : const Icon(Icons.chevron_right, color: Colors.grey),
                onTap: () {
                  setState(() {
                    _isProActive = !_isProActive; // Toggle for demo
                  });
                },
              ),

              // --- General Section ---
              _buildSectionHeader('General', colorScheme.onSurface),
              SettingsItem(
                icon: Icons.volume_up_outlined,
                title: 'Speaker',
                subtitle: 'Enable speaking exercises',
                trailing: _buildDuolingoSwitch(_isSpeakerOn, (value) {
                  setState(() => _isSpeakerOn = value);
                }, colorScheme.primary),
              ),
              Divider(
                height: 0,
                thickness: 1,
                indent: 16,
                endIndent: 16,
                color: colorScheme.surfaceContainerHighest,
              ),
              SettingsItem(
                icon: Icons.mic_none,
                title: 'Microphone',
                subtitle: 'Enable pronunciation exercises',
                trailing: _buildDuolingoSwitch(_isMicrophoneOn, (value) {
                  setState(() => _isMicrophoneOn = value);
                }, colorScheme.primary),
              ),
              Divider(
                height: 0,
                thickness: 1,
                indent: 16,
                endIndent: 16,
                color: colorScheme.surfaceContainerHighest,
              ),
              SettingsItem(
                icon: Icons.offline_bolt_outlined,
                title: 'Offline Mode',
                subtitle: 'Download lessons for offline use',
                trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                onTap: () {},
              ),

              // --- Notifications Section ---
              _buildSectionHeader('Notifications', colorScheme.onSurface),
              SettingsItem(
                icon: Icons.notifications_none,
                title: 'Daily Reminder',
                subtitle: 'Reminders to practice your lessons',
                trailing: _buildDuolingoSwitch(_isDailyReminderOn, (value) {
                  setState(() => _isDailyReminderOn = value);
                }, colorScheme.primary),
              ),
              Divider(
                height: 0,
                thickness: 1,
                indent: 16,
                endIndent: 16,
                color: colorScheme.surfaceContainerHighest,
              ),
              SettingsItem(
                icon: Icons.access_time_outlined,
                title: 'Reminder Time',
                subtitle: '7:00 PM',
                trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                onTap: () {},
              ),

              // --- Support Section (NEW) ---
              _buildSectionHeader('Support', colorScheme.onSurface),
              SettingsItem(
                icon: Icons.help_outline,
                title: 'Help Center',
                subtitle: 'Find answers to frequently asked questions',
                trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                onTap: () {},
              ),
              Divider(
                height: 0,
                thickness: 1,
                indent: 16,
                endIndent: 16,
                color: colorScheme.surfaceContainerHighest,
              ),
              SettingsItem(
                icon: Icons.policy_outlined,
                title: 'Terms and Privacy',
                subtitle: 'View legal information',
                trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                onTap: () {},
              ),

              // --- Footer Section ---
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    TextButton(
                      onPressed: () async {
                        await authNotifier.logout();
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          '/',
                          (Route<dynamic> route) => false,
                        );
                      },
                      child: const Text(
                        'Log Out',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Version 5.140.0',
                      style: TextStyle(
                        color: colorScheme.onSurface.withValues(alpha: .3),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
