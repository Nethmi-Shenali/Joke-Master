class Joke {
  final String? category;
  final String? type;
  final String? joke;
  final String? setup;
  final String? delivery;

  Joke({this.category, this.type, this.joke, this.setup, this.delivery});

  // Factory method to create a Joke object from JSON
  factory Joke.fromJson(Map<String, dynamic> json) {
    return Joke(
      category: json['category'],
      type: json['type'],
      joke: json['joke'],
      setup: json['setup'],
      delivery: json['delivery'],
    );
  }

  // Convert a Joke object to a JSON map (for shared_preferences)
  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'type': type,
      'joke': joke,
      'setup': setup,
      'delivery': delivery,
    };
  }
}
