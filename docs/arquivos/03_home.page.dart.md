# home.page.dart

## O que esse arquivo faz

`lib/pages/home/home.page.dart` monta a tela principal da Pokedex e conecta interface, store, scroll infinito, busca e navegacao para a tela de detalhe.

## Objetos principais

```dart
final store = HomeStore();
final scrollController = ScrollController();
```

- `store` concentra a lista, o filtro, o carregamento e o estado reativo.
- `scrollController` detecta quando o usuario chega ao fim da grade.

## Inicio e encerramento da tela

```dart
@override
void initState() {
  super.initState();
  store.loadPokemons();
  scrollController.addListener(scrollListener);
}
```

Assim que a tela abre, ela carrega a primeira pagina da API e registra o listener do scroll.

```dart
@override
void dispose() {
  scrollController.removeListener(scrollListener);
  scrollController.dispose();
  super.dispose();
}
```

O `dispose` remove o listener e libera o controller corretamente.

## Busca

```dart
TextField(
  onChanged: store.setSearch,
  decoration: InputDecoration(
    hintText: "Nome ou identificador",
  ),
)
```

O texto digitado vai para `store.search`, e o getter `filteredPokemons` recalcula a grade automaticamente.

## Grade observada pelo MobX

```dart
Observer(
  builder: (_) {
    return Expanded(
      child: GridView.builder(
```

Esse `Observer` escuta principalmente:

- `store.filteredPokemons`;
- `store.isLoading`.

Quando esses valores mudam, a grade e o loader final sao reconstruidos.

## Navegacao para detalhe

Cada item da grade e encapsulado em um `InkWell`:

```dart
return InkWell(
  onTap: () {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DetailPage(pokemon: pokemon),
      ),
    );
  },
  child: PokeCard(pokemon: pokemon, store: store),
);
```

Isso coloca a `DetailPage` dentro do fluxo principal do app. A tela de detalhe recebe o mesmo `Pokemon` que ja estava na lista.

## Scroll infinito

```dart
void scrollListener() {
  if (scrollController.offset >= scrollController.position.maxScrollExtent &&
      !scrollController.position.outOfRange) {
    store.loadPokemons();
  }
}
```

Quando o usuario chega ao fim da grade, a `HomeStore` busca mais 20 Pokemons.

## O que esse arquivo entrega

- cabecalho com titulo e subtitulo;
- busca local por nome ou identificador;
- grade com 2 cards por linha;
- loader no ultimo item da lista;
- paginacao por scroll;
- navegacao para a `DetailPage`.
