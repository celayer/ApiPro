import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_api_pro/service/post_model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<PostModel>? _items;

  @override
  void initState() {
    super.initState();
    _getPost();
  }

  Future<void> _getPost() async {
    final response =
        await Dio().get("https://jsonplaceholder.typicode.com/posts");
    if (response.statusCode == HttpStatus.ok) {
      final datas = response.data;
      if (datas is List) {
        setState(() {
          _items = datas.map((e) => PostModel.fromJson(e)).toList();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: _items?.length ?? 0,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.green,
            child: ListTile(leading: Text(_items?[index].id.toString()??""),
            subtitle: Text(_items?[index].body??""),
            title: Text(_items?[index].title??""),
            ),
          );
        },
      ),
    );
  }
}
