# detail.page.dart

## O que esse arquivo faz hoje

`lib/pages/detail/detail.page.dart` renderiza a tela de detalhe inicial do Pokemon selecionado na `HomePage`.

## O que a tela recebe

```dart
final Pokemon pokemon;
```

A `HomePage` envia esse objeto quando o usuario toca em um card.

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
    ],
  ),
);
```

## O que isso entrega

- fundo do `SliverAppBar` usando `pokemon.color`;
- imagem oficial em destaque;
- animacao `Hero` conectada ao card da lista;
- estrutura pronta para crescer com mais secoes no `CustomScrollView`.

## Como ela entra no fluxo do app

1. o usuario toca em um `PokeCard`;
2. a `HomePage` faz `Navigator.push`;
3. a `DetailPage` recebe o `Pokemon`;
4. a mesma imagem e animada entre lista e detalhe via `Hero`.

## Limitacao atual

Essa tela ainda e inicial. Hoje ela mostra apenas o topo visual do Pokemon e nao busca dados adicionais da API, como tipos, habilidades ou stats.
