import 'package:shared_preferences/shared_preferences.dart';

class UserOnboardingService {
  static const String _onboardingCompleteKey = 'onboarding_completed';
  static const String _userSegmentKey = 'user_segment_segment';
  static const String _userClassKey = 'user_segment_class';
  static const String _userGroupKey = 'user_segment_group';
  static const String _firstRunKey = 'is_first_run';

  static Future<bool> isComplete() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_onboardingCompleteKey) ?? false;
  }

  static Future<void> setComplete() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardingCompleteKey, true);
  }

  static Future<void> saveSegment(int segment) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_userSegmentKey, segment);
  }

  static Future<int> getSegment() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_userSegmentKey) ?? 0;
  }

  static Future<void> saveClass(int classId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_userClassKey, classId);
  }

  static Future<int> getClass() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_userClassKey) ?? 0;
  }

  static Future<void> saveGroup(String group) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userGroupKey, group);
  }

  static Future<String?> getGroup() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userGroupKey);
  }
}
