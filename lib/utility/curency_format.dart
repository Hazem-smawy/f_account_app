import 'package:intl/intl.dart' as intl;

class GlobalUtitlity {
  static String formatNumberString({required String number}) {
    return intl.NumberFormat.currency(symbol: '', decimalDigits: 1)
        .format(double.parse(number));
  }

  static String formatNumberDouble({required double number}) {
    return intl.NumberFormat.currency(symbol: '', decimalDigits: 1)
        .format(number);
  }
}
