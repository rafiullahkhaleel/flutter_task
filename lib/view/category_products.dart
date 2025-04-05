import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_task/model/products_model.dart';
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
  State<CategoryProductsScreen> createState() =>
      _CategoryProductsScreenState();
}

class _CategoryProductsScreenState extends State<CategoryProductsScreen> {
  List<Products> dataList = [];
  Future<ProductsModel> getData() async {
    try {
      final response = await http.get(Uri.parse('https://dummyjson.com/products/category/${widget.url}'));

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
  }
  void fetchData() async {
    try {
      final fetchModel = await getData();
      final data = fetchModel.products ?? [];
      setState(() {
        dataList = data;
      });
    } catch (e) {
      print('Error fetching data: $e');
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
            // Title of the category screen
            Row(
              children: [
                IconButton(
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.arrow_back_ios)),
                Center(
                  child: Text(
                    widget.title,
                    style: GoogleFonts.playfairDisplay(
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: height * .015),
            // Search bar
            SizedBox(
              height: 45,
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search, size: 30),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(height: height * .02),
            // Displaying products in a list
            Expanded(
              child: dataList.isEmpty
                  ? Center(child: SpinKitWave(color: Colors.black))
                  : ListView.builder(
                itemCount: dataList.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Column(
                      children: [
                        // Display product image
                        CachedNetworkImage(
                          imageUrl: dataList[index].images?.isNotEmpty == true
                              ? dataList[index].images![0]
                              : 'https://via.placeholder.com/150', // Default placeholder image
                          height: height * .25,
                          width: width * .8,
                          placeholder: (context, url) => SpinKitCircle(
                            color: Colors.black,
                          ),
                          errorWidget: (context, url, error) => Icon(
                            Icons.error,
                            color: Colors.red,
                          ),
                        ),
                        // Product title
                        Text('${dataList[index].title}')
                      ],
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

















//
//
//
// import 'dart:convert';
//
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:flutter_task/model/products_model.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:http/http.dart' as http;
//
// class CategoryProductsScreen extends StatefulWidget {
//   final String url;
//   final String title;
//   const CategoryProductsScreen({
//     super.key,
//     required this.url,
//     required this.title,
//   });
//
//   @override
//   State<CategoryProductsScreen> createState() => _CategoryProductsScreenState();
// }
//
// class _CategoryProductsScreenState extends State<CategoryProductsScreen> {
//   List<Products> dataList = [];
//   Future<ProductsModel> getData() async {
//     final response = await http.get(
//       Uri.parse('https://dummyjson.com/products/${widget.url}'),
//     );
//     if (response.statusCode == 200) {
//       var data = jsonDecode(response.body);
//       return ProductsModel.fromJson(data);
//     } else {
//       throw Exception('Error');
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     fetchData();
//   }
//
//   void fetchData() async {
//     final fetchModel = await getData();
//     final data = fetchModel.products;
//     setState(() {
//       dataList = data!;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 21),
//         child: Column(
//           children: [
//             SizedBox(height: height * .05),
//             Text(
//               widget.title,
//               style: GoogleFonts.playfairDisplay(
//                 fontWeight: FontWeight.w600,
//                 fontSize: 24,
//                 color: Colors.black,
//               ),
//             ),
//             SizedBox(height: height * .015),
//             SizedBox(
//               height: 45,
//               child: TextField(
//                 decoration: InputDecoration(
//                   prefixIcon: Icon(Icons.search, size: 30),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: height * .02),
//             Expanded(
//               child:
//                   dataList.isEmpty
//                       ? Center(child: SpinKitWave(color: Colors.black))
//                       : ListView.builder(
//                         itemCount: dataList.length,
//                         itemBuilder: (context, index) {
//                           return Card(
//                             child: Column(
//                               children: [
//                                 CachedNetworkImage(
//                                   imageUrl: dataList[index].images?[0] ?? '',
//                                   height: height * .25,
//                                   width: width * .8,
//                                   placeholder:
//                                       (context, url) =>
//                                           SpinKitCircle(color: Colors.black),
//                                   errorWidget:
//                                       (context, url, error) =>
//                                           Icon(Icons.error, color: Colors.red),
//                                 ),
//                                 Text('${dataList[index].title}'),
//                               ],
//                             ),
//                           );
//                         },
//                       ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
