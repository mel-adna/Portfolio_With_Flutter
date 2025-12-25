import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class EmailService {
  static String get _serviceId => dotenv.env['EMAILJS_SERVICE_ID'] ?? '';
  static String get _templateId => dotenv.env['EMAILJS_TEMPLATE_ID'] ?? '';
  static String get _userId => dotenv.env['EMAILJS_USER_ID'] ?? '';
  static const String _url = 'https://api.emailjs.com/api/v1.0/email/send';

  static Future<bool> sendEmail({
    required String name,
    required String email,
    required String message,
  }) async {
    try {
      final url = Uri.parse(_url);
      final response = await http.post(
        url,
        headers: {
          'origin': 'https://mel-adna.github.io', // Whitelist this in EmailJS
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'service_id': _serviceId,
          'template_id': _templateId,
          'user_id': _userId,
          'template_params': {
            'user_name': name,
            'user_email': email,
            'user_message': message,
          },
        }),
      );

      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}
