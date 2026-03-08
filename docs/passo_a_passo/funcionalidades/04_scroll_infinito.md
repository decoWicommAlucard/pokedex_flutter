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
scrollController.addListener(scrollListener);
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

## Passo 4: passar o controller para o `GridView`

```dart
GridView.builder(
  controller: scrollController,
)
```

## Passo 5: preparar a store para paginacao

Na `HomeStore`:

1. crie `int offset = 0;`
2. em `loadPokemons()`, chame a API com esse offset;
3. depois use `offset += 20;`
4. adicione os novos itens com `addAll`.

## Passo 6: criar o loader do final

Na grade:

1. use `itemCount: store.filteredPokemons.length + 1;`
2. no ultimo item, mostre o `CircularProgressIndicator` quando `isLoading` for `true`.

## Como verificar

1. abra o app;
2. role ate o fim;
3. veja o spinner aparecer;
4. confira se novos Pokemons sao adicionados no final.
