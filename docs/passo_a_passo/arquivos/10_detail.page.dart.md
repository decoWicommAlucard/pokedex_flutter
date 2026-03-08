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
import 'package:pokedex_flutter/models/pokemon.model.dart';
```

## Passo 3: criar a classe e receber o Pokemon

```dart
class DetailPage extends StatelessWidget {
  final Pokemon pokemon;

  const DetailPage({super.key, required this.pokemon});
```

## Passo 4: montar o `Scaffold`

Use um `CustomScrollView` com `SliverAppBar`:

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
      ],
    ),
  );
}
```

## O que foi feito aqui

1. a tela agora recebe um `Pokemon`;
2. a cor do topo vem de `pokemon.color`;
3. a imagem reaproveita o mesmo `Hero` do card;
4. a estrutura permite adicionar mais slivers depois.

## Como verificar

Toque em um card na `HomePage`.

Se estiver certo, a tela de detalhe abre com a imagem animada e o topo colorido.
