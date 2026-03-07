import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Pokedex',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ),

              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'search for pokemon by name or using its National Pokedex number.',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
