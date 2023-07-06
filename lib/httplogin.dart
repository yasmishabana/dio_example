import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'httpRegister.dart';
import 'httpcategory_list.dart';

class HttpLogin extends StatefulWidget {
  @override
  State<HttpLogin> createState() => _HttpLoginState();
}

class _HttpLoginState extends State<HttpLogin> {
  final _formKey = GlobalKey<FormState>();
  String url = "http://192.168.121.147:8080/TestProject/http_login.jsp";

  late bool newuser;

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late String username, password;
  // late String password;

  login(username, password) async {
    Map data = {'username': username, 'password': password};

    final response = await http.post(
      Uri.parse(url),
      body: data,
    );

    print(response.statusCode);
    if (response.statusCode == 200) {
      Map<String, dynamic> resposne = jsonDecode(response.body);

      if ("success" == resposne['msg']) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Login Success.........'),
          backgroundColor: Color.fromARGB(255, 175, 5, 152),
        ));
        // ignore: use_build_context_synchronously
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HttpMyHomePage()));
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 168, 5, 133),
          title: Text('Login Page'),
        ),
        body: Form(
          key: _formKey,
          child: Center(
            child: Container(
              height: MediaQuery.of(context).size.height / 2.4,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 1,
                  ),
                ],
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
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
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
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
                          login(
                              usernameController.text, passwordController.text);
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
                                builder: (context) => RegisterScreen()));
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
