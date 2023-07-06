import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'diologin.dart';

class DioRegisterScreen extends StatefulWidget {
  const DioRegisterScreen({Key? key}) : super(key: key);
  //   final _formKey = GlobalKey<FormState>();

  @override
  State<DioRegisterScreen> createState() => _regscreenState();
}

class _regscreenState extends State<DioRegisterScreen> {
  String url = "http://192.168.29.220:8080/TestProject/dio_register.jsp";
  final _formkey = GlobalKey<FormState>();
  bool isLoading = false;

  signup(name, mobile, address, username, password) async {
    setState(() {
      isLoading = true;
    });
    print("Calling");
    Map data = {
      'name': name,
      'mobile': mobile,
      'address': address,
      'username': username,
      'password': password
    };

    final response = await Dio().post(
      url,
      data: data,
    );

    print(response.statusCode);
    if (response.statusCode == 200) {
      Map<String, dynamic> resposne = response.data;
      if ("success" == resposne['message']) {
        // ignore: use_build_context_synchronously
        Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
          return Diologin();
        }));

        print("Registration Successfully Completed !!!!!!!!!!!!!!!!");
      } else {
        print("Registration failed.........");
      }
    } else {
      print("Please try again!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    }
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController adressController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late String name, phone, adress, username, password;

  String? gender;
  String? _dropDownValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 168, 5, 133),
          title: Text('Register Page'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: Form(
              key: _formkey,
              child: ListView(children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      '',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    )),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Enter Your Name';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      name = value;
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    controller: phoneNumberController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Phone Number',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Enter Your Phone Number';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      phone = value;
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: adressController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Address',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Enter Your Address';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      adress = value;
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextFormField(
                    controller: usernameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'User Name',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Enter Your User Name';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      username = value;
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextFormField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Enter Your Password';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      password = value;
                    },
                  ),
                ),
                Container(
                    height: 70,
                    padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 168, 5, 133),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: const Text('Register'),
                      ),
                      onPressed: () {
                        //==========call register()===========

                        if (_formkey.currentState!.validate()) {
                          signup(
                              nameController.text,
                              phoneNumberController.text,
                              adressController.text,
                              usernameController.text,
                              passwordController.text);
                        }
                      },
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('If you already have a account?'),
                    TextButton(
                      onPressed: () {
                        //signup screen
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Diologin()));
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(fontSize: 15, color: Colors.purple),
                      ),
                    )
                  ],
                ),
              ]),
            )));
  }
}
