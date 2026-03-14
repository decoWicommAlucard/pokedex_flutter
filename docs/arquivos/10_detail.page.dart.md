# detail.page.dart

## O que esse arquivo faz hoje

`lib/pages/detail/detail.page.dart` renderiza a tela final de detalhe do Pokemon selecionado na `HomePage`.

## Imports principais

```dart
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pokedex_flutter/pages/detail/stores/detail.store.dart';
import 'package:pokedex_flutter/widgets/characteristc.widget.dart';
import 'package:pokedex_flutter/widgets/percentage_indicator.widget.dart';
```

Esses imports mostram que a tela:

- observa o estado com MobX;
- busca dados pela `DetailStore`;
- quebra partes visuais em widgets menores.

## O que a tela recebe

```dart
final Pokemon pokemon;
```

A `HomePage` envia esse objeto quando o usuario toca em um card.

## Estado usado pela tela

```dart
final DetailStore store = DetailStore();

DetailPage({super.key, required this.pokemon}) {
  store.getPokemonDetailsData(pokemon.id);
}
```

Ou seja:

1. a tela cria a `DetailStore`;
2. assim que e instanciada, ela pede os detalhes pelo `id`;
3. o carregamento ja comeca antes do `build`.

## Estrutura atual

```dart
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
                        Text(pokemonDetails!.name.toUpperCase()),
                        Text("#${store.pokemonDetails!.id}"),
                        Wrap(...types),
                        Row(
                          children: [
                            Characteristc(...),
                            Characteristc(...),
                            Characteristc(...),
                          ],
                        ),
                        ListView.builder(
                          itemBuilder: (ctx, index) {
                            return PercentageIndicator(...);
                          },
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
```

## O que isso entrega

- fundo do `SliverAppBar` usando `pokemon.color`;
- imagem oficial em destaque;
- animacao `Hero` conectada ao card da lista;
- disparo da busca de detalhe pela `DetailStore`;
- observacao do loading com `Observer`;
- exibicao do nome em caixa alta;
- exibicao do numero da Pokedex;
- exibicao dos tipos com `Chip`;
- exibicao de altura, experiencia e peso com `Characteristc`;
- exibicao da lista de stats com `PercentageIndicator`.

## Como ela entra no fluxo do app

1. o usuario toca em um `PokeCard`;
2. a `HomePage` faz `Navigator.push`;
3. a `DetailPage` recebe o `Pokemon`;
4. a mesma imagem e animada entre lista e detalhe via `Hero`;
5. a tela busca `PokemonDetails`;
6. o corpo mostra os dados detalhados.

## Relacao com a camada de detalhe

Essa tela depende diretamente de:

- `PokeApiService.getPokemonDetail(...)`;
- `PokemonDetails`;
- `DetailStore`;
- `Characteristc`;
- `PercentageIndicator`.

Hoje ela ja usa todos os blocos principais do model:

- `name`;
- `id`;
- `types`;
- `height`;
- `baseExperience`;
- `weight`;
- `stats`.
