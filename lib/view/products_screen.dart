import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_task/model/products_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  Future<ProductsModel> getProducts() async {
    final response = await http.get(
      Uri.parse('https://dummyjson.com/products?limit=100'),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return ProductsModel.fromJson(data);
    } else {
      throw Exception('ERROR');
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<ProductsModel>(
        future: getProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SpinKitWave(color: Colors.black);
          } else if (snapshot.hasError) {
            return Center(child: Text('ERROR: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('No Data Available'));
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 21),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: height*.05,
                    ),
                    Text('Products',style: GoogleFonts.playfairDisplay(
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                        color: Colors.black
                    ),),
                    SizedBox(
                      height: height*.015,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search,size: 30,),
                        focusColor: Colors.black,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                        )
                      ),
                    ),
                    SizedBox(
                      height: height*.02,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data!.products!.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 7),
                            child: Card(
                              elevation: 0.5,
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  spacing: 10,
                                  children: [
                                    CachedNetworkImage(
                                      imageUrl:
                                          snapshot.data!.products![index].images![0]
                                              .toString(),
                                      height: height * .25,
                                      width: width * .8,
                                      placeholder:
                                          (context, url) =>
                                              SpinKitCircle(color: Colors.black),
                                      errorWidget:
                                          (context, url, error) =>
                                              Icon(Icons.error, color: Colors.red),
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                snapshot.data!.products![index].title
                                                    .toString(),
                                                style: GoogleFonts.poppins(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: width*.08,),
                                            Text(
                                              r'$' +
                                                  snapshot.data!.products![index].price
                                                      .toString(),
                                              style: GoogleFonts.poppins(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          '4.9⭐⭐⭐⭐⭐',
                                          style: GoogleFonts.poppins(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(height: height*.01,),
                                        Text(snapshot.data!.products![index].brand.toString(),
                                          style: GoogleFonts.poppins(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0x800C0C0C)
                                          ),
                                        ),
                                        SizedBox(height: height*.01,),
                                        Text(snapshot.data!.products![index].category.toString(),
                                          style: GoogleFonts.poppins(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        SizedBox(height: height*.013,),
                                      ],
                                    ),
                                  ],
                                ),
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
        },
      ),
    );
  }
}