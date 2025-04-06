import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_task/model/products_model.dart';
import 'package:flutter_task/view/widgets/text_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 21),
        child: Column(
          children: [
            SizedBox(height: height * .05),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.arrow_back_ios),
                ),
                SizedBox(width: width * .15),
                Text(
                  'Product Details',
                  style: GoogleFonts.playfairDisplay(
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(height: height * .02),
            Expanded(
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
                              onPressed: () {},
                              icon: Icon(Icons.favorite_border, size: 30),
                            ),
                          ],
                        ),
                        TextWidget(
                          title: 'Name',
                          value: api?.title ?? 'Not Exist',
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
                      ],
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
