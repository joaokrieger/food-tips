import 'package:flutter/material.dart';
import 'package:food_tips/src/models/foodCategory.dart';
import 'package:food_tips/src/views/foodCategoryRegister.dart';
import 'package:food_tips/src/views/foodRegister.dart';
import 'package:food_tips/src/views/home.dart';
import '../services/apiService.dart';
import 'dart:convert';

void main() {
  runApp(FoodCategoryList());
}

class FoodCategoryList extends StatefulWidget {
  @override
  _FoodCategoryListState createState() => _FoodCategoryListState();
}

class _FoodCategoryListState extends State<FoodCategoryList> {
  late List<FoodCategory> foodCategoryList = []; // Adicionado o operador 'late' para inicialização tardia
  int currentPage = 1;
  late TextEditingController searchController = TextEditingController();
  late String searchQuery = '';

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {

    final response = await ApiService().getRequest('http://10.0.2.2:8000/api/v1/foodtype/?page=$currentPage&search=$searchQuery');

    if (response.statusCode == 200) {
      String responseBody = utf8.decode(response.bodyBytes);
      dynamic jsonData = jsonDecode(responseBody);
      final results = jsonData['results'] as List<dynamic>;
      foodCategoryList = results.map((result) => FoodCategory(
        id: result['id'],
        description: result['description'],
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
            child: foodCategoryList != null
                ? ListView.builder(
              itemCount: foodCategoryList.length,
              itemBuilder: (context, index) {
                final foodCategory = foodCategoryList[index];
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                            '${foodCategory.description}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
            MaterialPageRoute(builder: (context) => FoodCategoryRegisterScreen()),
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
