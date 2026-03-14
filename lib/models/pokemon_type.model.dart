class PokemonType {
  final String name;
  final String url;

  PokemonType({required this.name, required this.url});

  factory PokemonType.fromJson(Map<String, dynamic> json) {
    return PokemonType(name: json['name'], url: json['url']);
  }
}
