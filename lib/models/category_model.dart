import 'package:flutter/material.dart';

class CategoryModel {
  CategoryModel(
      {required this.id, required this.title, this.color = Colors.orange});
  String id;
  String title;
  Color color;
}
