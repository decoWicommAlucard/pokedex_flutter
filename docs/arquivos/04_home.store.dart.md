# home.store.dart

## O que esse arquivo faz

`lib/store/home.store.dart` e a camada principal de estado da tela inicial.

Ele controla:

- carregamento dos Pokemons;
- texto da busca;
- filtragem;
- lista observavel;
- atualizacao das cores dos cards.

## Estrutura do MobX

```dart
part 'home.store.g.dart';

class HomeStore = HomeStoreBase with _$HomeStore;
```

## O que isso significa

- `HomeStoreBase` e a classe escrita manualmente;
- `_$HomeStore` vem do arquivo gerado;
- `home.store.g.dart` e criado pelo `build_runner`.

## Estado principal

```dart
final _service = PokeApiService();

int offset = 0;

@observable
bool isLoading = false;

@observable
String? search;

@observable
ObservableList<Pokemon> pokemons = <Pokemon>[].asObservable();
```

## O que cada parte faz

- `_service`: chama a API.
- `offset`: controla a paginacao.
- `isLoading`: informa se ha requisicao em andamento.
- `search`: guarda o texto digitado.
- `pokemons`: lista reativa usada na interface.

## Filtro calculado

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

## Como foi feito

1. se a busca estiver vazia, a store devolve todos os Pokemons;
2. se houver texto, a store filtra por nome ou por ID;
3. a tela le `filteredPokemons` e mostra apenas o resultado calculado.

## Action para busca

```dart
@action
void setSearch(String text) => search = text;
```

Sempre que o usuario digita, essa action atualiza a busca.

## Action para carregar os Pokemons

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

## Passo a passo do carregamento

1. ativa `isLoading`;
2. chama o service com o `offset` atual;
3. recebe a resposta da API;
4. soma 20 ao `offset`;
5. adiciona os novos itens na lista;
6. encerra o loading.

## Action para cor do card

```dart
@action
void updatePokemonColor({required String pokemonId, required Color color}) {
  final indexPokemon = pokemons.indexWhere(
    (pokemon) => pokemon.id == pokemonId,
  );
  pokemons[indexPokemon] = pokemons[indexPokemon].copyWith(color: color);
}
```

## Como foi feito

1. encontra o Pokemon pelo ID;
2. cria uma copia dele com nova cor;
3. substitui o item na lista observavel;
4. o card muda de cor na tela.
