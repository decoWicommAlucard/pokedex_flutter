# poke_card.widget.dart

## O que esse arquivo faz

`lib/widgets/poke_card.widget.dart` desenha cada card da grade de Pokemons e descobre a cor dominante da imagem para pintar o fundo do item.

## O que o widget recebe

```dart
final Pokemon pokemon;
final HomeStore store;
```

- `pokemon` contem nome, id, imagem e cor atual do card;
- `store` e usada para salvar a cor descoberta no item correto.

## Por que ele e `StatefulWidget`

O widget executa uma rotina assincrona no `initState` para calcular a paleta da imagem:

```dart
@override
void initState() {
  super.initState();
  getPaletteColor();
}
```

## Como a cor e descoberta

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

Fluxo:

1. a imagem oficial do Pokemon e carregada;
2. o `PaletteGenerator` calcula a cor dominante;
3. a store atualiza aquele Pokemon na lista observavel;
4. o `Observer` reconstrui o card;
5. o `AnimatedContainer` anima a troca de cor.

## Estrutura visual

O card usa o valor reativo de `widget.pokemon.color`:

```dart
AnimatedContainer(
  duration: Duration(milliseconds: 500),
  decoration: BoxDecoration(
    color: widget.pokemon.color,
    borderRadius: BorderRadius.circular(10),
  ),
```

A imagem fica dentro de um `Hero` e usa `CachedNetworkImage`:

```dart
Hero(
  tag: ValueKey(widget.pokemon.id),
  child: CachedNetworkImage(
    imageUrl: widget.pokemon.imageUrl,
    height: 130,
  ),
)
```

Isso prepara a transicao para a `DetailPage` e evita recarregamentos desnecessarios da imagem.

## Outros detalhes

- `pokemon.color` comeca branco no model e depois muda para a cor dominante;
- `widget.pokemon.id.padLeft(4, '0')` mostra o numero com zeros a esquerda;
- o `Observer` faz o card reagir sem precisar de `setState()` para a cor.
