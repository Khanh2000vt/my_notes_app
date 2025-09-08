import 'package:intl/intl.dart';

String convertToCurrency(String? value) {
  if (value == null || value.isEmpty) return '';
  final formatter = NumberFormat("#,###", "vi_VN");
  return formatter.format(int.parse(value));
}
