import 'package:flutter/material.dart';
import 'package:food_tips/src/views/foodCategory.dart';
import 'package:food_tips/src/views/foodRegister.dart';
import 'package:food_tips/src/views/home.dart';

void main() {
  runApp(FoodList());
}

class FoodList extends StatelessWidget {

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
              MaterialPageRoute(builder: (context) => FoodCategory()),
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
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Color(0xFF008445), // Cor de fundo (024424)
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Batata-doce 100g',
                            style: TextStyle(
                              color: Color(0xFFF0F0F0), // Cor do texto (F0F0F0)
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8.0), // Espaçamento entre as linhas
                          Container(
                            color: Color(0xFFF0F0F0), // Cor de fundo do texto "Caloria 95kcal" (F0F0F0)
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Calorias:',
                                      style: TextStyle(
                                        color: Colors.black, // Cor do texto (preto)
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0,
                                      ),
                                    ),
                                    Text(
                                      ' 95kcal',
                                      style: TextStyle(
                                        color: Colors.black, // Cor do texto (preto)
                                        fontSize: 18.0,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Lipídios:',
                                      style: TextStyle(
                                        color: Colors.black, // Cor do texto (preto)
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0,
                                      ),
                                    ),
                                    Text(
                                      ' 1g',
                                      style: TextStyle(
                                        color: Colors.black, // Cor do texto (preto)
                                        fontSize: 18.0,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Carboidratos:',
                                      style: TextStyle(
                                        color: Colors.black, // Cor do texto (preto)
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0,
                                      ),
                                    ),
                                    Text(
                                      ' 28g',
                                      style: TextStyle(
                                        color: Colors.black, // Cor do texto (preto)
                                        fontSize: 18.0,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Proteínas:',
                                      style: TextStyle(
                                        color: Colors.black, // Cor do texto (preto)
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0,
                                      ),
                                    ),
                                    Text(
                                      ' 1.5g',
                                      style: TextStyle(
                                        color: Colors.black, // Cor do texto (preto)
                                        fontSize: 18.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                    ),
                  ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FoodRegister()),
          );
        },
        child: Icon(
          Icons.add,
          color: Color(0xFFF0F0F0), // Cor do ícone (F0F0F0)
        ),
        backgroundColor: Color(0xFF770505), // Cor de fundo (770505)
      ),
    );
  }
}