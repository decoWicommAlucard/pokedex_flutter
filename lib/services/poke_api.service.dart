import 'dart:io';

import 'package:pokedex_flutter/models/poke_response.model.dart';
import 'package:pokedex_flutter/models/pokemon_details.model.dart';
import 'package:uno/uno.dart';

class PokeApiService {
  late final Uno _uno;

  PokeApiService() {
    _uno = Uno(baseURL: "https://pokeapi.co/api/v2");
  }

  Future<PokeResponse> getPokemon({required int offset}) async {
    final response = await _uno.get("/pokemon?offset=$offset&limit=20");

    if (response.status != HttpStatus.ok) {
      throw Exception("Failed to load pokemon");
    }

    return PokeResponse.fromJson(response.data);
  }

  Future<PokemonDetails> getPokemonDetail({required String id}) async {
    final response = await _uno.get("/pokemon/$id");

    if (response.status != HttpStatus.ok) {
      throw Exception("Failed to load pokemon detail");
    }

    return PokemonDetails.fromJson(response.data);
  }
}
