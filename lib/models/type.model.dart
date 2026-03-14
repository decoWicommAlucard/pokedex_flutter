import 'package:pokedex_flutter/models/pokemon_type.model.dart';

class Type {
  final int slot;
  final PokemonType type;

  Type({required this.slot, required this.type});

  factory Type.fromJson(Map<String, dynamic> data) {
    return Type(slot: data['slot'], type: data['type']);
  }
}
