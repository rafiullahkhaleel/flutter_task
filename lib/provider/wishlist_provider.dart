import 'package:flutter/material.dart';
import '../../model/products_model.dart';

class FavouriteProvider with ChangeNotifier {
  final List<Products> _favourites = [];

  List<Products> get favourites => _favourites;

  void toggleFavourite(Products product) {
    final isExist = _favourites.any((element) => element.id == product.id);
    if (isExist) {
      _favourites.removeWhere((element) => element.id == product.id);
    } else {
      _favourites.add(product);
    }
    notifyListeners();
  }

  bool isFavourite(int productId) {
    return _favourites.any((element) => element.id == productId);
  }
}
