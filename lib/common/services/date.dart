import 'package:intl/intl.dart';

String duTimeLineFormat(DateTime dateTime) {
  var now = DateTime.now();
  var difference = now.difference(dateTime);
  if (difference.inMinutes < 60) {
    return "${difference.inMinutes} m ago";
  }

  if (difference.inHours < 24) {
    return "${difference.inHours} h ago";
  }

  if (difference.inDays < 30) {
    return "${difference.inDays} d ago";
  }

  if (difference.inDays < 365) {
    final dateFormat = new DateFormat('MM-dd');
    return dateFormat.format(dateTime);
  }

  final dateFormat = new DateFormat('yyy-MM-dd');
  return dateFormat.format(dateTime);
}
