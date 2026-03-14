import 'package:pokedex_flutter/models/pokemon_type.model.dart';
import 'package:pokedex_flutter/models/stat.model.dart';

class PokemonDetails {
  final String name;
  final int id;
  final int height;
  final int weight;
  final int baseExperience;
  final List<Stat>? stats;
  final List<PokemonType>? types;

  PokemonDetails({
    required this.name,
    required this.id,
    required this.height,
    required this.weight,
    required this.baseExperience,
    this.stats,
    this.types,
  });

  factory PokemonDetails.fromJson(Map<String, dynamic> data) {
    return PokemonDetails(
      name: data['name'],
      id: data['id'],
      height: data['height'].toDouble(),
      weight: data['weight'].toDouble(),
      baseExperience: data['base_experience'],
      stats: (data['stats'] != null ? data['stats'] as List<dynamic> : null)
          ?.map((stat) => Stat.fromJson(stat))
          .toList(),
      types: (data['types'] as List<dynamic>?)
          ?.map((type) => PokemonType.fromJson(type['type']))
          .toList(),
    );
  }
}
