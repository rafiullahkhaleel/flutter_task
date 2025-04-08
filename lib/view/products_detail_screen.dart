import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_task/model/products_model.dart';
import 'package:flutter_task/view/widgets/text_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../provider/wishlist_provider.dart';

class ProductsDetailScreen extends StatefulWidget {
  final int id;
  const ProductsDetailScreen({super.key, required this.id});

  @override
  State<ProductsDetailScreen> createState() => _ProductsDetailScreenState();
}

class _ProductsDetailScreenState extends State<ProductsDetailScreen> {
  Future<Products> getData() async {
    final response = await http.get(
      Uri.parse('https://dummyjson.com/products/${widget.id}'),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return Products.fromJson(data);
    } else {
      throw Exception('ERROR OCCURRED');
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            onPressed: (){
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios)),
        title: Text(
          "Product Details",
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
        padding: EdgeInsets.symmetric(horizontal: 21),
        child: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: SpinKitWave(color: Colors.black));
            } else if (snapshot.hasError) {
              return Center(child: Text('ERROR : ${snapshot.error}'));
            } else if (!snapshot.hasData) {
              return Center(child: Text('No Data Available'));
            } else {
              final api = snapshot.data;
              final images = api?.images ?? [];

              List<String> leftImages = [];
              List<String> rightImages = [];

              for (int i = 0; i < images.length; i++) {
                if (i % 2 == 0) {
                  leftImages.add(images[i]);
                } else {
                  rightImages.add(images[i]);
                }
              }

              final favouriteProvider = Provider.of<FavouriteProvider>(context);

              return Column(
                spacing: height * .01,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CachedNetworkImage(
                    imageUrl: api?.images?[0] ?? '',
                    height: height * .25,
                    width: width * .8,
                    placeholder:
                        (context, url) =>
                            SpinKitCircle(color: Colors.black),
                    errorWidget:
                        (context, url, error) =>
                            Icon(Icons.error, color: Colors.red),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Product Details:',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          favouriteProvider.toggleFavourite(api);
                        },
                        icon: Icon(
                          favouriteProvider.isFavourite(api!.id!)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          size: 30,
                          color: favouriteProvider.isFavourite(api.id!)
                              ? Colors.red
                              : Colors.black,
                        ),
                      ),
                    ],
                  ),
                  TextWidget(
                    title: 'Name',
                    value: api.title ?? 'Not Exist',
                  ),
                  TextWidget(
                    title: 'Price',
                    value: api?.price.toString() ?? 'Not Exist',
                  ),
                  TextWidget(
                    title: 'Category',
                    value: api?.category ?? 'Not Exist',
                  ),
                  TextWidget(
                    title: 'Brand',
                    value: api?.brand ?? 'Not Exist',
                  ),
                  TextWidget(
                    title: 'Brand',
                    value:
                        api?.rating != null
                            ? '${api?.rating.toString()}   ⭐ ⭐ ⭐ ⭐'
                            : 'Not Exist',
                  ),
                  TextWidget(
                    title: 'Description',
                    value:
                        api?.rating != null
                            ? '\n${api?.description.toString()}'
                            : 'Not Exist',
                  ),
                  Flexible(
                    child: Row(
                      children: [
                        Flexible(
                          child: ListView(
                            children: [
                              Text(
                                'Product Gallery:',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              ...List.generate(leftImages.length, (
                                index,
                              ) {
                                return Column(
                                  children: [
                                    SizedBox(height: height * .018),
                                    Container(
                                      width: width * .42,
                                      height: height * .12,
                                      color: Colors.brown.withOpacity(
                                        .25,
                                      ),
                                      child: CachedNetworkImage(
                                        imageUrl: leftImages[index],
                                        placeholder:
                                            (context, url) =>
                                                SpinKitCircle(
                                                  color: Colors.black,
                                                ),
                                        errorWidget:
                                            (context, url, error) => Icon(
                                              Icons.error,
                                              color: Colors.red,
                                            ),
                                      ),
                                    ),
                                  ],
                                );
                              }),
                            ],
                          ),
                        ),

                        Flexible(
                          child: ListView(
                            children: [
                              ...List.generate(rightImages.length, (
                                index,
                              ) {
                                return Column(
                                  children: [
                                    Container(
                                      width: width * .42,
                                      height: height * .12,
                                      color: Colors.brown.withOpacity(
                                        .25,
                                      ),
                                      child: CachedNetworkImage(
                                        imageUrl: rightImages[index],
                                        placeholder:
                                            (context, url) =>
                                                SpinKitCircle(
                                                  color: Colors.black,
                                                ),
                                        errorWidget:
                                            (context, url, error) => Icon(
                                              Icons.error,
                                              color: Colors.red,
                                            ),
                                      ),
                                    ),
                                    SizedBox(height: height * .018),
                                  ],
                                );
                              }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
