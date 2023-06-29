import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_tips/main.dart';
import 'package:food_tips/src/models/user.dart';
import 'package:food_tips/src/models/userInfo.dart';
import 'package:food_tips/src/services/apiService.dart';
import 'package:food_tips/src/utils/utils.dart';
import 'package:food_tips/src/views/biometricInfo.dart';
import 'package:food_tips/src/views/foodCategoryList.dart';
import 'package:food_tips/src/views/foodList.dart';
import 'package:food_tips/src/views/recommendationCategory.dart';
import 'package:food_tips/src/views/register.dart';

import '../consts.dart';

void main() {
  runApp(Home());
}
class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  late String _firstName = '';
  late String _lastName = '';
  late String _statusImc = '';
  late String _statusFatPercentage = '';
  late String _statusMuscleMass = '';
  late int _age = 0;
  late double? _imcPercent = 0;

  late double? _imc = 0;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {

    final response = await ApiService().getRequest(
      'http://10.0.2.2:8000/api/v1/user/',
    );

    if (response.statusCode == 200) {
      String responseBody = utf8.decode(response.bodyBytes);
      dynamic jsonData = jsonDecode(responseBody);

      try {

        User user = User(
            id: jsonData["id"],
            firstName: jsonData["first_name"],
            lastName: jsonData["last_name"],
            birthDate: DateTime.parse(jsonData["birth_date"])
        );

        final response = await ApiService().getRequest(
          'http://10.0.2.2:8000/api/v1/userinfo/',
        );

        if (response.statusCode == 200) {
          String responseBody = utf8.decode(response.bodyBytes);
          dynamic jsonData = jsonDecode(responseBody);

          UserInfo userInfo = UserInfo(
            id: jsonData["id"],
            imc: jsonData["imc"],
            muscleMass: jsonData["muscle_mass"],
            fatPercentage: jsonData["fat_percentage"]
          );

          //Calculando Idade
          int age = Utils.calculateAge(user.birthDate);
          double idealImc = 0;

          //Verificando IMC
          if (age < 19) { //Menores de 19 anos
            idealImc = 84.9;

            if (userInfo.imc! < 5)
              _statusImc = "Baixo Peso";
            else if (userInfo.imc! > 5 && userInfo.imc! < 84.9)
              _statusImc = "Eutrofia";
            else
              _statusImc = "Sobrepeso";
          }
          else if (age > 19 && age < 60) { //Entre 19 e 60 anos

            idealImc = 25;

            if (userInfo.imc! < 18.5)
              _statusImc = "Baixo Peso";
            else if (userInfo.imc! > 18.5 && userInfo.imc! < 25)
              _statusImc = "Eutrofia";
            else if (userInfo.imc! > 25 && userInfo.imc! < 30)
              _statusImc = "Sobrepeso";
            else
              _statusImc = "Obesidade";
          }
          else if (age > 60) { //Maiores de 60 anos

            idealImc = 27;

            if (userInfo.imc! < 22)
              _statusImc = "Baixo Peso";
            else if (userInfo.imc! > 22 && userInfo.imc! < 27)
              _statusImc = "Eutrofia";
            else
              _statusImc = "Sobrepeso";
          }

          //Verificando Percentual de Gordura
          if(age < 29){
            if(userInfo.fatPercentage! < 11){
              _statusFatPercentage = "Atleta";
            } else if(userInfo.fatPercentage! < 13){
              _statusFatPercentage = "Bom";
            } else if(userInfo.fatPercentage! < 20){
              _statusFatPercentage = "Normal";
            } else if(userInfo.fatPercentage! < 23){
              _statusFatPercentage = "Elevado";
            } else{
              _statusFatPercentage = "Muito Elevado";
            }
          }
          else if(age < 39){
            if(userInfo.fatPercentage! < 12){
              _statusFatPercentage = "Atleta";
            } else if(userInfo.fatPercentage! < 14){
              _statusFatPercentage = "Bom";
            } else if(userInfo.fatPercentage! < 21){
              _statusFatPercentage = "Normal";
            } else if(userInfo.fatPercentage! < 24){
              _statusFatPercentage = "Elevado";
            } else{
              _statusFatPercentage = "Muito Elevado";
            }
          }
          else if(age < 49){
            if(userInfo.fatPercentage! < 14){
              _statusFatPercentage = "Atleta";
            } else if(userInfo.fatPercentage! < 16){
              _statusFatPercentage = "Bom";
            } else if(userInfo.fatPercentage! < 23){
              _statusFatPercentage = "Normal";
            } else if(userInfo.fatPercentage! < 26){
              _statusFatPercentage = "Elevado";
            } else{
              _statusFatPercentage = "Muito Elevado";
            }
          }
          else{
            if(userInfo.fatPercentage! < 15){
              _statusFatPercentage = "Atleta";
            } else if(userInfo.fatPercentage! < 17){
              _statusFatPercentage = "Bom";
            } else if(userInfo.fatPercentage! < 24){
              _statusFatPercentage = "Normal";
            } else if(userInfo.fatPercentage! < 27){
              _statusFatPercentage = "Elevado";
            } else{
              _statusFatPercentage = "Muito Elevado";
            }
          }

          //Verificando Massa Muscular
          if(age < 24){
            if(userInfo.muscleMass! < 54){
              _statusMuscleMass = "Baixa";
            }else if(userInfo.muscleMass! > 62){
              _statusMuscleMass = "Alta";
            } else{
              _statusMuscleMass = "Ideal";
            }
          }else if(age < 34){
            if(userInfo.muscleMass! < 56){
              _statusMuscleMass = "Baixa";
            }else if(userInfo.muscleMass! > 63){
              _statusMuscleMass = "Alta";
            } else{
              _statusMuscleMass = "Ideal";
            }
          }else if(age < 44){
            if(userInfo.muscleMass! < 58){
              _statusMuscleMass = "Baixa";
            }else if(userInfo.muscleMass! > 64){
              _statusMuscleMass = "Alta";
            } else{
              _statusMuscleMass = "Ideal";
            }
          }else if(age < 54){
            if(userInfo.muscleMass! < 55){
              _statusMuscleMass = "Baixa";
            }else if(userInfo.muscleMass! > 61){
              _statusMuscleMass = "Alta";
            } else{
              _statusMuscleMass = "Ideal";
            }
          }
          else if(age < 54){
            if(userInfo.muscleMass! < 55){
              _statusMuscleMass = "Baixa";
            }else if(userInfo.muscleMass! > 61){
              _statusMuscleMass = "Alta";
            } else{
              _statusMuscleMass = "Ideal";
            }
          } else if(age < 64){
            if(userInfo.muscleMass! < 54){
              _statusMuscleMass = "Baixa";
            }else if(userInfo.muscleMass! > 61){
              _statusMuscleMass = "Alta";
            } else{
              _statusMuscleMass = "Ideal";
            }
          }
          else if(age < 74){
            if(userInfo.muscleMass! < 53){
              _statusMuscleMass = "Baixa";
            }else if(userInfo.muscleMass! > 61){
              _statusMuscleMass = "Alta";
            } else{
              _statusMuscleMass = "Ideal";
            }
          }
          else if(age < 84){
            if(userInfo.muscleMass! < 50){
              _statusMuscleMass = "Baixa";
            }else if(userInfo.muscleMass! > 58){
              _statusMuscleMass = "Alta";
            } else{
              _statusMuscleMass = "Ideal";
            }
          }
          else{
            if(userInfo.muscleMass! < 48){
              _statusMuscleMass = "Baixa";
            }else if(userInfo.muscleMass! > 53){
              _statusMuscleMass = "Alta";
            } else{
              _statusMuscleMass = "Ideal";
            }
          }


          setState(() {
            _age = age;
            _firstName = user.firstName;
            _lastName = user.lastName;
            _imc = userInfo.imc;

            if(userInfo.imc! > 0 && idealImc > 0) {
              _imcPercent = (userInfo.imc! /
                  idealImc); //Calculando porcentagem equivalente ao ideal
            }
          });
        }
      }
      catch (e) {
        print("Erro ao carregar Usuário ${e.toString()}");
      }
    }
    else {
      throw Exception("Erro na requisição: ${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF024424),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 80.0),
              GestureDetector(
                child: Container(
                  width: 350,
                  height: 270,
                  decoration: BoxDecoration(
                    color: Color(0xFFF0F0F0),
                    borderRadius: BorderRadius.circular(10), // Define o raio das bordas
                  ),
                  child:(
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                        SizedBox(height: 10.0),
                        Row(
                          children: const [
                            SizedBox(width: 16.0),
                            Text(
                              'Dados Biométricos',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF504848),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children:[
                            SizedBox(
                              width: 16.0,
                              height: 10.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 16.0,
                                  height: 16.0,
                                ),
                                Row(
                                  children: [
                                    Text(
                                     '$_firstName $_lastName ($_age anos)',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Color(0xFF504848),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 16.0,
                                ),
                              ],
                            ),
                          ]
                        ),
                        SizedBox(height: 10.0),
                        Row(
                          children: const [
                            SizedBox(width: 16.0),
                            Text(
                              "Índice de IMC",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF504848),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: SizedBox(
                                  height: 20,
                                  child: LinearProgressIndicator(
                                    value: _imcPercent,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      _imcPercent! > 1
                                          ? Colors.red
                                          : _imcPercent! < 0.5 && _imcPercent! > 0.25
                                          ? Colors.orange
                                          : _imcPercent! < 0.25
                                          ? Colors.red
                                          : Color(0xFF0C9522),
                                    ),
                                    backgroundColor: Color(0xFFD9D9D9),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.0),
                        Row(
                          children: [
                            SizedBox(width: 16.0),
                            Text(
                              'Classificação:',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF504848),
                              ),
                            ),
                            SizedBox(width: 5.0),
                            Text(
                              _statusImc,
                              style: TextStyle(
                                fontSize: 20,
                                color: Color(0xFF504848),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.0),
                        Row(
                          children: [
                            SizedBox(width: 16.0),
                            Text(
                              'Status Muscular:',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF504848),
                              ),
                            ),
                            SizedBox(width: 5.0),
                            Text(
                              _statusMuscleMass,
                              style: TextStyle(
                                fontSize: 20,
                                color: Color(0xFF504848),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.0),
                        Row(
                          children: [
                            SizedBox(width: 16.0),
                            Text(
                              'Class. Gordura:',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF504848),
                              ),
                            ),
                            SizedBox(width: 5.0),
                            Text(
                              _statusFatPercentage,
                              style: TextStyle(
                                fontSize: 20,
                                color: Color(0xFF504848),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.0),
                      ]
                    )
                  ),
                ),
                onTap: () {
                  // Navegação para a próxima tela quando o container for clicado
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BiometricInfoScreen()),
                  );
                },
              ),
              SizedBox(height: 30),
              SizedBox(
                height: 60.0,
                width: 350.0,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFFF0F0F0), // Define a cor de fundo
                    onPrimary: Color(0xFF504848), // Define a cor do texto
                  ),
                  onPressed: () {
                    // Ação do botão Alimentos
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FoodCategoryList()),
                    );
                  },
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children:[
                        SizedBox(width: 5),
                        Image.asset(
                          'assets/img/icons/icn_category.png',
                          width: 40,
                          height: 40,
                        ),
                        SizedBox(width: 20),
                        const Text(
                          'Categoria de Alimentos',
                          style: TextStyle(fontSize: 20)
                        ),
                      ],
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              SizedBox(
                height: 60.0,
                width: 350.0,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFFF0F0F0), // Define a cor de fundo
                    onPrimary: Color(0xFF504848), // Define a cor do texto
                  ),
                  onPressed: () {
                    // Ação do botão Alimentos
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const FoodList(filteringType:Consts.STANDARD_FOODS)),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children:[
                      SizedBox(width: 5),
                      Image.asset(
                        'assets/img/icons/icn_food.png',
                        width: 40,
                        height: 40,
                      ),
                      SizedBox(width: 50),
                      const Text(
                          'Alimentos',
                          style: TextStyle(fontSize: 20)
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              SizedBox(
                height: 60.0,
                width: 350.0,
                child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFFF0F0F0), // Define a cor de fundo
                  onPrimary: Color(0xFF504848), // Define a cor do texto
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RecommendationCategory()),
                  );
                },
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children:[
                      Image.asset(
                        'assets/img/icons/icn_recommendation.png',
                        width: 50,
                        height: 50,
                      ),
                      SizedBox(width: 20),
                      const Text(
                        'Recomendações',
                        style: TextStyle(fontSize: 20),
                      )
                    ]
                ),
                ),
              ),
              SizedBox(height: 16.0),
              SizedBox(
                height: 60.0,
                width: 350.0,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFFF0F0F0), // Define a cor de fundo
                    onPrimary: Color(0xFF504848), // Define a cor do texto
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FoodList(filteringType: Consts.FAVORITE_FOODS)),
                    );
                  },
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children:[
                        SizedBox(width: 8),
                        Image.asset(
                          'assets/img/icons/icn_star.png',
                          width: 35,
                          height: 35,
                        ),
                        SizedBox(width: 70),
                        const Text(
                          'Favoritos',
                          style: TextStyle(fontSize: 20),
                        )
                      ]
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              SizedBox(
                height: 60.0,
                width: 350.0,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFFF0F0F0), // Define a cor de fundo
                    onPrimary: Color(0xFF504848), // Define a cor do texto
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterScreen()),
                    );
                  },
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children:[
                        SizedBox(width: 10),
                        Image.asset(
                          'assets/img/icons/icn_user.png',
                          width: 35,
                          height: 35,
                        ),
                        SizedBox(width: 20),
                        Text(
                          'Dados de Usuário',
                          style: TextStyle(fontSize: 20),
                        )
                      ]
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              SizedBox(
                height: 60.0,
                width: 350.0,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFFF0F0F0), // Define a cor de fundo
                    onPrimary: Color(0xFF504848),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children:[
                        SizedBox(width: 10),
                        Image.asset(
                          'assets/img/icons/icn_logout.png',
                          width: 35,
                          height: 35,
                        ),
                        SizedBox(width: 90),
                        Text(
                          'Sair',
                          style: TextStyle(fontSize: 20),
                        )
                      ]
                  ),
                ),
              ),
              SizedBox(height: 40.0)
            ],
          ),
        ),
      ),
    );
  }
}