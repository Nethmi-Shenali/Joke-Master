import 'package:flutter/material.dart';

class FetchJokesButton extends StatelessWidget {
  final Future<void> Function() fetchJokes;

  const FetchJokesButton({super.key, required this.fetchJokes});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ElevatedButton.icon(
        onPressed: fetchJokes,
        icon: const Icon(Icons.refresh_rounded, color: Colors.white),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white.withOpacity(0.3),
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: Colors.white.withOpacity(0.5)),
          ),
        ),
        label: const Text(
          'Load Jokes',
          style: TextStyle(
              fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
