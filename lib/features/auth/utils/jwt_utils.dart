import 'dart:convert';

class JwtUtils {
  static Map<String, dynamic> decodePayload(String token) {
    final parts = token.split('.');

    if (parts.length != 3) {
      throw const FormatException('Invalid JWT');
    }

    final payload = parts[1];

    final normalized = base64Url.normalize(payload);

    final decoded = utf8.decode(base64Url.decode(normalized));

    return jsonDecode(decoded) as Map<String, dynamic>;
  }

  static String? accountType(String token) {
    final payload = decodePayload(token);

    return payload['accountType'] as String?;
  }
}
