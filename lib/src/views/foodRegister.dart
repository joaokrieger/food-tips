import 'package:flutter/material.dart';
import 'package:food_tips/src/models/food.dart';
import 'package:food_tips/src/models/foodCategory.dart';
import 'package:food_tips/src/views/foodList.dart';
import 'dart:convert';
import '../consts.dart';
import '../services/apiService.dart';

void main() {
  runApp(FoodRegisterScreen(food: null,));
}

class FoodRegisterScreen extends StatefulWidget {
  final Food? food;

  FoodRegisterScreen({this.food});

  @override
  _FoodRegisterScreenState createState() => _FoodRegisterScreenState(food: food);
}

class _FoodRegisterScreenState extends State<FoodRegisterScreen> {
  List<FoodCategory> categoriesList = [];
  FoodCategory? selectedCategory; // Categoria selecionada

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    final response = await ApiService().getRequest(
        'http://10.0.2.2:8000/api/v1/foodtype/');

    if (response.statusCode == 200) {
      String responseBody = utf8.decode(response.bodyBytes);
      dynamic jsonData = jsonDecode(responseBody);
      final results = jsonData['results'] as List<dynamic>;
      List<FoodCategory> categories = results
          .map((result) => FoodCategory(
        id: result['id'],
        description: result['description'],
      ))
          .toList();
      categoriesList = categories;
    } else {
      // Handle the error
      print('Error: Failed to fetch data');
    }
    setState(() {});

  }

  late Food? food;
  late final int idFood;
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _caloriesController = TextEditingController();
  final TextEditingController _carbohydrateController = TextEditingController();
  final TextEditingController _proteinsController = TextEditingController();
  final TextEditingController _cholesterolController = TextEditingController();
  final TextEditingController _saturedFatController = TextEditingController();
  final TextEditingController _servingSizeController = TextEditingController();
  final TextEditingController _sodiumController = TextEditingController();
  final TextEditingController _totalFatController = TextEditingController();

  _FoodRegisterScreenState({this.food}){
    idFood = food?.id ?? 0;
    _descriptionController.text = food?.description ?? '';
    _caloriesController.text = food?.calories ?? '';
    _carbohydrateController.text = food?.carbohydrate ?? '';
    _proteinsController.text = food?.proteins ?? '';
    _cholesterolController.text = food?.cholesterol ?? '';
    _saturedFatController.text = food?.saturatedFat ?? '';
    _servingSizeController.text = food?.servingSize ?? '';
    _sodiumController.text = food?.sodium ?? '';
    _totalFatController.text = food?.totalFat ?? '';
  }

  Future<void> _foodRegister() async {
    final body = json.encode({
      'description': _descriptionController.text,
      'calories': _caloriesController.text.isNotEmpty
          ? double.parse(_caloriesController.text)
          : null,
      'carbohydrate': _carbohydrateController.text.isNotEmpty
          ? double.parse(_carbohydrateController.text)
          : null,
      'proteins': _proteinsController.text.isNotEmpty
          ? double.parse(_proteinsController.text)
          : null,
      'cholesterol': _cholesterolController.text.isNotEmpty
          ? double.parse(_cholesterolController.text)
          : null,
      'saturated_fat': _saturedFatController.text.isNotEmpty
          ? double.parse(_saturedFatController.text)
          : null,
      'servingSize': _servingSizeController.text.isNotEmpty
          ? double.parse(_servingSizeController.text)
          : null,
      'sodium':
      _sodiumController.text.isNotEmpty ? double.parse(_sodiumController.text) : null,
      'total_fat': _totalFatController.text.isNotEmpty
          ? double.parse(_totalFatController.text)
          : null,
      'food_type': selectedCategory?.id,
    });

    // Rest of your code...


    if (idFood > 0) {

      final url = 'http://10.0.2.2:8000/api/v1/food/${idFood}/';

      final response = await ApiService().putRequest(url, body);

      if (response.statusCode == 200) {
        _descriptionController.clear();
        _caloriesController.clear();
        _proteinsController.clear();
        _cholesterolController.clear();
        _saturedFatController.clear();
        _servingSizeController.clear();
        _sodiumController.clear();
        _totalFatController.clear();
      }
      else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Não foi possível realizar a alteração do registro!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    }
    else {

      final url = 'http://10.0.2.2:8000/api/v1/food/';

      final response = await ApiService().postRequest(url, body);

      if (response.statusCode == 201) {
        _descriptionController.clear();
        _caloriesController.clear();
        _proteinsController.clear();
        _cholesterolController.clear();
        _saturedFatController.clear();
        _servingSizeController.clear();
        _sodiumController.clear();
        _totalFatController.clear();
      }
      else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Não foi possível realizar o cadastro do registro!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }
  Future<void> _foodRemove () async {
    final url = 'http://10.0.2.2:8000/api/v1/food/${idFood}/';

    final response = await ApiService().deleteRequest(url);

    if (response.statusCode == 204) {
      _descriptionController.clear();
    }
    else{
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Não foi possível realizar a exclusão do registro!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
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
              MaterialPageRoute(builder: (context) =>  FoodList(filteringType:Consts.STANDARD_FOODS)),
            );
          },
        ),
      ),
      backgroundColor: Color(0xFF024424),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20.0),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextField(
                      controller: _descriptionController,
                      decoration: const InputDecoration(
                        labelText: 'Nome',
                        labelStyle: TextStyle(
                          color: Colors.black45, // Defina a cor desejada aqui
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    SizedBox(height: 16.0),


                DropdownButtonFormField<FoodCategory>(
                  value: selectedCategory,
                  items: categoriesList.map((category) {
                    return DropdownMenuItem<FoodCategory>(
                      value: category,
                      child: Text(category.description),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedCategory = value;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Categoria',
                    labelStyle: TextStyle(
                      color: Colors.black45, // Defina a cor desejada aqui
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),

                    SizedBox(height: 16.0),
                    TextField(
                      controller: _servingSizeController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Tamanho da porção',
                        labelStyle: TextStyle(
                          color: Colors.black45, // Defina a cor desejada aqui
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        suffixText: 'g', // Texto exibido à direita do TextField
                        suffixStyle: TextStyle(
                          color: Colors.black45, // Defina a cor desejada aqui
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextField(
                      controller: _caloriesController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Calorias',
                        labelStyle: TextStyle(
                          color: Colors.black45, // Defina a cor desejada aqui
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        suffixText: 'kcal', // Texto exibido à direita do TextField
                        suffixStyle: TextStyle(
                          color: Colors.black45, // Defina a cor desejada aqui
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextField(
                      controller: _totalFatController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Gordura Total',
                        labelStyle: TextStyle(
                          color: Colors.black45, // Defina a cor desejada aqui
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        suffixText: 'mg', // Texto exibido à direita do TextField
                        suffixStyle: TextStyle(
                          color: Colors.black45, // Defina a cor desejada aqui
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    TextField(
                      controller: _saturedFatController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Gordura Saturada',
                        labelStyle: TextStyle(
                          color: Colors.black45, // Defina a cor desejada aqui
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        suffixText: 'mg', // Texto exibido à direita do TextField
                        suffixStyle: TextStyle(
                          color: Colors.black45, // Defina a cor desejada aqui
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    TextField(
                      controller: _cholesterolController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Colesterol',
                        labelStyle: TextStyle(
                          color: Colors.black45, // Defina a cor desejada aqui
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        suffixText: 'mg', // Texto exibido à direita do TextField
                        suffixStyle: TextStyle(
                          color: Colors.black45, // Defina a cor desejada aqui
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    TextField(
                      controller: _sodiumController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Sódio',
                        labelStyle: TextStyle(
                          color: Colors.black45, // Defina a cor desejada aqui
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        suffixText: 'mg', // Texto exibido à direita do TextField
                        suffixStyle: TextStyle(
                          color: Colors.black45, // Defina a cor desejada aqui
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    TextField(
                      controller: _carbohydrateController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Carboidratos',
                        labelStyle: TextStyle(
                          color: Colors.black45, // Defina a cor desejada aqui
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        suffixText: 'mg', // Texto exibido à direita do TextField
                        suffixStyle: TextStyle(
                          color: Colors.black45, // Defina a cor desejada aqui
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    TextField(
                      controller: _proteinsController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Proteínas',
                        labelStyle: TextStyle(
                          color: Colors.black45, // Defina a cor desejada aqui
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        suffixText: 'mg', // Texto exibido à direita do TextField
                        suffixStyle: TextStyle(
                          color: Colors.black45, // Defina a cor desejada aqui
                        ),
                      ),
                    ),
                    SizedBox(height: 32.0),
                    SizedBox(
                      height: 50.0,
                      width: 300.0,
                      child: ElevatedButton(
                        onPressed: _foodRegister,
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF008445)), // Altere para a cor desejada
                        ),
                        child: const Text(
                          'Salvar',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        SizedBox(height: 16.0),
                        SizedBox(
                          height: 50.0,
                          width: 300.0,
                          child: Visibility(
                            visible: idFood > 0,
                            child: ElevatedButton(
                              onPressed: _foodRemove,
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(Colors.red), // Altere para a cor desejada
                              ),
                              child: const Text(
                                'Excluir',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
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
      ),
    );
  }
}