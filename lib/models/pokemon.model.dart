class Pokemon {
  final String name;
  final String url;

  String get id {
    final data = url.split('/');
    data.removeLast();
    return data.last;
  }

  String get imageUrl =>
      "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png";

  Pokemon({required this.name, required this.url});

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(name: json['name'], url: json['url']);
  }
}
