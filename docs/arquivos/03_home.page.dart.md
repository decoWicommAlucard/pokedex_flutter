# home.page.dart

## O que esse arquivo faz

`lib/pages/home/home.page.dart` monta a tela principal da Pokedex.

Ele junta:

- cabecalho;
- campo de busca;
- grade de Pokemons;
- scroll infinito;
- ligacao com a store.

## Objetos principais

```dart
final store = HomeStore();
final scrollController = ScrollController();
```

## O que cada um faz

- `store`: guarda estado e regras de negocio.
- `scrollController`: monitora quando o usuario chega ao fim da lista.

## O que acontece no inicio da tela

```dart
@override
void initState() {
  super.initState();
  store.loadPokemons();
  scrollController.addListener(scrollListener);
}
```

### Passo a passo

1. a tela e criada;
2. chama `loadPokemons()` para buscar os primeiros itens;
3. registra um listener no scroll.

## O que acontece no final da vida da tela

```dart
@override
void dispose() {
  scrollController.removeListener(scrollListener);
  scrollController.dispose();
  super.dispose();
}
```

Isso evita listener perdido e vazamento de memoria.

## Campo de busca

```dart
TextField(
  onChanged: store.setSearch,
  decoration: InputDecoration(
    hintText: "Nome ou identificador",
  ),
)
```

### Como foi feito

1. o usuario digita;
2. `onChanged` dispara;
3. a store recebe o texto;
4. a lista filtrada e recalculada;
5. a grade atualiza.

## Grade dos cards

```dart
GridView.builder(
  controller: scrollController,
  itemCount: store.filteredPokemons.length + 1,
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    crossAxisSpacing: 10,
    mainAxisSpacing: 10,
    childAspectRatio: 2 / 2.8,
  ),
)
```

## O papel do `Observer`

```dart
Observer(
  builder: (_) {
    return Expanded(
      child: GridView.builder(
```

O `Observer` faz a tela reagir a mudancas do MobX.

Quando `filteredPokemons` ou `isLoading` mudam, essa parte da interface e reconstruida.

## O que foi feito aqui

- carregamento inicial da lista;
- campo de busca conectado a store;
- grade com 2 cards por linha;
- spinner no fim da lista;
- scroll infinito com `ScrollController`.
