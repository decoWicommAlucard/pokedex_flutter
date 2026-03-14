import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pokedex_flutter/colors.dart';
import 'package:pokedex_flutter/models/pokemon.model.dart';
import 'package:pokedex_flutter/pages/detail/stores/detail.store.dart';

class DetailPage extends StatelessWidget {
  final Pokemon pokemon;
  final DetailStore store = DetailStore();

  DetailPage({super.key, required this.pokemon}) {
    store.getPokemonDetailsData(pokemon.id);
  }

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
}
