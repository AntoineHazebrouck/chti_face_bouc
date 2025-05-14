import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ServiceDateFormat {
  static String format(Timestamp timeStamp) {
    DateTime postTime = timeStamp.toDate();
    DateTime now = DateTime.now();
    DateFormat format;
    if (now.difference(postTime).inDays > 0) {
      format = DateFormat.yMMMd();
    } else {
      format = DateFormat.Hm();
    }
    return format.format(postTime).toString();
  }
}
