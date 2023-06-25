import 'dart:convert';

import 'package:flutter/material.dart';
import '../models/food.dart';
import '../services/apiService.dart';
import 'foodCategory.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:food_tips/src/views/foodRegister.dart';

import 'foodDetail.dart';

void main() {
  runApp(FoodList());
}

class FoodList extends StatefulWidget {
  @override
  _FoodListState createState() => _FoodListState();
}

class _FoodListState extends State<FoodList> {
  List<Food> foodList = [];
  int currentPage = 1;
  TextEditingController searchController = TextEditingController();
  String searchQuery = '';
  String pageSize = '30';

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await ApiService().getRequest(
        'http://10.0.2.2:8000/api/v1/food/?page=$currentPage&search=$searchQuery&page_size=$pageSize');

    if (response.statusCode == 200) {
      String responseBody = utf8.decode(response.bodyBytes);
      dynamic jsonData = jsonDecode(responseBody);
      final results = jsonData['results'] as List<dynamic>;
      List<Food> newFoodList = results
          .map((result) => Food(
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
      ))
          .toList();
      foodList.addAll(newFoodList);
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
    currentPage = 1;
    foodList.clear(); // Clear existing list when applying filter
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
                    decoration: const InputDecoration(
                      hintText: 'Filtrar',
                      hintStyle: TextStyle(color: Colors.white70),
                      prefixIcon: Icon(Icons.search, color: Colors.white),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: applyFilter,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red, // Change button color to red
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.search, color: Colors.white),
                      Text(
                        'Filtrar',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: foodList.isNotEmpty
                ? ListView.builder(
              itemCount: foodList.length + 1,
              itemBuilder: (context, index) {
                if (index == foodList.length) {
                  return ElevatedButton(
                    onPressed: nextPage,
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red, // Change button color to red
                    ),
                    child: const Text(
                      'Carregar Mais',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }

                final food = foodList[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            FoodDetailScreen(food: food),
                      ),
                    );
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          ListTile(
                            leading: Icon(Icons.description),
                            title: Text(
                              '${food.description}',
                              style: const TextStyle(
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
                            title: Text(
                                'Tamanho da Porção: ${food.servingSize}'),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            )
                : const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FoodRegisterScreen()),
          );
        },
        backgroundColor: Color(0xFF770505),
        child: const Icon(
          Icons.add,
          color: Color(0xFFF0F0F0),
        ),
      ),
    );
  }
}
