# poke_card.widget.dart

## O que esse arquivo faz

`lib/widgets/poke_card.widget.dart` desenha cada card da grade de Pokemons.

## O que o widget recebe

```dart
final Pokemon pokemon;
final HomeStore store;
```

## Por que ele e `StatefulWidget`

Porque ele executa uma logica assincrona no `initState` para descobrir a cor dominante da imagem.

## Inicio do card

```dart
@override
void initState() {
  super.initState();
  getPaletteColor();
}
```

## Captura da cor dominante

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

## Passo a passo

1. carrega a imagem do Pokemon;
2. o `PaletteGenerator` analisa a imagem;
3. pega a cor dominante;
4. envia essa cor para a store;
5. a store atualiza o Pokemon;
6. o card muda na tela.

## Parte visual principal

```dart
AnimatedContainer(
  duration: Duration(milliseconds: 500),
  decoration: BoxDecoration(
    color: widget.pokemon.color,
    borderRadius: BorderRadius.circular(10),
  ),
```

## O que foi feito aqui

- o card comeca branco;
- depois recebe a cor dominante;
- a troca e animada em 500 milissegundos.

## Outros detalhes

- `Image.network` carrega a imagem online;
- `widget.pokemon.id.padLeft(4, '0')` mostra o numero com zeros a esquerda.
