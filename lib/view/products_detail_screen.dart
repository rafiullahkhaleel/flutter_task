import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductsDetailScreen extends StatefulWidget {
  final String image;
  final String name;
  final String price;
  final String category;
  final String brand;
  final int rating;
  final int stock;
  final String description;
  const ProductsDetailScreen({
    super.key,
    required this.image,
    required this.name,
    required this.price,
    required this.category,
    required this.brand,
    required this.rating,
    required this.stock,
    required this.description,
  });

  @override
  State<ProductsDetailScreen> createState() => _ProductsDetailScreenState();
}

class _ProductsDetailScreenState extends State<ProductsDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
