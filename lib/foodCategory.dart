import 'package:flutter/material.dart';
import 'package:food_tips/foodList.dart';
import 'package:food_tips/home.dart';

void main() {
  runApp(FoodCategory());
}

class FoodCategory extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Image.asset('assets/icons/icn_back.png'),
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => FoodList()),
                        );
                      },
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children:[
                            Image.asset(
                              'assets/icons/icn_star.png',
                              width: 50,
                              height: 50,
                            ),
                            SizedBox(width: 20),
                            Text(
                              'Favoritos',
                              style: TextStyle(fontSize: 20),
                            )
                          ]
                      ),
                    ),
                  ),
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
                        // Ação do botão Recomendações
                      },
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children:[
                            Image.asset(
                              'assets/icons/icn_carbohydrate.png',
                              width: 50,
                              height: 50,
                            ),
                            SizedBox(width: 20),
                            Text(
                              'Carboidratos',
                              style: TextStyle(fontSize: 20),
                            )
                          ]
                      ),
                    ),
                  ),
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
                        // Ação do botão Recomendações
                      },
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children:[
                            Image.asset(
                              'assets/icons/icn_dairy.png',
                              width: 50,
                              height: 50,
                            ),
                            SizedBox(width: 20),
                            Text(
                              'Laticínios',
                              style: TextStyle(fontSize: 20),
                            )
                          ]
                      ),
                    ),
                  ),
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
                        // Ação do botão Recomendações
                      },
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children:[
                            Image.asset(
                              'assets/icons/icn_protein.png',
                              width: 50,
                              height: 50,
                            ),
                            SizedBox(width: 20),
                            Text(
                              'Proteínas',
                              style: TextStyle(fontSize: 20),
                            )
                          ]
                      ),
                    ),
                  ),
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
                        // Ação do botão Recomendações
                      },
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children:[
                            Image.asset(
                              'assets/icons/icn_vegetable.png',
                              width: 50,
                              height: 50,
                            ),
                            SizedBox(width: 20),
                            Text(
                              'Verduras',
                              style: TextStyle(fontSize: 20),
                            )
                          ]
                      ),
                    ),
                  ),
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
                        // Ação do botão Recomendações
                      },
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children:[
                            Image.asset(
                              'assets/icons/icn_fruit.png',
                              width: 50,
                              height: 50,
                            ),
                            SizedBox(width: 20),
                            Text(
                              'Frutas',
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