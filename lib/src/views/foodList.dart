import 'package:flutter/material.dart';
import 'package:food_tips/src/views/home.dart';
import '../models/food.dart';
import '../services/apiService.dart';
import 'foodCategory.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(FoodList());
}

class FoodList extends StatefulWidget {
  @override
  _FoodListState createState() => _FoodListState();
}

class _FoodListState extends State<FoodList> {
  late List<Food> foodList = []; // Adicionado o operador 'late' para inicialização tardia
  int currentPage = 1;
  late TextEditingController searchController = TextEditingController();
  late String searchQuery = '';

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await ApiService().getRequest('http://10.0.2.2:8000/api/v1/food/?page=$currentPage&search=$searchQuery');

    if (response.statusCode == 200) {
      String responseBody = utf8.decode(response.bodyBytes);
      dynamic jsonData = jsonDecode(responseBody);
      final results = jsonData['results'] as List<dynamic>;
      foodList = results.map((result) => Food(
        id: result['id'],
        description: result['description'],
        calories: result['calories'],
        servingSize: result['serving_size'],
        totalFat: result['total_fat'],
        saturatedFat: result['saturated_fat'],
        cholesterol: result['cholesterol'],
        sodium: result['sodium'],
        carbohydrate: result['carbohydrate'],
        proteins: result['proteins'],
        snackType: result['snack_type'],
        foodType: result['food_type'],
      )).toList();
    } else {
      // Handle the error
      print('Error: Failed to fetch data');
    }

    setState(() {});
  }

  Future<void> nextPage() async {
    currentPage++;
    await fetchData();
  }

  void applyFilter() {
    searchQuery = searchController.text;
    currentPage = 1; // Update the page number to 1
    fetchData();
  }


  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Image.asset('assets/img/icons/icn_back.png'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FoodCategory()),
            );
          },
        ),
      ),
      backgroundColor: Color(0xFF024424),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Filtrar',
                      hintStyle: TextStyle(color: Colors.white70),
                      prefixIcon: Icon(Icons.search, color: Colors.white),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      searchQuery = searchController.text;
                      currentPage = 1;
                    });
                    fetchData();
                  },
                  child: Row(
                    children: [
                      Icon(Icons.search, color: Colors.white),
                      Text(
                        'Filtrar',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: foodList != null
                ? ListView.builder(
              itemCount: foodList.length,
              itemBuilder: (context, index) {
                final food = foodList[index];
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                            '${food.description} - ${food.servingSize}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
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
                );
              },
            )
                : Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Home()),
          );
        },
        child: Icon(
          Icons.add,
          color: Color(0xFFF0F0F0),
        ),
        backgroundColor: Color(0xFF770505),
      ),
    );
  }

}
