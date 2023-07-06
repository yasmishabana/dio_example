import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dio_register.dart';
import 'diocategory_list.dart';

class Diologin extends StatefulWidget {
  @override
  State<Diologin> createState() => _loginState();
}

class _loginState extends State<Diologin> {
  final _formKey = GlobalKey<FormState>();
  String url = "http://192.168.29.220:8080/TestProject/";

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late String username;
  late String password;

  login(username, password) async {
    Map data = {'username': username, 'password': password};

    final response = await Dio().post(
      "${url}dio_login.jsp",
      data: data,
    );

    print(response.statusCode);
    if (response.statusCode == 200) {
      Map<String, dynamic> resposne = response.data;

      if ("success" == resposne['msg']) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          duration: Duration(seconds: 2),
          content: Text('Login Success.........'),
          backgroundColor: Color.fromARGB(255, 175, 5, 152),
        ));
        // ignore: use_build_context_synchronously
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => DioMyHomePage()));

        log("Login Successfully Completed !!!!!!!!!!!!!!!!");
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Login failed.........'),
          backgroundColor: Color.fromARGB(255, 175, 5, 152),
        ));
      }
    } else {
      print("Please try again!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 175, 5, 152),
          title: Text('Login Page'),
        ),
        body: Padding(
            padding: EdgeInsets.all(15),
            child: Form(
              key: _formKey,
              child: Center(
                child: Container(
                  height: MediaQuery.of(context).size.height / 2.4,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 1,
                      ),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(15),
                        child: TextFormField(
                          controller: usernameController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'User Name',
                            hintText: 'Enter Your Name',
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your username';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            username = value;
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(15),
                        child: TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Password',
                            hintText: 'Enter Password',
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            password = value;
                          },
                        ),
                      ),
                      //====================sign in button===============

                      Container(
                        width: MediaQuery.of(context).size.width / 1.5,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(200),
                            color: Color.fromARGB(255, 175, 5, 152)),
                        child: TextButton(
                          child: const Text(
                            'Sign In',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              login(usernameController.text,
                                  passwordController.text);
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      //====================sign up button===============
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(200),
                            color: Color.fromARGB(255, 175, 5, 152)),
                        width: MediaQuery.of(context).size.width / 1.5,
                        child: TextButton(
                          child: const Text('Sign UP',
                              style: TextStyle(color: Colors.white)),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DioRegisterScreen()));
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )));
  }
}
