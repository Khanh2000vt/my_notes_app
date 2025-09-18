import 'dart:convert';

import 'package:http/http.dart' as http;

class QRService {
  QRService._();
  static Future<String?> generateQRData({num? amount, String note = ''}) async {
    final url = Uri.parse("https://api.vietqr.io/v2/generate");
    final headers = {"Content-Type": "application/json"};
    final body = jsonEncode({
      "accountNo": "0971917361",
      "accountName": "NGUYEN THI DAO",
      "acqId": "970432",
      "addInfo": note,
      "amount": amount,
      "template": "qr_only",
    });
    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data["data"]["qrDataURL"];
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
