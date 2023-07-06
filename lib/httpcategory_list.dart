import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class HttpMyHomePage extends StatefulWidget {
  const HttpMyHomePage({Key? key}) : super(key: key);

  @override
  State<HttpMyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HttpMyHomePage> {
  String url = "http://192.168.121.147:8080/TestProject/getCategory.jsp";
  late Future<List<CategoryModel>> category;

  @override
  void initState() {
    category = getcategory();
  }

  Future<List<CategoryModel>> getcategory() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      print(response.statusCode);
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      print(parsed);

      return parsed
          .map<CategoryModel>((json) => CategoryModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load Category............');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 168, 5, 133),
        title: const Text('Category List'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<List<CategoryModel>>(
            future: category,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          final CategoryModel category = snapshot.data![index];

                          return Card(
                              child: ListTile(
                            title: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(category.title),
                            ),
                          ));
                        }));
              }
              return const Center(child: CircularProgressIndicator());
            }),
      ),
    );
  }
}

class CategoryModel {
  String id;
  String title;

  CategoryModel({
    required this.id,
    required this.title,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["id"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
      };
}
