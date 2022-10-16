import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_api_pro/service/post_model.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _name = "Name";
  final _lastName = "Last Name";
  final _tcNo = "No";
  final _Save = "Saved";

  TextEditingController _textEditingControllerName = TextEditingController();
  TextEditingController _textEditingControllerlastName =
      TextEditingController();
  TextEditingController _textEditingControllerId = TextEditingController();

  late final Dio _dio;
  final _baseUrl = "https://jsonplaceholder.typicode.com/";
  bool _isLoading = false;

  void _isLoadingCheck() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  /// DİO 'NUN BASE URL'Nİ TANIMLAMA İŞLEMİNİ BURADA YAP...
  @override
  void initState() {
    super.initState();

    _dio = Dio(BaseOptions(baseUrl: _baseUrl));
  }

  Future<void> insertApi(PostModel model) async {
    _isLoadingCheck(); // _islodgincheck Buttonu pasif haline getirmek için.
    final response = await _dio.post("posts", data: model);
    if (response.statusCode == HttpStatus.created) {
      print("Başarılı");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: _name,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              keyboardType: TextInputType.text,
              controller: _textEditingControllerName,
              textInputAction: TextInputAction.next,
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: _lastName,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              keyboardType: TextInputType.text,
              controller: _textEditingControllerlastName,
              textInputAction: TextInputAction.next,
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: _tcNo,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              keyboardType: TextInputType.number,
              controller: _textEditingControllerId,
              textInputAction: TextInputAction.next,
              maxLength: 11,
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _isLoading
                  ? null
                  : () {
                      if (_textEditingControllerName.text.isNotEmpty &&
                          _textEditingControllerlastName.text.isNotEmpty &&
                          _textEditingControllerId.text.isNotEmpty) {
                        final model = PostModel(
                          title: _textEditingControllerName.text,
                          body: _textEditingControllerlastName.text,
                          userId: int.tryParse(_textEditingControllerId.text),
                        );
                        insertApi(model);
                      }
                    },
              icon: Icon(Icons.save_outlined),
              label: Text(_Save),
            ),
          ],
        ),
      ),
    );
  }
}
