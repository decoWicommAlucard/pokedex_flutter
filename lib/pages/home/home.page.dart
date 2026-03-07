import 'package:flutter/material.dart';
import 'package:pokedex_flutter/colors.dart';
import 'package:pokedex_flutter/widgets/poke_card.widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Pokedex',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),

              SizedBox(height: 20),

              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'search for pokemon by name or using its National Pokedex number.',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: primaryColor,
                  ),
                ),
              ),

              SizedBox(height: 20),

              TextField(
                decoration: InputDecoration(
                  hintText: "Nome ou identificador",
                  hintStyle: TextStyle(color: Color(0xFFA1AAAF)),
                  filled: true,
                  fillColor: Color(0xFFE9F2F2),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Icon(Icons.search, color: primaryColor),
                ),
              ),

              SizedBox(height: 20),

              Expanded(
                child: GridView.builder(
                  itemCount: 20,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 2 / 2.8,
                  ),
                  itemBuilder: (context, index) {
                    return PokeCard();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
