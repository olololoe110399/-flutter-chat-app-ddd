import 'package:jiffy/jiffy.dart';

class DateTimeUtils {
  const DateTimeUtils._();

  static String fromNow(DateTime? date) {
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

  static bool isNotSame(
    DateTime currenTime,
    DateTime nextTime,
  ) {
    return !Jiffy(currenTime.toLocal()).isSame(nextTime.toLocal(), Units.DAY);
  }

  static String fromNowChannel(DateTime lastMessageAt) {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    if (lastMessageAt.millisecondsSinceEpoch >= startOfDay.millisecondsSinceEpoch) {
      return Jiffy(lastMessageAt.toLocal()).jm;
    } else if (lastMessageAt.millisecondsSinceEpoch >=
        startOfDay.subtract(const Duration(days: 1)).millisecondsSinceEpoch) {
      return 'YESTERDAY';
    } else if (startOfDay.difference(lastMessageAt).inDays < 7) {
      return Jiffy(lastMessageAt.toLocal()).EEEE;
    } else {
      return Jiffy(lastMessageAt.toLocal()).yMd;
    }
  }

  static String jm(
    DateTime time,
  ) {
    return Jiffy(time.toLocal()).jm;
  }
}
