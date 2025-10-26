// import 'package:shared_preferences/shared_preferences.dart';
//
// class AppStatusService {
//   static const String _onboardingCompleteKey = 'onboarding_completed';
//   static const String _userSegmentKey = 'user_segment_type';
//   static const String _firstRunKey = 'is_first_run';
//
//   static Future<bool> isOnboardingComplete() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getBool(_onboardingCompleteKey) ?? false;
//   }
//
//   static Future<void> setOnboardingComplete() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setBool(_onboardingCompleteKey, true);
//   }
//
//   static Future<void> saveUserSegment(int segment) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setInt(_userSegmentKey, segment);
//   }
//
//   static Future<int?> getUserSegment() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getInt(_userSegmentKey);
//   }
// }
