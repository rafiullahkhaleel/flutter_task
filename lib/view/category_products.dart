import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_task/model/products_model.dart';
import 'package:flutter_task/view/products_detail_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class CategoryProductsScreen extends StatefulWidget {
  final String url;
  final String title;

  const CategoryProductsScreen({
    super.key,
    required this.url,
    required this.title,
  });

  @override
  State<CategoryProductsScreen> createState() => _CategoryProductsScreenState();
}

class _CategoryProductsScreenState extends State<CategoryProductsScreen> {
  TextEditingController searchController = TextEditingController();
  List<Products> dataList = [];
  List<Products> filteredList = [];
  Future<ProductsModel> getData() async {
    try {
      final response = await http.get(
        Uri.parse('https://dummyjson.com/products/category/${widget.url}'),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return ProductsModel.fromJson(data);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
    searchController.addListener(() {
      filteredData();
    });
  }

  void fetchData() async {
    try {
      final fetchModel = await getData();
      final data = fetchModel.products ?? [];
      setState(() {
        dataList = data;
        filteredList = data;
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  void filteredData() {
    setState(() {
      filteredList =
          dataList.where((data) {
            return data.title!.toLowerCase().contains(
              searchController.text.toLowerCase(),
            );
          }).toList();
    });
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
                SizedBox(width: width * .2),
                Text(
                  widget.title,
                  style: GoogleFonts.playfairDisplay(
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(height: height * .015),
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
                      : ListView.builder(
                        itemCount: filteredList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => ProductsDetailScreen(
                                          id: filteredList[index].id!,
                                        ),
                                  ),
                                );
                              },
                              child: Card(
                                elevation: 0.5,
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  child: Column(
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl:
                                            filteredList[index].images?[0] ??
                                            '',
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
                                                  filteredList[index].title ??
                                                      '',
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: width * .08),
                                              Text(
                                                '\$${filteredList[index].price}',
                                                style: GoogleFonts.poppins(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            '${filteredList[index].rating}  ⭐ ⭐ ⭐ ⭐ ⭐',
                                            style: GoogleFonts.poppins(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          SizedBox(height: height * .01),
                                          Text(
                                            filteredList[index].brand ?? 'Not Exist',
                                            style: GoogleFonts.poppins(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0x800C0C0C),
                                            ),
                                          ),
                                          SizedBox(height: height * .01),
                                          Text(
                                            filteredList[index].category ?? '',
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






