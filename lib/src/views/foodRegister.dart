import 'package:flutter/material.dart';
import 'package:food_tips/src/views/foodList.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../services/apiService.dart';

void main() {
  runApp(FoodRegisterScreen());
}

class FoodRegisterScreen extends StatefulWidget {
  @override
  _FoodRegisterScreenState createState() => _FoodRegisterScreenState();
}

class _FoodRegisterScreenState extends State<FoodRegisterScreen> {

  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _carbohydratesController = TextEditingController();
  final TextEditingController _lipidsController = TextEditingController();
  final TextEditingController _caloriesController = TextEditingController();
  final TextEditingController _proteinsController = TextEditingController();
  final TextEditingController _foodCategoryController = TextEditingController();

  Future<void> _foodRegister () async{

    final url = 'http://10.0.2.2:8000/api/v1/food/';

    final body = json.encode({
      'username': _descriptionController.text,
      'first_name': _carbohydratesController.text,
      'last_name': _lipidsController.text,
      'email': _caloriesController.text,
      'birth_date': _proteinsController.text,
      'password': _foodCategoryController.text
    });


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
              MaterialPageRoute(builder: (context) => FoodList()),
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
                      decoration: InputDecoration(
                        labelText: 'Descrição',
                        labelStyle: TextStyle(
                          color: Colors.black45, // Defina a cor desejada aqui
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    TextField(
                      controller: _carbohydratesController,
                      decoration: InputDecoration(
                        labelText: 'Carboidratos',
                        labelStyle: TextStyle(
                          color: Colors.black45, // Defina a cor desejada aqui
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    TextField(
                      controller: _lipidsController,
                      decoration: InputDecoration(
                        labelText: 'Lipídios',
                        labelStyle: TextStyle(
                          color: Colors.black45, // Defina a cor desejada aqui
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    TextField(
                      controller: _caloriesController,
                      decoration: InputDecoration(
                        labelText: 'Calorias',
                        labelStyle: TextStyle(
                          color: Colors.black45, // Defina a cor desejada aqui
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    TextField(
                      controller: _proteinsController,
                      decoration: InputDecoration(
                        labelText: 'Proteínas',
                        labelStyle: TextStyle(
                          color: Colors.black45, // Defina a cor desejada aqui
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    SizedBox(
                        child: Row(
                          children: [
                            Expanded(
                              child: DropdownButtonFormField<String>(
                                items: [
                                  DropdownMenuItem<String>(
                                    value: 'CA',
                                    child: Text(
                                      'Carboidratos',
                                      style: TextStyle(
                                        color: Colors.black45,
                                      ),
                                    ),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: 'LA',
                                    child: Text(
                                      'Laticínios',
                                      style: TextStyle(
                                        color: Colors.black45,
                                      ),
                                    ),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: 'PO',
                                    child: Text(
                                      'Proteínas',
                                      style: TextStyle(
                                        color: Colors.black45,
                                      ),
                                    ),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: 'VE',
                                    child: Text(
                                      'Verdura',
                                      style: TextStyle(
                                        color: Colors.black45,
                                      ),
                                    ),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: 'FR',
                                    child: Text(
                                      'Frutas',
                                      style: TextStyle(
                                        color: Colors.black45,
                                      ),
                                    ),
                                  ),
                                ],
                                decoration: InputDecoration(
                                  labelText: 'Categoria do Alimento',
                                  labelStyle: TextStyle(
                                    color: Colors.black45,
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                                value: _foodCategoryController.text,
                                onChanged: (newValue) {
                                  setState(() {
                                    _foodCategoryController.text = newValue!;
                                  });
                                },
                              ),
                            ),
                          ],
                        )
                    ),
                    SizedBox(height: 32.0),
                    SizedBox(
                      height: 50.0,
                      width: 300.0,
                      child: ElevatedButton(
                        onPressed: () {
                          // Implementar a lógica de login aqui
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => FoodList()),
                          );
                        },
                        child: Text(
                          'Salvar',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF008445)), // Altere para a cor desejada
                        ),
                      ),
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