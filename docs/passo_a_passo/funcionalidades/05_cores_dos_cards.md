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

## Passo 3: criar o `PokeCard` como `StatefulWidget`

Ele precisa de `initState()` para executar a extracao de cor quando aparecer.

## Passo 4: criar o metodo `getPaletteColor`

Use:

```dart
PaletteGenerator.fromImageProvider(
  NetworkImage(widget.pokemon.imageUrl),
)
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

## Passo 7: usar a cor no card

Dentro do `AnimatedContainer`, use:

```dart
color: widget.pokemon.color
```

## Como verificar

1. abra a tela;
2. veja os cards aparecerem brancos;
3. depois veja cada card assumir uma cor diferente conforme sua imagem.
