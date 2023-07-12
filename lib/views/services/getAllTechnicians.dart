import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String _baseUrl = 'http://10.0.2.2:8000/api/auth/getAllUsers';

  Future<http.Response> getRequest(String endpoint) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');

    final response = await http.get(Uri.parse('$_baseUrl/$endpoint'), headers: {
      'Authorization': 'Bearer $token',
    });

    return response;
  }
}
