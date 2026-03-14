# Recriando detail.store.dart

## Objetivo

Criar a store do detalhe que busca e guarda `PokemonDetails`.

## Antes de comecar

Voce ja deve ter:

- `PokemonDetails`;
- `PokeApiService`;
- `mobx`, `build_runner` e `mobx_codegen`.

## Passo 1: criar o arquivo

Crie:

```text
lib/pages/detail/stores/detail.store.dart
```

## Passo 2: adicionar os imports

```dart
import 'package:mobx/mobx.dart';
import 'package:pokedex_flutter/models/pokemon_details.model.dart';
import 'package:pokedex_flutter/services/poke_api.service.dart';
part 'detail.store.g.dart';
```

## Passo 3: criar a assinatura da store

```dart
class DetailStore = DetailStoreBase with _$DetailStore;
```

## Passo 4: criar a classe base

```dart
abstract class DetailStoreBase with Store {
  final _service = PokeApiService();
```

## Passo 5: criar os observables

```dart
@observable
bool isLoading = false;

@observable
PokemonDetails? pokemonDetails;
```

## Passo 6: criar a action principal

```dart
@action
Future<void> getPokemonDetailsData(String id) async {
  isLoading = true;

  final pokeResponse = await _service.getPokemonDetail(id: id);
  pokemonDetails = pokeResponse;

  isLoading = false;
}
```

## O que foi feito aqui

1. a store de detalhe ficou separada da tela;
2. `isLoading` controla o carregamento;
3. `pokemonDetails` guarda o resultado final;
4. a action usa o endpoint `/pokemon/{id}`.

## Como verificar

Quando a `DetailPage` chamar `store.getPokemonDetailsData(pokemon.id)`, a store deve preencher `pokemonDetails`.
