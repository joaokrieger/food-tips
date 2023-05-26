import 'package:flutter/material.dart';

void main() {
  runApp(Home());
}

class Home extends StatelessWidget {
  final double height = 70;
  final double weight = 179;
  final int age = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF024424),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20.0),
            Container(
              width: 350,
              height: 400,
              decoration: BoxDecoration(
                color: Color(0xFFF0F0F0),
                borderRadius: BorderRadius.circular(10), // Define o raio das bordas
              ),
              child:(
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[
                      SizedBox(height: 10.0),
                      Row(
                        children: [
                          SizedBox(width: 16.0),
                          Text(
                              'Dados Biométricos',
                              style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ]
                )
              ),
            ),
            SizedBox(height: 30),
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
                },
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children:[
                      SizedBox(width: 5),
                      Image.asset(
                        'assets/icons/icn_food.png',
                        width: 40,
                        height: 40,
                      ),
                      SizedBox(width: 50),
                      Text(
                        'Alimentos',
                        style: TextStyle(fontSize: 20)
                      ),
                    ],
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
                      'assets/icons/icn_recommendation.png',
                      width: 50,
                      height: 50,
                    ),
                    SizedBox(width: 20),
                    Text(
                      'Recomendações',
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
                      SizedBox(width: 10),
                      Image.asset(
                        'assets/icons/icn_user.png',
                        width: 35,
                        height: 35,
                      ),
                      SizedBox(width: 20),
                      Text(
                        'Dados de Usuário',
                        style: TextStyle(fontSize: 20),
                      )
                    ]
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}