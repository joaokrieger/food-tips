import 'package:flutter/material.dart';
import 'package:food_tips/src/models/userInfo.dart';
import 'package:food_tips/src/views/home.dart';
import 'dart:convert';
import '../services/apiService.dart';

void main() {
  runApp(BiometricInfoScreen());
}

class BiometricInfoScreen extends StatefulWidget {
  BiometricInfoScreen();

  @override
  _BiometricInfoScreenState createState() => _BiometricInfoScreenState();
}

class _BiometricInfoScreenState extends State<BiometricInfoScreen> {

  late UserInfo? userInfo;
  late final int userId;
  late final int userIdInfo;

  final TextEditingController _heigthController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _muscleMassController = TextEditingController();
  final TextEditingController _fatPercentageController = TextEditingController();
  final TextEditingController _imcController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {

    final response = await ApiService().getRequest(
      'http://10.0.2.2:8000/api/v1/userinfo/',
    );

    if (response.statusCode == 200) {
      String responseBody = utf8.decode(response.bodyBytes);
      dynamic jsonData = jsonDecode(responseBody);

      try {
        UserInfo userInfo = UserInfo(
            id: jsonData["id"],
            heigth: jsonData["heigth"],
            weight: jsonData["weight"],
            muscleMass: jsonData["muscle_mass"],
            fatPercentage: jsonData["fat_percentage"],
            imc: jsonData["imc"],
            userId: jsonData["user"]
        );

        userIdInfo = userInfo.id;
        _heigthController.text = userInfo.heigth.toString();
        _weightController.text = userInfo.weight.toString();
        _muscleMassController.text = userInfo.muscleMass.toString();
        _fatPercentageController.text = userInfo.fatPercentage.toString();
        _imcController.text = userInfo.imc.toString();
        userId = userInfo.userId;
        
      }
      catch (e) {
        throw Exception("Erro ao carregar Usuário");
      }
    }
    else {
      throw Exception("Erro na requisição: ${response.statusCode}");
    }
  }

  Future<void> _userInfoRegister () async {

    if (userIdInfo > 0) {

      final url = 'http://10.0.2.2:8000/api/v1/userinfo/${userIdInfo}/';

      final body = json.encode({
        'userIdInfo': userIdInfo,
        'heigth': _heigthController.text,
        'weight': _weightController.text,
        'muscle_mass': _muscleMassController.text,
        'fat_percentage': _fatPercentageController.text,
        'imc': _imcController.text,
        'user': userId
      });

      final response = await ApiService().putRequest(url, body);

      if (response.statusCode == 200) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
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
  }

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
              MaterialPageRoute(builder: (context) => Home()),
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
                    SizedBox(height: 100.0),
                    SizedBox(
                      height: 60,
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _weightController,
                              decoration: InputDecoration(
                                labelText: 'Altura',
                                labelStyle: TextStyle(
                                  color: Colors.black45, // Defina a cor desejada aqui
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.0),
                    SizedBox(
                      height: 60,
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _heigthController,
                              decoration: InputDecoration(
                                labelText: 'Peso',
                                labelStyle: TextStyle(
                                  color: Colors.black45, // Defina a cor desejada aqui
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.0),
                    SizedBox(
                      height: 60,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _muscleMassController,
                              decoration: InputDecoration(
                                labelText: 'Massa Muscular',
                                labelStyle: TextStyle(
                                  color: Colors.black45, // Defina a cor desejada aqui
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.0),
                    SizedBox(
                      height: 60,
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _fatPercentageController,
                              decoration: InputDecoration(
                                labelText: 'Percentual de Gordura',
                                labelStyle: TextStyle(
                                  color: Colors.black45, // Defina a cor desejada aqui
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 32.0),
                    SizedBox(
                      height: 50.0,
                      width: 300.0,
                      child: ElevatedButton(
                        onPressed: _userInfoRegister,
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