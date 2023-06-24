import 'package:flutter/material.dart';
import 'package:food_tips/home.dart';

void main() {
  runApp(BiometricInfo());
}

class BiometricInfo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Image.asset('assets/icons/icn_back.png'),
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
                    SizedBox(height: 16.0),
                    SizedBox(
                      child: Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              items: [
                                DropdownMenuItem<String>(
                                  value: 'M',
                                  child: Text(
                                    'Masculino',
                                    style: TextStyle(
                                      color: Colors.black45,
                                    ),
                                  ),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'F',
                                  child: Text(
                                    'Feminino',
                                    style: TextStyle(
                                      color: Colors.black45,
                                    ),
                                  ),
                                ),
                              ],
                              decoration: InputDecoration(
                                labelText: 'Sexo',
                                labelStyle: TextStyle(
                                  color: Colors.black45,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              onChanged: (value) {
                                // Lógica para lidar com a seleção do valor
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
                            MaterialPageRoute(builder: (context) => Home()),
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