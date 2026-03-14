import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
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
              return store.isLoading
                  ? SliverToBoxAdapter(child: CircularProgressIndicator())
                  : SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      sliver: SliverToBoxAdapter(child: Container()),
                    );
            },
          ),
        ],
      ),
    );
  }
}
