# Recriando poke_response.model.dart

## Objetivo

Criar o model que representa a resposta da listagem da PokeAPI.

## Antes de comecar

Voce ja deve ter o `Pokemon` criado.

## Passo 1: criar o arquivo

Crie:

```text
lib/models/poke_response.model.dart
```

## Passo 2: importar o model `Pokemon`

```dart
import 'package:pokedex_flutter/models/pokemon.model.dart';
```

## Passo 3: criar a classe e os campos

```dart
class PokeResponse {
  final int count;
  final String? next;
  final String? previous;
  final List<Pokemon> results;
```

## Passo 4: criar o construtor

```dart
PokeResponse({
  required this.count,
  required this.next,
  required this.previous,
  required this.results,
});
```

## Passo 5: criar o `fromJson`

```dart
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
```

## O que foi feito aqui

1. o JSON da PokeAPI passou a ter um model proprio;
2. a lista `results` passou a ser convertida em `List<Pokemon>`;
3. a store pode trabalhar com objetos prontos em vez de mapas crus.

## Como verificar

Quando a API responder, `results` deve chegar como lista de `Pokemon`, e nao como lista de `Map`.
