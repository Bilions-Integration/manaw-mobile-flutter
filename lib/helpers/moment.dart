import 'package:intl/intl.dart';

// ignore: camel_case_types
class moment {
  final String date;

  const moment(this.date);

  format({String? format = 'dd MMM yyyy'}) {
    try {
      DateTime parsedDate;
      if (date.contains(':')) {
        parsedDate = DateFormat('yyyy-MM-dd HH:mm:ss').parse(date);
      } else {
        parsedDate = DateFormat('yyyy-MM-dd').parse(date);
      }
      return DateFormat(format).format(parsedDate);
    } catch (e) {
      throw 'Invalid Date';
    }
  }

  parse() {
    try {
      DateTime parsedDate;
      if (date.contains(':')) {
        parsedDate = DateFormat('yyyy-MM-dd HH:mm:ss').parse(date);
      } else {
        parsedDate = DateFormat('yyyy-MM-dd').parse(date);
      }
      return parsedDate;
    } catch (e) {
      throw 'Invalid Date';
    }
  }

  static onlyDate(String date) {
    return moment(date).format(format: 'yyyy-MM-dd');
  }

  static string(DateTime date) {
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(date);
  }
}
