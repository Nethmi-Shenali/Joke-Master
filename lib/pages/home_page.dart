import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // For JSON encoding/decoding
import '../widgets/fetch_jokes_button.dart';
import '../services/joke_service.dart';
import '../models/joke.dart';
import 'dart:ui';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Joke> jokes = [];
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    loadCachedJokes();
  }

  // Save jokes to shared_preferences
  Future<void> saveJokesToCache(List<Joke> jokes) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String jokesJson =
        jsonEncode(jokes.map((joke) => joke.toJson()).toList());
    await prefs.setString('cached_jokes', jokesJson);
  }

  // Load jokes from shared_preferences
  Future<void> loadCachedJokes() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? jokesJson = prefs.getString('cached_jokes');
    if (jokesJson != null) {
      final List<dynamic> jokesData = jsonDecode(jokesJson);
      setState(() {
        jokes = jokesData.map((jokeData) => Joke.fromJson(jokeData)).toList();
      });
    }
  }

  // Fetch jokes from the service
  Future<void> fetchJokes() async {
    setState(() {
      isLoading = true;
    });
    try {
      List<Joke> fetchedJokes = await JokeService().fetchJokes();
      setState(() {
        jokes = fetchedJokes;
      });
      saveJokesToCache(fetchedJokes);
    } catch (e) {
      print('Error fetching jokes: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            radius: 1.2,
            colors: [
              const Color(0xFF1976D2),
              const Color(0xFF42A5F5),
              const Color(0xFF1565C0),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 60),
            const Center(
                child: Text(
              'Joke Master',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [
                  Shadow(
                    blurRadius: 10.0,
                    color: Colors.black45,
                    offset: const Offset(2.0, 2.0),
                  ),
                ],
              ),
            )),
            const SizedBox(height: 20),
            Center(
              child: Icon(
                Icons.sentiment_very_satisfied_rounded,
                size: 120,
                color: Colors.white.withOpacity(0.3),
              ),
            ),
            const SizedBox(height: 20),
            FetchJokesButton(fetchJokes: fetchJokes), // Reusable Button widget
            Expanded(
              child: isLoading // Check if loading
                  ? const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : jokes.isEmpty
                      ? const Center(
                          child: Text(
                            'No jokes available. Fetch some jokes!',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: jokes.length,
                          itemBuilder: (context, index) {
                            final joke = jokes[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 16.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary
                                          .withOpacity(0.2),
                                      blurRadius: 10,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: ListTile(
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        if (joke.type == "twopart")
                                          Column(children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8.0),
                                              child: Text(
                                                joke.setup ??
                                                    'No setup available',
                                                style: TextStyle(
                                                  color: Colors.blue[900],
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            Divider(
                                              color: Colors.blue[900],
                                              thickness: 1,
                                              height: 10,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8.0),
                                              child: Text(
                                                joke.delivery ??
                                                    'No delivery available',
                                                style: TextStyle(
                                                  color: Colors.blue[900],
                                                  fontSize: 14,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            if (joke.category != null)
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 12,
                                                      vertical: 6,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: Colors.blue[50],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Icon(
                                                          _getCategoryIcon(
                                                              joke.category!),
                                                          size: 16,
                                                          color:
                                                              Colors.blue[900],
                                                        ),
                                                        const SizedBox(
                                                            width: 4),
                                                        Text(
                                                          joke.category!,
                                                          style: TextStyle(
                                                            color: Colors
                                                                .blue[900],
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              )
                                          ])
                                        else
                                          Text(
                                            joke.joke ?? 'No joke available',
                                            style: TextStyle(
                                                color: Colors.blue[900]),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}

IconData _getCategoryIcon(String category) {
  switch (category.toLowerCase()) {
    case 'programming':
      return Icons.computer;
    case 'general':
      return Icons.public;
    default:
      return Icons.emoji_emotions;
  }
}
