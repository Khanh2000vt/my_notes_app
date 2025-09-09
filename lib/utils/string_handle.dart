import 'package:intl/intl.dart';

String convertToCurrency(String? value) {
  if (value == null || value.isEmpty) return '';
  final formatter = NumberFormat("#,###", "vi_VN");
  return formatter.format(int.parse(value));
}

String formatWithZero(int input) {
  return NumberFormat("00").format(input);
}
