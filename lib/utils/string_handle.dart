import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/constants/storage_constants.dart';

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

Future<int?> getUserId() async {
  final prefs = await SharedPreferences.getInstance();
  final userId = prefs.getString(StorageConstants.authToken);
  if (userId == null) {
    return null;
  }
  return int.parse(userId);
}

Future<void> setUserId(int userId) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(StorageConstants.authToken, userId.toString());
}
