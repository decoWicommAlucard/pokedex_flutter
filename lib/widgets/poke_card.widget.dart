import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:pokedex_flutter/colors.dart';
import 'package:pokedex_flutter/models/pokemon.model.dart';
import 'package:pokedex_flutter/store/home.store.dart';

class PokeCard extends StatefulWidget {
  final Pokemon pokemon;
  final HomeStore store;
  const PokeCard({super.key, required this.pokemon, required this.store});

  @override
  State<PokeCard> createState() => _PokeCardState();
}

class _PokeCardState extends State<PokeCard> {
  Color backgroundColor = Colors.white;

  @override
  void initState() {
    super.initState();
    getPaletteColor();
  }

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

  @override
  void dispose() {
    backgroundColor = Colors.white;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),

      child: Observer(
        builder: (context) {
          return AnimatedContainer(
            duration: Duration(milliseconds: 500),
            decoration: BoxDecoration(
              color: widget.pokemon.color,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(widget.pokemon.imageUrl, height: 130),

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
          );
        },
      ),
    );
  }
}
