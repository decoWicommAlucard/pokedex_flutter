# Recriando a Chamada da API

## Objetivo

Refazer todo o caminho da API ate a tela.

## Passo 1: criar o model `Pokemon`

Ele sera usado para converter cada item de `results`.

Use este codigo:

```dart
import 'package:flutter/material.dart';

class Pokemon {
  final String name;
  final String url;
  final Color color;

  String get id {
    final data = url.split('/');
    data.removeLast();
    return data.last;
  }

  String get imageUrl =>
      "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png";

  Pokemon({required this.name, required this.url, this.color = Colors.white});

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(name: json['name'], url: json['url']);
  }

  Pokemon copyWith({String? name, String? url, Color? color}) {
    return Pokemon(
      name: name ?? this.name,
      url: url ?? this.url,
      color: color ?? this.color,
    );
  }
}
```

## Passo 2: criar o model `PokeResponse`

Ele sera usado para converter a resposta completa da PokeAPI.

Use este codigo:

```dart
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
```

## Passo 3: criar o `PokeApiService`

No service:

1. configure o `Uno` com `baseURL`;
2. crie o metodo `getPokemon`;
3. use `offset` e `limit=20`;
4. retorne `PokeResponse.fromJson(response.data)`.

```dart
import 'dart:io';

import 'package:pokedex_flutter/models/poke_response.model.dart';
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
}
```

## Passo 4: ligar a API na `HomeStore`

Dentro da store:

1. crie `final _service = PokeApiService();`
2. crie `offset = 0`;
3. crie `loadPokemons()`;
4. use `_service.getPokemon(offset: offset)`;
5. adicione os resultados em `pokemons`.

```dart
final _service = PokeApiService();

int offset = 0;

@observable
bool isLoading = false;

@observable
ObservableList<Pokemon> pokemons = <Pokemon>[].asObservable();

@action
Future<void> loadPokemons() async {
  isLoading = true;

  final pokeResponse = await _service.getPokemon(offset: offset);

  offset += 20;
  pokemons.addAll(pokeResponse.results);

  isLoading = false;
}
```

## Passo 5: disparar o carregamento inicial

Na `HomePage`, dentro do `initState`, chame:

```dart
@override
void initState() {
  super.initState();
  store.loadPokemons();
}
```

## Passo 6: mostrar os dados na tela

Use `Observer` e `GridView.builder` para renderizar os itens carregados:

```dart
Observer(
  builder: (_) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 2 / 2.8,
        ),
        itemCount: store.pokemons.length,
        itemBuilder: (context, index) {
          final pokemon = store.pokemons[index];
          return PokeCard(pokemon: pokemon, store: store);
        },
      ),
    );
  },
)
```

## Arquivos com codigo completo desta fase

- [07_pokemon.model.dart.md](../arquivos/07_pokemon.model.dart.md)
- [08_poke_response.model.dart.md](../arquivos/08_poke_response.model.dart.md)
- [06_poke_api.service.dart.md](../arquivos/06_poke_api.service.dart.md)
- [04_home.store.dart.md](../arquivos/04_home.store.dart.md)
- [03_home.page.dart.md](../arquivos/03_home.page.dart.md)

## Como verificar

Ao abrir o app, os primeiros 20 Pokemons devem aparecer.
