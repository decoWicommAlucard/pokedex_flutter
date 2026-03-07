import 'dart:io';

import 'package:pokedex_flutter/models/poke_response.model.dart';
import 'package:uno/uno.dart';

class PokeApiService {
  late final Uno _uno;

  PokeApiService() {
    _uno = Uno(baseURL: "https://pokeapi.co/api/v2");
  }

  Future<PokeResponse> getPokemon() async {
    final response = await _uno.get("/pokemon");

    if (response.status != HttpStatus.ok) {
      throw Exception("Failed to load pokemon");
    }

    return PokeResponse.fromJson(response.data);
  }
}
