import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_task/model/categories_model.dart';
import 'package:flutter_task/view/category_products.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  TextEditingController searchController = TextEditingController();
  List<CategoriesModel> dataList = [];
  List<CategoriesModel> filteredList = [];

  Future<List<CategoriesModel>> getData() async {
    final response = await http.get(
      Uri.parse('https://dummyjson.com/products/categories'),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List<CategoriesModel> apiList = [];

      for (Map<String, dynamic> item in data) {
        final model = CategoriesModel.fromJson(item);
        model.image = await fetchFirstProductImage(model.url ?? '');
        apiList.add(model);
      }

      return apiList;
    } else {
      throw Exception('Error fetching categories');
    }
  }

  Future<String?> fetchFirstProductImage(String url) async {
    try {
      final res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        final json = jsonDecode(res.body);
        final products = json['products'];
        if (products != null && products.length > 0) {
          return products[0]['thumbnail'];
        }
      }
    } catch (e) {
      print('Image fetch error: $e');
    }
    return null;
  }

  @override
  void initState(){
    super.initState();
    fetchCategories();
    searchController.addListener(() {
      filteredCategories();
    });
  }

  void fetchCategories() async {
    final data = await getData();
    if (!mounted) return;
    setState(() {
      dataList = data;
      filteredList = data;
    });
  }
  void filteredCategories() {
    setState(() {

    });
    filteredList =
        dataList.where((name) {
          return name.name?.toLowerCase().contains(
                searchController.text.toLowerCase(),
              ) ??
              false;
        }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Categories",
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
              child:
                  dataList.isEmpty
                      ? Center(child: SpinKitWave(color: Colors.black))
                      : GridView.count(
                        childAspectRatio: width / height * 2,
                        crossAxisCount: 2,
                        mainAxisSpacing: height * .03,
                        crossAxisSpacing: width * .075,
                        children: List.generate(filteredList.length, (index) {
                          final category = filteredList[index];
                          return InkWell(
                            onTap: (){
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context)=> CategoryProductsScreen(
                                      url: category.slug.toString(),
                                      title: category.name.toString())));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.brown.withOpacity(.5),
                              ),
                              child: Stack(
                                children: [
                                  Center(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child:
                                          category.image != null
                                              ? CachedNetworkImage(
                                                imageUrl: category.image!,
                                                fit: BoxFit.cover,
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
                                              )
                                              : Icon(Icons.image, size: 40),
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Align(
                                    alignment: Alignment(-.8, .7),
                                    child: Text(
                                      category.name ?? '',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xfff2f2f2),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
