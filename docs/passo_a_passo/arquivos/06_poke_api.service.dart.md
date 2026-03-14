# Recriando poke_api.service.dart

## Objetivo

Criar a camada de API responsavel por buscar os Pokemons na PokeAPI.

## Antes de comecar

Voce ja deve ter:

- `uno` instalado;
- `PokeResponse` criado;
- `PokemonDetails` criado.

## Passo 1: criar o arquivo

Crie:

```text
lib/services/poke_api.service.dart
```

## Passo 2: adicionar os imports

```dart
import 'dart:io';

import 'package:pokedex_flutter/models/poke_response.model.dart';
import 'package:pokedex_flutter/models/pokemon_details.model.dart';
import 'package:uno/uno.dart';
```

## Passo 3: criar a classe

```dart
class PokeApiService {
  late final Uno _uno;
```

## Passo 4: configurar o `Uno`

Adicione o construtor:

```dart
PokeApiService() {
  _uno = Uno(baseURL: "https://pokeapi.co/api/v2");
}
```

## Passo 5: criar o metodo de listagem

Adicione:

```dart
Future<PokeResponse> getPokemon({required int offset}) async {
  final response = await _uno.get("/pokemon?offset=$offset&limit=20");

  if (response.status != HttpStatus.ok) {
    throw Exception("Failed to load pokemon");
  }

  return PokeResponse.fromJson(response.data);
}
```

## Passo 6: criar o metodo de detalhe

Adicione:

```dart
Future<PokemonDetails> getPokemonDetail({required String id}) async {
  final response = await _uno.get("/pokemon/$id");

  if (response.status != HttpStatus.ok) {
    throw Exception("Failed to load pokemon detail");
  }

  return PokemonDetails.fromJson(response.data);
}
```

## O que foi feito aqui

1. foi criada uma camada separada para HTTP;
2. a URL base da PokeAPI foi centralizada;
3. a rota usa paginacao com `offset` e `limit`;
4. a resposta da listagem volta convertida em `PokeResponse`;
5. a resposta de detalhe volta convertida em `PokemonDetails`.

## Como verificar

1. quando a `HomeStore` chamar `getPokemon`, o app deve buscar 20 Pokemons por vez;
2. quando a `DetailStore` chamar `getPokemonDetail`, a `DetailPage` deve conseguir mostrar nome, ID, tipos, caracteristicas e stats.
