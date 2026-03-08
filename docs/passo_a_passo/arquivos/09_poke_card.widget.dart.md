# Recriando poke_card.widget.dart

## Objetivo

Criar o card visual de cada Pokemon, mostrando:

- imagem;
- nome;
- numero;
- cor dinamica baseada na imagem.

## Antes de comecar

Voce ja deve ter:

- `Pokemon`;
- `HomeStore`;
- `primaryColor`;
- `cached_network_image` instalado;
- `palette_generator` instalado.

## Passo 1: adicionar os imports

```dart
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:pokedex_flutter/colors.dart';
import 'package:pokedex_flutter/models/pokemon.model.dart';
import 'package:pokedex_flutter/store/home.store.dart';
```

## Passo 2: criar o widget e os parametros

```dart
class PokeCard extends StatefulWidget {
  final Pokemon pokemon;
  final HomeStore store;

  const PokeCard({super.key, required this.pokemon, required this.store});

  @override
  State<PokeCard> createState() => _PokeCardState();
}
```

## Passo 3: criar o state

Adicione:

```dart
class _PokeCardState extends State<PokeCard> {
  Color backgroundColor = Colors.white;
```

## Passo 4: chamar a extracao de cor no inicio

```dart
@override
void initState() {
  super.initState();
  getPaletteColor();
}
```

## Passo 5: criar o metodo `getPaletteColor`

```dart
Future<void> getPaletteColor() async {
  final paletteGenerator = await PaletteGenerator.fromImageProvider(
    NetworkImage(widget.pokemon.imageUrl),
  );

  if (paletteGenerator.dominantColor != null && mounted) {
    widget.store.updatePokemonColor(
      pokemonId: widget.pokemon.id,
      color: paletteGenerator.dominantColor!.color,
    );
  }
}
```

## Passo 6: montar o card visual

No `build`, crie um `Card` com `Observer` e `AnimatedContainer`.

O miolo principal deve ser:

```dart
AnimatedContainer(
  duration: Duration(milliseconds: 500),
  decoration: BoxDecoration(
    color: widget.pokemon.color,
    borderRadius: BorderRadius.circular(10),
  ),
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Hero(
        tag: ValueKey(widget.pokemon.id),
        child: CachedNetworkImage(
          imageUrl: widget.pokemon.imageUrl,
          height: 130,
        ),
      ),
      Text(
        widget.pokemon.name,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: primaryColor,
        ),
      ),
      Text(
        widget.pokemon.id.padLeft(4, '0'),
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: primaryColor,
        ),
      ),
    ],
  ),
)
```

## Passo 7: adicionar o `dispose`

```dart
@override
void dispose() {
  backgroundColor = Colors.white;
  super.dispose();
}
```

## O que foi feito aqui

1. cada card recebe um Pokemon;
2. a imagem e carregada com cache;
3. o `Hero` prepara a transicao para o detalhe;
4. a cor dominante da imagem e calculada;
5. a store atualiza a cor daquele Pokemon;
6. o fundo do card muda com animacao.

## Como verificar

Rode o app e veja:

1. o card aparece branco primeiro;
2. depois muda de cor;
3. mostra imagem, nome e numero do Pokemon;
4. a imagem participa da animacao ao abrir a tela de detalhe.
