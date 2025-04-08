
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_task/model/products_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../provider/wishlist_provider.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  TextEditingController searchController = TextEditingController();
  List<Products> filteredList = [];

  @override
  void initState() {
    super.initState();
    final favouriteProvider = Provider.of<FavouriteProvider>(context, listen: false);
    filteredList = favouriteProvider.favourites;

    searchController.addListener(() {
      final favouritesList = favouriteProvider.favourites;
      setState(() {
        filteredList = favouritesList.where((data) {
          return data.title?.toLowerCase().contains(
            searchController.text.toLowerCase(),
          ) ?? false;
        }).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final favouriteProvider = Provider.of<FavouriteProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Favourites",
          style: GoogleFonts.playfairDisplay(
            fontWeight: FontWeight.w600,
            fontSize: 24,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 21),
        child: Column(
          children: [
            SizedBox(
              height: 45,
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search, size: 30),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(height: height * .02),
            Expanded(
              child: favouriteProvider.favourites.isEmpty
                  ? Center(child: Text("No Favourite Products"))
                  : ListView.builder(
                itemCount: filteredList.length,
                itemBuilder: (context, index) {
                  final product = filteredList[index];
                  return Card(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Container(
                            width: 85,
                            height: 85,
                            decoration: BoxDecoration(
                              color: Colors.brown.withOpacity(.15),
                              shape: BoxShape.circle,
                            ),
                            child: CachedNetworkImage(
                              imageUrl: product.thumbnail ?? '',
                              fit: BoxFit.cover,
                              placeholder: (context, url) {
                                return SpinKitCircle(
                                  color: Colors.black,
                                );
                              },
                              errorWidget: (context, url, error) {
                                return Icon(
                                  Icons.error,
                                  color: Colors.red,
                                );
                              },
                            ),
                          ),
                          SizedBox(width: width * .03),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.title ?? 'No Title',
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  "\$${product.price}",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 11,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  '${product.rating}  ⭐ ⭐ ⭐ ⭐ ⭐',
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 10,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                icon: Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  favouriteProvider.toggleFavourite(product);
                                  setState(() {
                                    filteredList = favouriteProvider.favourites.where((data) {
                                      return data.title?.toLowerCase().contains(
                                        searchController.text.toLowerCase(),
                                      ) ?? false;
                                    }).toList();
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
