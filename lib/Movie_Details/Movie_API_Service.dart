import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Movie_Data_Model.dart';

class MovieApiService {
  Future<MovieModel?> fetchMovie() async {
    final url = Uri.parse(
      "https://www.omdbapi.com/?i=tt3896198&apikey=1c441fd8",
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return MovieModel.fromJson(json);
    } else {
      return null;
    }
  }
}
