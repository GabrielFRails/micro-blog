import 'package:intl/intl.dart';

class UtilDataHora {
  static DateTime convertStringToDate(String data) {
    try {
      return DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", "en_US").parse(data);
    } catch (e) {
      return null;
    }
  }

  static String converteDateTime(DateTime dateTime) {
    try {
      return DateFormat("yyy/MM/dd hh:mm").format(dateTime);
    } catch (e) {
      return " ";
    }
  }
}
