# Recriando o Scroll Infinito

## Objetivo

Carregar mais Pokemons quando o usuario chegar ao fim da grade.

## Passo 1: criar um `ScrollController`

Na `HomePage`:

```dart
final scrollController = ScrollController();
```

## Passo 2: registrar o listener

No `initState`:

```dart
@override
void initState() {
  super.initState();
  store.loadPokemons();
  scrollController.addListener(scrollListener);
}
```

## Passo 3: criar o metodo `scrollListener`

Adicione:

```dart
void scrollListener() {
  if (scrollController.offset >= scrollController.position.maxScrollExtent &&
      !scrollController.position.outOfRange) {
    store.loadPokemons();
  }
}
```

## Passo 4: limpar o listener no `dispose`

```dart
@override
void dispose() {
  scrollController.removeListener(scrollListener);
  scrollController.dispose();
  super.dispose();
}
```

## Passo 5: passar o controller para o `GridView`

```dart
GridView.builder(
  controller: scrollController,
)
```

## Passo 6: preparar a store para paginacao

Na `HomeStore`:

1. crie `int offset = 0;`
2. em `loadPokemons()`, chame a API com esse offset;
3. depois use `offset += 20;`
4. adicione os novos itens com `addAll`.

```dart
int offset = 0;

@observable
bool isLoading = false;

@action
Future<void> loadPokemons() async {
  isLoading = true;

  final pokeResponse = await _service.getPokemon(offset: offset);

  offset += 20;
  pokemons.addAll(pokeResponse.results);

  isLoading = false;
}
```

## Passo 7: criar o loader do final

Na grade:

1. use `itemCount: store.filteredPokemons.length + 1;`
2. no ultimo item, mostre o `CircularProgressIndicator` quando `isLoading` for `true`.

```dart
Expanded(
  child: GridView.builder(
    controller: scrollController,
    itemCount: store.filteredPokemons.length + 1,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 2 / 2.8,
    ),
    itemBuilder: (context, index) {
      if (index < store.filteredPokemons.length) {
        final pokemon = store.filteredPokemons[index];
        return PokeCard(pokemon: pokemon, store: store);
      }

      return store.isLoading
          ? Center(child: CircularProgressIndicator())
          : Container();
    },
  ),
)
```

## Arquivos com codigo completo desta fase

- [04_home.store.dart.md](../arquivos/04_home.store.dart.md)
- [03_home.page.dart.md](../arquivos/03_home.page.dart.md)

## Como verificar

1. abra o app;
2. role ate o fim;
3. veja o spinner aparecer;
4. confira se novos Pokemons sao adicionados no final.
