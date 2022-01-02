// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import './product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ]; //on veut que cette liste soit innaccessible de l'extérieur à cette classe, donc on crée le getter ci dessous.

  //var _showFavoriteOnly = false;

  List<Product> get items {
   // if (_showFavoriteOnly) {
   //   return _items.where((prodItem) => prodItem.isFavorite).toList();
   // }
    return [
      ..._items
    ]; //permet de faire une copie avec la mise en crochet et le caractère d'échappement
  }

/*
Pourquoi on utilise pas directement le _items? si on l'utilisait dans les autres fichiers, cette variable pointerait vers l'adresse en mémoire Ce n'est pas le comportement souhaité, car on a besoin d'utiliser une méthode spécifique afin d'utiliser les listeneurs du Provider. A chaque fois que l'on voudra faire des modifications sur la liste d'_items on passera par cette classe. Cela permet que les widgets utilisant cette classe seront reconstruits lors des modifications de la liste de Product.
*/
  List<Product> get FavoriteItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  void addProduct() {
    // _items.add(value);
    notifyListeners();
  }

  /* void showFavoritesOnly() {
    _showFavoriteOnly = true;
    notifyListeners();
  } */

  /* void showAll() {
    _showFavoriteOnly = false;
    notifyListeners();
  } */
}
