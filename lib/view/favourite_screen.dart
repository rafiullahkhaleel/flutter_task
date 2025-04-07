import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../provider/wishlist_provider.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favouriteProvider = Provider.of<FavouriteProvider>(context);
    final favourites = favouriteProvider.favourites;

    return Scaffold(
      appBar: AppBar(title: Text("My Favourites")),
      body: favourites.isEmpty
          ? Center(child: Text("No Favourite Products"))
          : ListView.builder(
        itemCount: favourites.length,
        itemBuilder: (context, index) {
          final product = favourites[index];
          return ListTile(
            leading: CachedNetworkImage(
              imageUrl: product.thumbnail ?? '',
              width: 50,
              height: 50,
            ),
            title: Text(product.title ?? 'No Title'),
            subtitle: Text("\$${product.price}"),
            trailing: IconButton(
              icon: Icon(Icons.remove_circle),
              onPressed: () {
                favouriteProvider.toggleFavourite(product);
              },
            ),
          );
        },
      ),
    );
  }
}
