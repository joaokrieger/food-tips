import 'package:flutter/material.dart';
import 'package:food_tips/src/models/foodCategory.dart';
import 'package:food_tips/src/views/foodCategoryList.dart';
import 'dart:convert';
import '../services/apiService.dart';

void main() {
  runApp(FoodCategoryRegisterScreen(foodCategory: null,));
}

class FoodCategoryRegisterScreen extends StatefulWidget {
  final FoodCategory? foodCategory;

  FoodCategoryRegisterScreen({this.foodCategory});

  @override
  _FoodCategoryRegisterScreenState createState() => _FoodCategoryRegisterScreenState(foodCategory: foodCategory);
}

class _FoodCategoryRegisterScreenState extends State<FoodCategoryRegisterScreen> {

  late FoodCategory? foodCategory;
  late final int idFoodCategory;
  final TextEditingController _descriptionController = TextEditingController();

  _FoodCategoryRegisterScreenState({this.foodCategory}){
    idFoodCategory = foodCategory?.id ?? 0;
    _descriptionController.text = foodCategory?.description ?? '';
  }

  Future<void> _foodCategoryRegister () async {

    if (idFoodCategory > 0) {

      final url = 'http://10.0.2.2:8000/api/v1/foodtype/${idFoodCategory}/';

      final body = json.encode({
        'description': _descriptionController.text,
      });

      final response = await ApiService().putRequest(url, body);

      if (response.statusCode == 200) {
        _descriptionController.clear();
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

      final url = 'http://10.0.2.2:8000/api/v1/foodtype/';

      final body = json.encode({
        'description': _descriptionController.text,
      });

      final response = await ApiService().postRequest(url, body);

      if (response.statusCode == 201) {
        _descriptionController.clear();
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
  Future<void> _foodCategoryRemove () async {
    final url = 'http://10.0.2.2:8000/api/v1/foodtype/${idFoodCategory}/';

    final response = await ApiService().deleteRequest(url);

    if (response.statusCode == 204) {
      _descriptionController.clear();
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
              MaterialPageRoute(builder: (context) =>  FoodCategoryList()),
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
                    SizedBox(height: 32.0),
                    SizedBox(
                      height: 50.0,
                      width: 300.0,
                      child: ElevatedButton(
                        onPressed: _foodCategoryRegister,
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
                    Column(
                      children: [
                        SizedBox(height: 16.0),
                        SizedBox(
                          height: 50.0,
                          width: 300.0,
                          child: Visibility(
                            visible: idFoodCategory > 0,
                            child: ElevatedButton(
                              onPressed: _foodCategoryRemove,
                              child: Text(
                                'Excluir',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(Colors.red), // Altere para a cor desejada
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