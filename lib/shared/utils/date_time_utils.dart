import 'package:jiffy/jiffy.dart';

class DateTimeUtils {
  const DateTimeUtils._();

  static String fromNow(DateTime date) {
    return Jiffy(date).fromNow();
  }

  static String fromNowCustom(DateTime date) {
    final createdAt = Jiffy(date);
    final now = DateTime.now();
    if (Jiffy(createdAt).isSame(now, Units.DAY)) {
      return 'TODAY';
    } else if (Jiffy(createdAt).isSame(now.subtract(const Duration(days: 1)), Units.DAY)) {
      return 'YESTERDAY';
    } else if (Jiffy(createdAt).isAfter(
      now.subtract(const Duration(days: 7)),
      Units.DAY,
    )) {
      return createdAt.EEEE;
    } else {
      return createdAt.MMMd;
    }
  }
}
