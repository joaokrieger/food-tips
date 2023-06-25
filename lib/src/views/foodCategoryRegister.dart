import 'package:flutter/material.dart';
import 'package:food_tips/src/views/foodCategory.dart';
import 'package:food_tips/src/views/foodCategoryList.dart';
import 'package:food_tips/src/views/foodList.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../services/apiService.dart';

void main() {
  runApp(FoodCategoryRegisterScreen());
}

class FoodCategoryRegisterScreen extends StatefulWidget {
  @override
  _FoodCategoryRegisterScreenState createState() => _FoodCategoryRegisterScreenState();
}

class _FoodCategoryRegisterScreenState extends State<FoodCategoryRegisterScreen> {

  final TextEditingController _descriptionController = TextEditingController();

  Future<void> _foodCategoryRegister () async{

    final url = 'http://10.0.2.2:8000/api/v1/foodtype/';

    final body = json.encode({
      'description': _descriptionController.text,
    });

    final response = await ApiService().postRequest(url, body);

    if(response.statusCode == 201){
      //Limpando conteúdo dos campos
      _descriptionController.clear();
    }
    else if (response.statusCode == 401) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Não foi possível realizar cadastro de registro!'),
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