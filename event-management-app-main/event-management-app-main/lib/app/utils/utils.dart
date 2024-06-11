import 'package:intl/intl.dart';

String formatDate(String date) {
  return DateFormat('dd-MMM-yyyy').format(DateTime.parse(date));
}
