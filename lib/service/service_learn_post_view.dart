import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:service_deneme/service/post_model.dart';

class ServicePostLearn extends StatefulWidget {
  const ServicePostLearn({super.key});

  @override
  State<ServicePostLearn> createState() => _ServicePostLearnState();
}

class _ServicePostLearnState extends State<ServicePostLearn> {
  String appBarTitle = "Veri Ekleme Alanı";
  bool _isLoading = false;
  late final Dio _dio;
  final _baseUrl = "https://jsonplaceholder.typicode.com/";

  TextEditingController _titleController = TextEditingController();
  TextEditingController _bodyController = TextEditingController();
  TextEditingController _userIdController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _dio = Dio(BaseOptions(baseUrl: _baseUrl));
  }

  void _changeLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  Future<void> _addItemToService(PostModel postModel) async {
    _changeLoading();

    final response = await _dio.post('posts', data: postModel);

    if (response.statusCode == HttpStatus.created) {
      appBarTitle = "Başarılı";
    }
    _changeLoading();
  }

  @override
  Widget build(BuildContext context) {
    const _buttonText = "Send";
    return Scaffold(
        appBar: AppBar(
          actions: [
            _isLoading
                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                : const SizedBox.shrink()
          ],
          toolbarHeight: 50,
          title: Text(appBarTitle),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
                textInputAction: TextInputAction.next,
                controller: _titleController,
                decoration: const InputDecoration(labelText: "Title"),
              ),
              TextField(
                textInputAction: TextInputAction.next,
                controller: _bodyController,
                decoration: const InputDecoration(labelText: "Body"),
              ),
              TextField(
                textInputAction: TextInputAction.next,
                controller: _userIdController,
                decoration: const InputDecoration(labelText: "UserId"),
                keyboardType: TextInputType.number,
              ),
              TextButton(
                  onPressed: _isLoading
                      ? null
                      : () {
                          if (_titleController.text.isNotEmpty &&
                              _bodyController.text.isNotEmpty &&
                              _userIdController.text.isNotEmpty) {
                            final model = PostModel(
                                body: _bodyController.text,
                                title: _titleController.text,
                                userId: int.tryParse(_userIdController.text));
                            _addItemToService(model);
                          }
                        },
                  child: const Text(_buttonText))
            ],
          ),
        ));
  }
}

class _PostCard extends StatelessWidget {
  const _PostCard({
    super.key,
    required PostModel? model,
  }) : _model = model;

  final PostModel? _model;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      child: ListTile(
        title: Text(_model?.title ?? ""),
        subtitle: Text(_model?.body ?? ""),
      ),
    );
  }
}
