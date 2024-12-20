import 'package:dio/dio.dart';
import '../models/joke.dart';

class JokeService {
  final Dio dio = Dio();

  Future<List<Joke>> fetchJokes() async {
    try {
      final response = await dio.get(
        'https://v2.jokeapi.dev/joke/Any',
        queryParameters: {'amount': 5, 'blacklistFlags':"nsfw,religious,political,racist,sexist,explicit"},
      );

      if (response.statusCode == 200) {
        List<dynamic> data = response.data['jokes'];
        return data.map((jokeData) => Joke.fromJson(jokeData)).toList();
      } else {
        throw Exception('Failed to load jokes');
      }
    } catch (e) {
      rethrow; // Rethrow the error to be handled by the caller
    }
  }
}
