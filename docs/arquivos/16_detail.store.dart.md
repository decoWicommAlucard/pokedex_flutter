# detail.store.dart

## O que esse arquivo faz

`lib/pages/detail/stores/detail.store.dart` controla o estado da camada de detalhes de um Pokemon.

## Estrutura principal

```dart
part 'detail.store.g.dart';

class DetailStore = DetailStoreBase with _$DetailStore;
```

## O que isso significa

- `DetailStoreBase` e a classe escrita manualmente;
- `_$DetailStore` vem do arquivo gerado pelo MobX;
- `detail.store.g.dart` precisa ser gerado pelo `build_runner`.

## Estado principal

```dart
final _service = PokeApiService();

@observable
bool isLoading = false;

@observable
PokemonDetails? pokemonDetails;
```

## O que cada parte faz

- `_service`: chama a API de detalhe;
- `isLoading`: indica se a busca esta em andamento;
- `pokemonDetails`: guarda os dados detalhados carregados.

## Action principal

```dart
@action
Future<void> getPokemonDetailsData(String id) async {
  isLoading = true;

  final pokeResponse = await _service.getPokemonDetail(id: id);
  pokemonDetails = pokeResponse;

  isLoading = false;
}
```

## Passo a passo

1. liga `isLoading`;
2. chama o endpoint de detalhe pelo `id`;
3. recebe um `PokemonDetails`;
4. salva o resultado em `pokemonDetails`;
5. desliga `isLoading`.

## Observacao importante

Essa store ja esta pronta, mas a `DetailPage` ainda nao usa esse estado na interface atual.
