# Recriando pokemon_details.model.dart

## Objetivo

Criar o model que representa a resposta detalhada de um Pokemon especifico.

## Antes de comecar

Voce ja deve ter:

- `Stat`;
- `PokemonType`.

## Passo 1: criar o arquivo

Crie:

```text
lib/models/pokemon_details.model.dart
```

## Passo 2: adicionar os imports

```dart
import 'package:pokedex_flutter/models/pokemon_type.model.dart';
import 'package:pokedex_flutter/models/stat.model.dart';
```

## Passo 3: criar a classe e os campos

```dart
class PokemonDetails {
  final String name;
  final int id;
  final int height;
  final int weight;
  final int baseExperience;
  final List<Stat>? stats;
  final List<PokemonType>? types;
```

## Passo 4: criar o construtor

```dart
PokemonDetails({
  required this.name,
  required this.id,
  required this.height,
  required this.weight,
  required this.baseExperience,
  this.stats,
  this.types,
});
```

## Passo 5: criar o `fromJson`

```dart
factory PokemonDetails.fromJson(Map<String, dynamic> data) {
  return PokemonDetails(
    name: data['name'],
    id: data['id'],
    height: data['height'],
    weight: data['weight'],
    baseExperience: data['base_experience'],
    stats: (data['stats'] != null ? data['stats'] as List<dynamic> : null)
        ?.map((stat) => Stat.fromJson(stat))
        .toList(),
    types: (data['types'] as List<dynamic>?)
        ?.map((type) => PokemonType.fromJson(type['type']))
        .toList(),
  );
}
```

## O que foi feito aqui

1. o JSON de detalhe virou um model Dart;
2. `base_experience` virou `baseExperience`;
3. `stats` viram `List<Stat>`;
4. `types` viram `List<PokemonType>`.

## Como verificar

Quando a `DetailStore` carregar os detalhes, `pokemonDetails.name`, `pokemonDetails.id` e `pokemonDetails.types` devem ficar disponiveis na `DetailPage`.
