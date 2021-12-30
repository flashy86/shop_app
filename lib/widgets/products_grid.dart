import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import '../widgets/product_item.dart';

class ProductsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = productsData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10),

      itemCount: products.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
          value: products[i],
          child: ProductItem(
              // products[i].id, products[i].title, products[i].imageUrl
              )),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
      //le grid delegate indique comment la grille doit être structurée, c'est ici que l'on définit le nombre de colonnes et de lignes par ex alors que l'itembBuilder est le générateur d'éléments, il définit la façon dont chaque élément de la grille est construit. On pourrait dire que l'itemBuilder est le fond alors que gridDelegate est la forme. SliverGridDelegateWithFixedCrossAxisCount: on indique le nombre d'éléments que l'on souhaite par ligne par ex, puis c'est ce widget qui s'occupe de la taille des éléments pour que cela rentre dans la grille.
    );
  }
}
