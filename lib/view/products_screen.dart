import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_task/model/products_model.dart';
import 'package:flutter_task/view/products_detail_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  TextEditingController search = TextEditingController();
  List<Products> dataList = [];
  List<Products> filteredList = [];

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
  void initState() {
    super.initState();
    getProducts().then((data) {
      if (!mounted) return;
      setState(() {
        dataList = data.products!;
        filteredList = data.products!;
      });
    });
    search.addListener(() {
      filterProducts();
    });
  }

  void filterProducts() {
    setState(() {
      filteredList =
          dataList.where((title) {
            return title.title?.toLowerCase().contains(
                  search.text.toLowerCase(),
                ) ??
                false;
          }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Products",
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
                controller: search,
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
              child:
                  dataList.isEmpty
                      ? Center(child: SpinKitWave(color: Colors.black))
                      : ListView.builder(
                        itemCount: filteredList.length,
                        itemBuilder: (context, index) {
                          final product = filteredList[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 7),
                            child: InkWell(
                              onTap: (){
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context)=>ProductsDetailScreen(
                                        id: product.id!)));
                              },
                              child: Card(
                                elevation: 0.5,
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  child: Column(
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl: product.images?[0] ?? '',
                                        height: height * .25,
                                        width: width * .8,
                                        placeholder:
                                            (context, url) => SpinKitCircle(
                                              color: Colors.black,
                                            ),
                                        errorWidget:
                                            (context, url, error) => Icon(
                                              Icons.error,
                                              color: Colors.red,
                                            ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  product.title ?? '',
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: width * .08),
                                              Text(
                                                '\$${product.price}',
                                                style: GoogleFonts.poppins(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            '${product.rating}  ⭐ ⭐ ⭐ ⭐ ⭐',
                                            style: GoogleFonts.poppins(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          SizedBox(height: height * .01),
                                          Text(
                                            product.brand ?? 'Not Exist',
                                            style: GoogleFonts.poppins(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0x800C0C0C),
                                            ),
                                          ),
                                          SizedBox(height: height * .01),
                                          Text(
                                            product.category ?? '',
                                            style: GoogleFonts.poppins(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          SizedBox(height: height * .013),
                                        ],
                                      ),
                                    ],
                                  ),
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
}
