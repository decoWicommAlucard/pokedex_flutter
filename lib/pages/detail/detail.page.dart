import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_flutter/models/pokemon.model.dart';

class DetailPage extends StatelessWidget {
  final Pokemon pokemon;
  const DetailPage({super.key, required this.pokemon});

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
}
