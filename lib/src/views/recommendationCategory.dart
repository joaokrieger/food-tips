import 'package:flutter/material.dart';
import 'package:food_tips/src/views/home.dart';

import '../consts.dart';
import 'foodList.dart';

void main() {
  runApp(RecommendationCategory());
}

class RecommendationCategory extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Image.asset('assets/img/icons/icn_back.png'),
          onPressed: () {
            // Ação ao clicar no ícone
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Home()),
            );
          },
        ),
      ),
      backgroundColor: Color(0xFF024424),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 20.0),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SizedBox(height: 16.0),
                  SizedBox(
                    height: 60.0,
                    width: 350.0,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFFF0F0F0), // Define a cor de fundo
                        onPrimary: Color(0xFF504848), // Define a cor do texto
                      ),
                      onPressed: () {
                        // Ação do botão Alimentos
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const FoodList(filteringType:Consts.SLIMMING_FOODS)),
                        );
                      },
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children:[
                            Image.asset(
                              'assets/img/icons/icn_slimming.png',
                              width: 50,
                              height: 50,
                            ),
                            SizedBox(width: 20),
                            const Text(
                              'Emagrecimento',
                              style: TextStyle(fontSize: 20),
                            )
                          ]
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  SizedBox(
                    height: 60.0,
                    width: 350.0,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFFF0F0F0), // Define a cor de fundo
                        onPrimary: Color(0xFF504848), // Define a cor do texto
                      ),
                      onPressed: () {
                        // Ação do botão Alimentos
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const FoodList(filteringType:Consts.HYPERTROPHY_FOODS)),
                        );
                      },
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children:[
                            Image.asset(
                              'assets/img/icons/icn_muscle.png',
                              width: 50,
                              height: 50,
                            ),
                            const SizedBox(width: 20),
                            const Text(
                              'Hipertrofia Muscular',
                              style: TextStyle(fontSize: 20),
                            )
                          ]
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}