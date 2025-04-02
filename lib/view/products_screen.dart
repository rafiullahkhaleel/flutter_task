import 'dart:convert';

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
      setState(() {});
    } else {
      throw Exception('ERROR');
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
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
            return Center(
              child: ListView.builder(
                  itemCount: snapshot.data!.products!.length,
                  itemBuilder: (context,index){
                    return Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        spacing: 10,
                        children: [
                          Image.network(snapshot.data!.products![index].images![0].toString(),
                            height: height*.25,
                            width: width*.8,
                            errorBuilder: (context,error,stackTrace){
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 50),
                              child: Center(child: Text('Image not available')),
                            );
                            },
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              } else {
                                return Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 100),
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              }
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(r'$'+snapshot.data!.products![index].title.toString(),
                              style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.w600),
                              ),
                              Text(r'$'+snapshot.data!.products![index].price.toString(),
                                style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.w600),

                              )

                            ],
                          )
                        ],
                      ),
                    );
                  }),
            );
          }
        },
      ),
    );
  }
}


