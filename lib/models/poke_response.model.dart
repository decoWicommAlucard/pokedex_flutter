import 'package:pokedex_flutter/models/pokemon.model.dart';

class PokeResponse {
  final int count;
  final String? next;
  final String? previous;
  final List<Pokemon> results;

  PokeResponse({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  factory PokeResponse.fromJson(Map<String, dynamic> json) {
    return PokeResponse(
      count: json['count'],
      next: json['next'],
      previous: json['previous'],
      results: (json['results'] as List)
          .map((e) => Pokemon.fromJson(e))
          .toList(),
    );
  }
}
