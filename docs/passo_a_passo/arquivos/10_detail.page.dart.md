# Recriando detail.page.dart

## Objetivo

Criar a tela de detalhe inicial usada quando o usuario toca em um Pokemon na grade.

## Passo 1: criar o arquivo

Crie:

```text
lib/pages/detail/detail.page.dart
```

## Passo 2: adicionar os imports

```dart
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pokedex_flutter/colors.dart';
import 'package:pokedex_flutter/models/pokemon.model.dart';
import 'package:pokedex_flutter/pages/detail/stores/detail.store.dart';
```

## Passo 3: criar a classe, receber o Pokemon e instanciar a store

```dart
class DetailPage extends StatelessWidget {
  final Pokemon pokemon;
  final DetailStore store = DetailStore();

  DetailPage({super.key, required this.pokemon}) {
    store.getPokemonDetailsData(pokemon.id);
  }
```

## Passo 4: montar o `Scaffold`

Use um `CustomScrollView` com `SliverAppBar` e um `Observer`:

```dart
@override
Widget build(BuildContext context) {
  return Scaffold(
    body: CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: pokemon.color,
          pinned: false,
          floating: true,
          collapsedHeight: 60,
          expandedHeight: 300,
          flexibleSpace: FlexibleSpaceBar(
            background: Hero(
              tag: ValueKey(pokemon.id),
              child: CachedNetworkImage(imageUrl: pokemon.imageUrl),
            ),
          ),
        ),

        Observer(
          builder: (ctx) {
            final pokemonDetails = store.pokemonDetails;

            return store.isLoading
                ? SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator()),
                  )
                : SliverPadding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 20,
                    ),
                    sliver: SliverToBoxAdapter(
                      child: Column(
                        children: [
                          Text(
                            pokemonDetails!.name.toUpperCase(),
                            style: TextStyle(
                              fontSize: 20,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "#${store.pokemonDetails!.id}",
                            style: const TextStyle(
                              fontSize: 16,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: 20),
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
          },
        ),
      ],
    ),
  );
}
```

## O que foi feito aqui

1. a tela agora recebe um `Pokemon`;
2. a tela cria uma `DetailStore`;
3. o carregamento de detalhe comeca com `store.getPokemonDetailsData(pokemon.id)`;
4. a cor do topo vem de `pokemon.color`;
5. a imagem reaproveita o mesmo `Hero` do card;
6. o `Observer` escuta `isLoading`;
7. o corpo ja mostra nome, ID e tipos;
8. a estrutura permite adicionar mais slivers depois.

## Como verificar

Toque em um card na `HomePage`.

Se estiver certo:

1. a tela de detalhe abre com a imagem animada e o topo colorido;
2. o loading de detalhe e disparado;
3. depois do loading, aparecem nome, numero e tipos do Pokemon.
