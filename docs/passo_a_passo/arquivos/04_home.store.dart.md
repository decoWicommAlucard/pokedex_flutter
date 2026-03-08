# Recriando home.store.dart

## Objetivo

Criar a store principal do projeto com MobX para controlar:

- lista de Pokemons;
- loading;
- busca;
- filtro;
- paginacao;
- atualizacao das cores dos cards.

## Antes de comecar

Voce ja deve ter:

- `Pokemon`;
- `PokeApiService`;
- `mobx`, `build_runner` e `mobx_codegen` instalados.

## Passo 1: importar as dependencias

Adicione:

```dart
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:pokedex_flutter/models/pokemon.model.dart';
import 'package:pokedex_flutter/services/poke_api.service.dart';
part 'home.store.g.dart';
```

## Passo 2: criar a assinatura da store

Adicione:

```dart
class HomeStore = HomeStoreBase with _$HomeStore;
```

## Passo 3: criar a classe base

Adicione:

```dart
abstract class HomeStoreBase with Store {
```

## Passo 4: criar o service e o offset

Dentro da classe, adicione:

```dart
final _service = PokeApiService();
int offset = 0;
```

## Passo 5: criar os observables

Adicione:

```dart
@observable
bool isLoading = false;

@observable
String? search;

@observable
ObservableList<Pokemon> pokemons = <Pokemon>[].asObservable();
```

## Passo 6: criar o filtro computado

Adicione:

```dart
@computed
List<Pokemon> get filteredPokemons {
  if (search == null || search!.isEmpty) {
    return pokemons.toList();
  }
  return pokemons
      .where(
        (pokemon) =>
            pokemon.name.toLowerCase().contains(search!.toLowerCase()) ||
            pokemon.id == search,
      )
      .toList();
}
```

## Passo 7: criar a action da busca

Adicione:

```dart
@action
void setSearch(String text) => search = text;
```

## Passo 8: criar a action de carregamento

Adicione:

```dart
@action
Future<void> loadPokemons() async {
  isLoading = true;

  final pokeResponse = await _service.getPokemon(offset: offset);

  offset += 20;
  pokemons.addAll(pokeResponse.results);

  isLoading = false;
}
```

## Passo 9: criar a action de atualizacao de cor

Adicione:

```dart
@action
void updatePokemonColor({required String pokemonId, required Color color}) {
  final indexPokemon = pokemons.indexWhere(
    (pokemon) => pokemon.id == pokemonId,
  );
  pokemons[indexPokemon] = pokemons[indexPokemon].copyWith(color: color);
}
```

## Codigo final esperado

O arquivo final deve conter:

- imports;
- `part 'home.store.g.dart';`;
- assinatura `HomeStore = HomeStoreBase with _$HomeStore`;
- observables;
- computed;
- actions.

## Como verificar

1. rode `dart run build_runner build`;
2. veja se `home.store.g.dart` foi gerado;
3. rode o app;
4. confirme se a tela carrega, filtra e muda a cor dos cards.
