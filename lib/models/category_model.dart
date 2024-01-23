/*A blueprint for the default implementation of the method 
that returns the value of the given property.*/

import 'package:flutter/material.dart';

class CategoryModel {
  const CategoryModel(
      {required this.id, required this.title, this.color = Colors.orange});

  final String id, title;
  final Color color;
}
