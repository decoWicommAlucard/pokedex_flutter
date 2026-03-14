# Recriando os Detalhes do Pokemon

## Objetivo

Montar a camada de detalhe que busca dados completos de um Pokemon especifico.

## Passo 1: criar os models auxiliares

Crie nesta ordem:

1. `pokemon_stat.model.dart`
2. `stat.model.dart`
3. `pokemon_type.model.dart`
4. `type.model.dart`
5. `pokemon_details.model.dart`

## Passo 2: adicionar a rota de detalhe no service

No `PokeApiService`, adicione:

```dart
Future<PokemonDetails> getPokemonDetail({required String id}) async {
  final response = await _uno.get("/pokemon/$id");

  if (response.status != HttpStatus.ok) {
    throw Exception("Failed to load pokemon detail");
  }

  return PokemonDetails.fromJson(response.data);
}
```

## Passo 3: criar a `DetailStore`

Adicione:

```dart
@observable
bool isLoading = false;

@observable
PokemonDetails? pokemonDetails;

@action
Future<void> getPokemonDetailsData(String id) async {
  isLoading = true;

  final pokeResponse = await _service.getPokemonDetail(id: id);
  pokemonDetails = pokeResponse;

  isLoading = false;
}
```

## Passo 4: ligar a store na `DetailPage`

Dentro da tela:

```dart
final DetailStore store = DetailStore();

DetailPage({super.key, required this.pokemon}) {
  store.getPokemonDetailsData(pokemon.id);
}
```

## Passo 5: observar o loading e renderizar os dados

Use um `Observer` com:

```dart
final pokemonDetails = store.pokemonDetails;

return store.isLoading
    ? SliverToBoxAdapter(
        child: Center(child: CircularProgressIndicator()),
      )
    : SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        sliver: SliverToBoxAdapter(
          child: Column(
            children: [
              Text(pokemonDetails!.name.toUpperCase()),
              Text("#${store.pokemonDetails!.id}"),
              Wrap(
                spacing: 10,
                children: [
                  ...(store.pokemonDetails?.types
                          ?.map(
                            (type) => Chip(
                              label: Text(type.name),
                              backgroundColor: pokemon.color,
                            ),
                          )
                          .toList() ??
                      <Widget>[]),
                ],
              ),
            ],
          ),
        ),
      );
```

## Arquivos com codigo completo desta fase

- [06_poke_api.service.dart.md](../arquivos/06_poke_api.service.dart.md)
- [10_detail.page.dart.md](../arquivos/10_detail.page.dart.md)
- [11_pokemon_details.model.dart.md](../arquivos/11_pokemon_details.model.dart.md)
- [12_stat.model.dart.md](../arquivos/12_stat.model.dart.md)
- [13_pokemon_stat.model.dart.md](../arquivos/13_pokemon_stat.model.dart.md)
- [14_pokemon_type.model.dart.md](../arquivos/14_pokemon_type.model.dart.md)
- [15_type.model.dart.md](../arquivos/15_type.model.dart.md)
- [16_detail.store.dart.md](../arquivos/16_detail.store.dart.md)
- [17_detail.store.g.dart.md](../arquivos/17_detail.store.g.dart.md)

## Como verificar

1. toque em um card;
2. veja a `DetailPage` abrir;
3. confira o loading;
4. depois confira nome, ID e tipos do Pokemon.
