import 'package:flutter/material.dart';
import 'dart:convert';

import '../services/apiService.dart';
import 'package:http/http.dart' as http;

import '../utils/utils.dart';
import 'home.dart';

void main() {
  runApp(RegisterScreen());
}

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _register () async {

      final url = 'http://10.0.2.2:8000/api/v1/user/';

      try {
        final response = await http.post(
          Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
          },
          body: json.encode({
            'username': _usernameController.text,
            'first_name': _firstNameController.text,
            'last_name': _lastNameController.text,
            'email': _emailController.text,
            'birth_date': Utils.fmtData(_birthDateController.text),
            'password': _passwordController.text
          }),
        );

        if (response.statusCode == 201) {

          final url = 'http://10.0.2.2:8000/auth/';

          try {
            final response = await http.post(
              Uri.parse(url),
              headers: {
                'Content-Type': 'application/json',
              },
              body: json.encode({
                'username': _usernameController.text,
                'password': _passwordController.text,
              }),
            );

            if (response.statusCode == 200) {
              String token = json.decode(response.body)['token'];
              ApiService().setApiKey(token);

              // Navigate to the Home screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Home()),
              );

            } else if (response.statusCode == 401) {
              // Unauthorized: Invalid credentials
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Erro ao realizar autentificação.'),
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
            } else {
              // Handle other response statuses as needed
              print('Login failed with status code: ${response.statusCode}');
            }
          } catch (e) {
            print('Login failed with exception: $e');
          }

        }
        else if (response.statusCode == 401) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Não foi possível realizar cadastro de Usuário'),
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
        else {
          // Handle other response status as needed
          print('Register failed with status code: ${response.statusCode}');
        }
      }
      catch (e) {
        print('Register failed with exception: $e');
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    TextField(
                      controller: _firstNameController,
                      decoration: InputDecoration(
                        labelText: 'Nome',
                        labelStyle: TextStyle(
                          color: Colors.black45, // Defina a cor desejada aqui
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    TextField(
                      controller: _lastNameController,
                      decoration: InputDecoration(
                        labelText: 'Sobrenome',
                        labelStyle: TextStyle(
                          color: Colors.black45, // Defina a cor desejada aqui
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(
                          color: Colors.black45, // Defina a cor desejada aqui
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    TextField(
                      controller: _birthDateController,
                      decoration: InputDecoration(
                        labelText: 'Data de Nascimento',
                        labelStyle: TextStyle(
                          color: Colors.black45, // Defina a cor desejada aqui
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    SizedBox(height: 32.0),
                    TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        labelText: 'Username',
                        labelStyle: TextStyle(
                          color: Colors.black45, // Defina a cor desejada aqui
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Senha',
                        labelStyle: TextStyle(
                          color: Colors.black45, // Defina a cor desejada aqui
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      obscureText: true,
                    ),
                    SizedBox(height: 32.0),
                    SizedBox(
                      height: 50.0,
                      width: 300.0,
                      child: ElevatedButton(
                        onPressed: _register,
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
