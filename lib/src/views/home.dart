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
  late String _status = '';
  late int _age = 0;
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
          );

          //Verificando Status
          int age = Utils.calculateAge(user.birthDate);

          if(age > 18){
            if(userInfo.imc! > 18.5 && userInfo.imc!   < 24.9) {
              _status = "Saudável";
            }else {
              _status = "Não Saudável";
            }
          }
          else{
            if(userInfo.imc! > 5 && userInfo.imc!  < 85) {
              _status = "Saudável";
            }else {
              _status = "Não Saudável";
            }
          }


          setState(() {
            _imc = userInfo.imc;
            _age = age;
            _firstName = user.firstName;
            _lastName = user.lastName;
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
                  height: 225,
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
                                  value: _imc,
                                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF0C9522)),
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
                            'Status:',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF504848),
                            ),
                          ),
                          SizedBox(width: 10.0),
                          Text(
                            _status,
                            style: TextStyle(
                              fontSize: 20,
                              color: Color(0xFF504848),
                            ),
                          ),
                        ],
                      ),
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
                        Image.asset(
                          'assets/img/icons/icn_star.png',
                          width: 50,
                          height: 50,
                        ),
                        SizedBox(width: 20),
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