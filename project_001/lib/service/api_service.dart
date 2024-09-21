import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String apiKey = '2dfe23358236069710a379edd4c65a6b';
  final String baseUrl = 'https://api.themoviedb.org/3/person';

  Future<List<dynamic>> fetchFamousPersons() async {
    final response = await http.get(Uri.parse('$baseUrl/popular?api_key=$apiKey'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['results'];
    } else {
      throw Exception('Failed to load famous persons');
    }
  }

  Future<Map<String, dynamic>> fetchPersonDetails(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id?api_key=$apiKey'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load person details');
    }
  }
}
