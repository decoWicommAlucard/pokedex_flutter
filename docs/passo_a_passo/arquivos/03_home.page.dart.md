# Recriando home.page.dart

## Objetivo

Montar a tela principal com:

- titulo;
- subtitulo;
- campo de busca;
- grade de cards;
- observer do MobX;
- scroll infinito.

## Antes de comecar

Voce ja deve ter:

- `HomeStore`;
- `DetailPage`;
- `PokeCard`;
- `primaryColor`.

## Passo 1: importar as dependencias

Adicione:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pokedex_flutter/colors.dart';
import 'package:pokedex_flutter/pages/detail/detail.page.dart';
import 'package:pokedex_flutter/store/home.store.dart';
import 'package:pokedex_flutter/widgets/poke_card.widget.dart';
```

## Passo 2: criar a `HomePage`

Como essa tela usa `initState`, `dispose` e `ScrollController`, ela precisa ser `StatefulWidget`.

Crie:

```dart
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}
```

## Passo 3: criar store e scroll controller

Dentro do state:

```dart
final store = HomeStore();
final scrollController = ScrollController();
```

## Passo 4: carregar os Pokemons no inicio

Adicione:

```dart
@override
void initState() {
  super.initState();
  store.loadPokemons();
  scrollController.addListener(scrollListener);
}
```

## Passo 5: limpar o controller no final

Adicione:

```dart
@override
void dispose() {
  scrollController.removeListener(scrollListener);
  scrollController.dispose();
  super.dispose();
}
```

## Passo 6: criar a regra do scroll infinito

Adicione:

```dart
void scrollListener() {
  if (scrollController.offset >= scrollController.position.maxScrollExtent &&
      !scrollController.position.outOfRange) {
    store.loadPokemons();
  }
}
```

## Passo 7: montar o layout principal

No `build`, monte um `Scaffold` com:

- `SafeArea`;
- `Padding`;
- `Column`;
- titulo;
- subtitulo;
- `TextField`;
- `Observer` com `GridView.builder`.

## Passo 8: adicionar o campo de busca

Use:

```dart
TextField(
  onChanged: store.setSearch,
  decoration: InputDecoration(
    hintText: "Nome ou identificador",
    hintStyle: TextStyle(color: Color(0xFFA1AAAF)),
    filled: true,
    fillColor: Color(0xFFE9F2F2),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide.none,
    ),
    prefixIcon: Icon(Icons.search, color: primaryColor),
  ),
)
```

## Passo 9: usar `Observer` para reagir ao MobX e abrir o detalhe

Adicione um `Observer` com este miolo:

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

        return InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DetailPage(pokemon: pokemon),
              ),
            );
          },
          child: PokeCard(
            pokemon: pokemon,
            store: store,
          ),
        );
      }
      return store.isLoading
          ? Center(child: CircularProgressIndicator())
          : Container();
    },
  ),
)
```

## O que foi feito aqui

1. a tela agora cria a store;
2. busca dados assim que abre;
3. recebe o texto da busca;
4. mostra a lista filtrada;
5. abre a `DetailPage` ao tocar em um card;
6. carrega mais itens ao chegar no fim;
7. mostra spinner no ultimo item.

## Como verificar

Rode o app e confira:

1. a tela abre com titulo e campo de busca;
2. os primeiros Pokemons aparecem;
3. a busca filtra os cards;
4. tocar em um card abre a tela de detalhe;
5. ao rolar ate o fim, mais itens sao carregados.
