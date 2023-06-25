import 'package:flutter/material.dart';

import '../models/food.dart';

class FoodDetailScreen extends StatelessWidget {
  final Food food;

  FoodDetailScreen({required this.food});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Image.asset('assets/img/icons/icn_back.png'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Color(0xFF024424),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.description),
                      title: Text(
                        '${food.description}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.assessment),
                      title: Text('Calorias: ${food.calories}'),
                    ),
                    ListTile(
                      leading: Icon(Icons.local_dining),
                      title: Text('Tamanho da Porção: ${food.servingSize}'),
                    ),
                    ListTile(
                      leading: Icon(Icons.restaurant),
                      title: Text('Gordura Total: ${food.totalFat}'),
                    ),
                    ListTile(
                      leading: Icon(Icons.local_drink),
                      title: Text('Gordura Saturada: ${food.saturatedFat}'),
                    ),
                    ListTile(
                      leading: Icon(Icons.grade),
                      title: Text('Colesterol: ${food.cholesterol}'),
                    ),
                    ListTile(
                      leading: Icon(Icons.local_cafe),
                      title: Text('Sódio: ${food.sodium}'),
                    ),
                    ListTile(
                      leading: Icon(Icons.bakery_dining),
                      title: Text('Carboidrato: ${food.carbohydrate}'),
                    ),
                    ListTile(
                      leading: Icon(Icons.fitness_center),
                      title: Text('Proteínas: ${food.proteins}'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
