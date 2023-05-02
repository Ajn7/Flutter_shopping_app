import 'package:flutter/material.dart';

class TileCategory{
  final int id;
  final String title;
  final String description;
  final Color color;

  const TileCategory({
    required this.id,
    required this.title,
    required this.description,
    this.color=Colors.purple
  });
}