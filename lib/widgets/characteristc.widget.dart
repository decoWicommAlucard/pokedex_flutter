import 'package:flutter/material.dart';
import 'package:pokedex_flutter/colors.dart';

class Characteristc extends StatelessWidget {
  final String value;
  final String name;
  const Characteristc({super.key, required this.value, required this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Text(name, style: TextStyle(color: primaryColor)),
      ],
    );
  }
}
