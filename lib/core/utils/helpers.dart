import 'package:intl/intl.dart';

class TimeHelper {
  static const String _outputFormat = 'MMM d, yyyy, h:mm a';

  static String safeUtc(String utcTimeString) {
    return utcTimeString.endsWith('Z') ? utcTimeString : '${utcTimeString}Z';
  }

  static DateTime utcToLocalDateTime(String utcTimeString) {
    final utcDateTime = DateTime.parse(safeUtc(utcTimeString));
    final localDateTime = utcDateTime.toLocal();

    return localDateTime;
  }

  static String formatUtcToLocal(String utcTimeString) {
    if (utcTimeString.isEmpty) {
      return 'N/A';
    }

    try {
      // final normalized = utcTimeString.endsWith('Z')
      //     ? utcTimeString
      //     : '${utcTimeString}Z';

      final utcDateTime = DateTime.parse(safeUtc(utcTimeString));
      final localDateTime = utcDateTime.toLocal();

      final formatter = DateFormat(_outputFormat, Intl.systemLocale);

      return formatter.format(localDateTime);
    } catch (e) {
      print('Error parsing date string: $utcTimeString. Error: $e');
      return 'Invalid Date';
    }
  }

  static bool isUtcTimeExpired(String utcTimeString) {
    if (utcTimeString.isEmpty) {
      return true;
    }

    try {
      // final normalized = utcTimeString.endsWith('Z')
      //     ? utcTimeString
      //     : '${utcTimeString}Z';

      final utcDateTime = DateTime.parse(safeUtc(utcTimeString));
      final localDateTime = utcDateTime.toLocal();

      return localDateTime.isBefore(DateTime.now());
    } catch (e) {
      print('Error parsing date string: $utcTimeString. Error: $e');
      return false;
    }
  }
}
