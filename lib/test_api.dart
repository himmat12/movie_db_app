import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Category {
  int? status;
  List<Content>? contents;

  Category({this.status, this.contents});

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        status: json['status'],
        contents: List.from(jsonDecode(jsonEncode(json['content']))
            .map((e) => Content.fromJson(e as Map<String, dynamic>))),
      );
}

class Content {
  int? id;
  String? name;
  String? imagePath;

  Content({this.id, this.name, this.imagePath});

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        id: json['id'],
        name: json['name'] == null ? null : json['name'] as String?,
        imagePath:
            json['image_path'] == null ? null : json['image_path'] as String?,
      );
}

class ApiService {
  String authority = "gstore.ksushil.com.np";
  String unencodedPath = "/api/category.php";
  final client = http.Client();
  Category? category;

  Future<Category?> getCategories() async {
    try {
      final response = await client.get(Uri.http(authority, unencodedPath));

      // ignore: avoid_print
      print(response.statusCode);

      if (response.statusCode == 200) {
        category = Category.fromJson(jsonDecode(response.body)['category']);
        for (var i in category!.contents!) {
          // ignore: avoid_print
          print(i.name);
        }
        return category;
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }
}

class TestApiWidget extends StatefulWidget {
  const TestApiWidget({Key? key}) : super(key: key);

  @override
  State<TestApiWidget> createState() => _TestApiWidgetState();
}

class _TestApiWidgetState extends State<TestApiWidget> {
  final _service = ApiService();

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _service.getCategories().then((value) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _isLoading == true
                ? const LinearProgressIndicator()
                : ListView.separated(
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 12),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _service.category!.contents!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Text(_service.category!.contents![index].name ??
                          "no data");
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
