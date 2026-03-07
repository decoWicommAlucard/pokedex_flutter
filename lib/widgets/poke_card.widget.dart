import 'package:flutter/material.dart';
import 'package:pokedex_flutter/colors.dart';

class PokeCard extends StatelessWidget {
  const PokeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png',
            height: 130,
          ),

          Text(
            'Pokemon ',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            '001',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
    ;
  }
}
