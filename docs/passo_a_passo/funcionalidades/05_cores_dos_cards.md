# Recriando as Cores dos Cards

## Objetivo

Fazer cada card pegar uma cor dominante da imagem do Pokemon.

## Passo 1: adicionar o campo `color` no model

No `Pokemon`, adicione:

```dart
final Color color;
```

E no construtor:

```dart
this.color = Colors.white
```

## Passo 2: criar `copyWith`

Isso sera usado para trocar so a cor do Pokemon.

Use este trecho completo no model:

```dart
import 'package:flutter/material.dart';

class Pokemon {
  final String name;
  final String url;
  final Color color;

  String get id {
    final data = url.split('/');
    data.removeLast();
    return data.last;
  }

  String get imageUrl =>
      "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png";

  Pokemon({required this.name, required this.url, this.color = Colors.white});

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(name: json['name'], url: json['url']);
  }

  Pokemon copyWith({String? name, String? url, Color? color}) {
    return Pokemon(
      name: name ?? this.name,
      url: url ?? this.url,
      color: color ?? this.color,
    );
  }
}
```

## Passo 3: criar o `PokeCard` como `StatefulWidget`

Ele precisa de `initState()` para executar a extracao de cor quando aparecer.

```dart
class PokeCard extends StatefulWidget {
  final Pokemon pokemon;
  final HomeStore store;

  const PokeCard({super.key, required this.pokemon, required this.store});

  @override
  State<PokeCard> createState() => _PokeCardState();
}
```

## Passo 4: criar o metodo `getPaletteColor`

Use:

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

## Passo 5: enviar a cor para a store

Quando encontrar a cor dominante, chame:

```dart
widget.store.updatePokemonColor(
  pokemonId: widget.pokemon.id,
  color: paletteGenerator.dominantColor!.color,
);
```

## Passo 6: atualizar a store

Na `HomeStore`, crie `updatePokemonColor()` para:

1. encontrar o Pokemon pelo ID;
2. usar `copyWith(color: color)`;
3. substituir o item na lista observavel.

```dart
@action
void updatePokemonColor({required String pokemonId, required Color color}) {
  final indexPokemon = pokemons.indexWhere(
    (pokemon) => pokemon.id == pokemonId,
  );
  pokemons[indexPokemon] = pokemons[indexPokemon].copyWith(color: color);
}
```

## Passo 7: usar a cor no card

Dentro do `AnimatedContainer`, use:

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
      Text(widget.pokemon.name),
      Text(widget.pokemon.id.padLeft(4, '0')),
    ],
  ),
)
```

## Arquivos com codigo completo desta fase

- [07_pokemon.model.dart.md](../arquivos/07_pokemon.model.dart.md)
- [09_poke_card.widget.dart.md](../arquivos/09_poke_card.widget.dart.md)
- [04_home.store.dart.md](../arquivos/04_home.store.dart.md)

## Como verificar

1. abra a tela;
2. veja os cards aparecerem brancos;
3. depois veja cada card assumir uma cor diferente conforme sua imagem.
