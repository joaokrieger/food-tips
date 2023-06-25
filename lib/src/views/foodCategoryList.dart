import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:food_tips/src/views/foodCategoryRegister.dart';
import 'package:food_tips/src/views/home.dart';
import 'package:food_tips/src/models/foodCategory.dart';
import '../services/apiService.dart';

void main() {
  runApp(FoodCategoryList());
}

class FoodCategoryList extends StatefulWidget {
  @override
  _FoodCategoryListState createState() => _FoodCategoryListState();
}

class _FoodCategoryListState extends State<FoodCategoryList> {
  List<FoodCategory> foodCategoryList = [];
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
        'http://10.0.2.2:8000/api/v1/foodtype/?page=$currentPage&search=$searchQuery&page_size=$pageSize');

    if (response.statusCode == 200) {

      String responseBody = utf8.decode(response.bodyBytes);
      dynamic jsonData = jsonDecode(responseBody);
      final results = jsonData['results'] as List<dynamic>;
      List<FoodCategory> newFoodCategoryList = results
          .map((result) => FoodCategory(
        id: result['id'],
        description: result['description']
      ))
          .toList();
      foodCategoryList.addAll(newFoodCategoryList);
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
    foodCategoryList.clear(); // Clear existing list when applying filter
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
              MaterialPageRoute(builder: (context) => Home()),
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
            child: foodCategoryList.isNotEmpty
                ? ListView.builder(
              itemCount: foodCategoryList.length + 1,
              itemBuilder: (context, index) {
                if (index == foodCategoryList.length) {
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

                final foodCategory = foodCategoryList[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            FoodCategoryRegisterScreen(foodCategory: foodCategory),
                      ),
                    );
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          ListTile(
                            leading: Icon(Icons.edit),
                            title: Text(
                              '${foodCategory.description}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
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
            MaterialPageRoute(builder: (context) => FoodCategoryRegisterScreen()),
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
