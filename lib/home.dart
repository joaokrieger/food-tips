import 'package:flutter/material.dart';
import 'package:food_tips/foodCategory.dart';
import 'package:food_tips/register.dart';

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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 80.0),
              Container(
                width: 350,
                height: 500,
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
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF504848),
                                ),
                            ),
                          ],
                        ),
                        Row(
                            children:[
                              SizedBox(
                                  width: 16.0,
                                  height: 10.0,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 16.0,
                                    height: 16.0,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Cristiano Ronaldo',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Color(0xFF504848),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 16.0,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Homem Adulto',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontStyle: FontStyle.italic,
                                          color: Color(0xFF504848),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ]
                        ),
                        SizedBox(height: 10.0),
                        Row(
                          children: [
                            SizedBox(width: 16.0),
                            Text(
                              "Índice de IMC",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF504848),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: SizedBox(
                                  height: 20,
                                  child: LinearProgressIndicator(
                                    value: 0.5, // Valor do progresso (entre 0.0 e 1.0)
                                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF0C9522)), // Cor do progresso
                                    backgroundColor: Color(0xFFD9D9D9), // Cor de fundo
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.0),
                        Row(
                          children: [
                            SizedBox(width: 16.0),
                            Text(
                              'Status:',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF504848),
                              ),
                            ),
                            SizedBox(width: 10.0),
                            Text(
                              'Saudável',
                              style: TextStyle(
                                fontSize: 20,
                                color: Color(0xFF504848),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.0),
                        Row(
                          children: [
                            SizedBox(width: 16.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    color: Color(0xFF024424),
                                    height: 80,
                                    width: 80,// Defina a altura desejada para a caixa
                                  ),
                                  // Outros widgets dentro da coluna
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    color: Color(0xFF024424),
                                    height: 80,
                                    width: 80,// Defina a altura desejada para a caixa
                                  ),
                                  // Outros widgets dentro da coluna
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    color: Color(0xFF024424),
                                    height: 80,
                                    width: 80,// Defina a altura desejada para a caixa
                                  ),
                                  // Outros widgets dentro da coluna
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.0),
                        Row(
                          children: [
                            SizedBox(width: 16.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    color: Color(0xFF024424),
                                    height: 80,
                                    width: 80,// Defina a altura desejada para a caixa
                                  ),
                                  // Outros widgets dentro da coluna
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    color: Color(0xFF024424),
                                    height: 80,
                                    width: 80,// Defina a altura desejada para a caixa
                                  ),
                                  // Outros widgets dentro da coluna
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    color: Color(0xFF024424),
                                    height: 80,
                                    width: 80,// Defina a altura desejada para a caixa
                                  ),
                                  // Outros widgets dentro da coluna
                                ],
                              ),
                            ),
                          ],
                        )
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FoodCategory()),
                    );
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Register()),
                    );
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
              SizedBox(height: 40.0)
            ],
          ),
        ),
      ),
    );
  }
}