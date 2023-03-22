import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:service_deneme/service/post_model.dart';
import 'package:service_deneme/service/service_learn_post_view.dart';

class ServiceLearn extends StatefulWidget {
  const ServiceLearn({super.key});

  @override
  State<ServiceLearn> createState() => _ServiceLearnState();
}

class _ServiceLearnState extends State<ServiceLearn> {
  bool _isLoading = false;
  late final Dio _dio;

  @override
  void initState() {
    super.initState();
    _dio = Dio(BaseOptions(baseUrl: _baseUrl));
    fetchPostItems();
  }

  void _changeLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  List<PostModel>? _items;
  final _baseUrl = "https://jsonplaceholder.typicode.com/";
  void fetchPostItems() async {
    _changeLoading();
    final response = await _dio.get("posts");
    if (response.statusCode == HttpStatus.ok) {
      final _datas = response.data;
      if (_datas is List) {
        setState(() {
          _items = _datas.map((e) => PostModel.fromJson(e)).toList();
        });
      }
    }
    _changeLoading();
  }

  void fetchPostItemsAdvanced() async {
    _changeLoading();
    final response = await _dio.get("posts");
    if (response.statusCode == HttpStatus.ok) {
      final _datas = response.data;
      if (_datas is List) {
        setState(() {
          _items = _datas.map((e) => PostModel.fromJson(e)).toList();
        });
      }
    }
    _changeLoading();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actionsIconTheme: IconThemeData(size: 14),
        actions: [
          _isLoading
              ? const CircularProgressIndicator(
                  color: Colors.white,
                )
              : const SizedBox.shrink()
        ],
        title: TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ServicePostLearn()),
            );
          },
          child: const Text(
            "Ekle",
            style: TextStyle(color: Colors.green),
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemCount: _items?.length ?? 0,
        itemBuilder: (context, index) {
          return _PostCard(
            model: _items?[index],
          );
        },
      ),
    );
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
        leading: Text((_model?.userId).toString()),
        title: Text(_model?.title ?? ""),
        subtitle: Text(_model?.body ?? ""),
      ),
    );
  }
}
