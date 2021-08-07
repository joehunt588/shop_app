import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';

import 'package:shop_app/providers/product.dart';
import 'package:shop_app/screens/product_details_screen.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Product>(
      context,
      listen: false, //no update
    );
    final cart = Provider.of<Cart>(
      context,
      listen: false, //no update
    );
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailScreen.RouteName,
              arguments: productsData.id,
            );
          },
          child: Image.network(
            productsData.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          leading: Consumer<Product>(
            //to update the favourite button real time
            builder: (context, productData, child) => IconButton(
              color: Theme.of(context).accentColor,
              icon: Icon(
                productData.isFavourite //if
                    ? Icons.favorite //true
                    : Icons.favorite_border, //else false
              ),
              onPressed: () {
                // print(productsData.isFavourite);
                productsData.toggleFavouriteStatus();
              },
            ),
          ),
          title: Text(
            productsData.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            color: Theme.of(context).accentColor,
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              cart.addItem(
                  productsData.id, productsData.price, productsData.title);
            },
          ),
        ),
      ),
    );
  }
}
