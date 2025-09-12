import 'package:intl/intl.dart';

String convertToCurrency(String? value) {
  if (value == null || value.isEmpty) {
    return '';
  }

  final number = double.tryParse(value.replaceAll(',', ''));
  if (number == null) return '';

  final formatter = NumberFormat("#,###", "vi_VN");
  return formatter.format(number);
}

String formatWithZero(int input) {
  return NumberFormat("00").format(input);
}
