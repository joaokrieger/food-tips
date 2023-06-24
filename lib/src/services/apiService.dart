import 'package:http/http.dart' as http;

class ApiService {
  ApiService._privateConstructor();

  static final ApiService _instance = ApiService._privateConstructor();

  factory ApiService() => _instance;

  String? _apiKey;

  void setApiKey(String apiKey) {
    _apiKey = apiKey;
  }

  Future<http.Response> getRequest(String url) async {
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Token $_apiKey',
        'Content-Type': 'application/json',
      },
    );
    return response;
  }

  Future<http.Response> postRequest(String url, dynamic body) async {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization': 'Token $_apiKey',
        'Content-Type': 'application/json',
      },
      body: body
    );
    return response;
  }
}
