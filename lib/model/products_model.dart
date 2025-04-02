
class ProductsModel {
  List<Products>? products;
  int? total;
  int? skip;
  int? limit;

  ProductsModel({this.products, this.total, this.skip, this.limit});

  ProductsModel.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
    total = json['total'];
    skip = json['skip'];
    limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    data['total'] = total;
    data['skip'] = skip;
    data['limit'] = limit;
    return data;
  }
}

class Products {
  int? id;
  String? title;
  String? description;
  String? category;
  double? price;
  double? discountPercentage;
  double? rating;
  int? stock;
  List<String>? tags;
  String? brand;
  String? sku;
  int? weight;
  Dimensions? dimensions;
  String? warrantyInformation;
  String? shippingInformation;
  String? availabilityStatus;
  List<Reviews>? reviews;
  String? returnPolicy;
  int? minimumOrderQuantity;
  Meta? meta;
  List<String>? images;
  String? thumbnail;

  Products({
    this.id,
    this.title,
    this.description,
    this.category,
    this.price,
    this.discountPercentage,
    this.rating,
    this.stock,
    this.tags,
    this.brand,
    this.sku,
    this.weight,
    this.dimensions,
    this.warrantyInformation,
    this.shippingInformation,
    this.availabilityStatus,
    this.reviews,
    this.returnPolicy,
    this.minimumOrderQuantity,
    this.meta,
    this.images,
    this.thumbnail,
  });

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    category = json['category'];
    price = (json['price'] as num).toDouble();
    discountPercentage = (json['discountPercentage'] as num).toDouble();
    rating = (json['rating'] as num).toDouble();
    stock = json['stock'];
    tags = json['tags']?.cast<String>();
    brand = json['brand'];
    sku = json['sku'];
    weight = json['weight'];
    dimensions = json['dimensions'] != null
        ? Dimensions.fromJson(json['dimensions'])
        : null;
    warrantyInformation = json['warrantyInformation'];
    shippingInformation = json['shippingInformation'];
    availabilityStatus = json['availabilityStatus'];
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews!.add(Reviews.fromJson(v));
      });
    }
    returnPolicy = json['returnPolicy'];
    minimumOrderQuantity = json['minimumOrderQuantity'];
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    images = json['images']?.cast<String>();
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['category'] = category;
    data['price'] = price;
    data['discountPercentage'] = discountPercentage;
    data['rating'] = rating;
    data['stock'] = stock;
    data['tags'] = tags;
    data['brand'] = brand;
    data['sku'] = sku;
    data['weight'] = weight;
    if (dimensions != null) {
      data['dimensions'] = dimensions!.toJson();
    }
    data['warrantyInformation'] = warrantyInformation;
    data['shippingInformation'] = shippingInformation;
    data['availabilityStatus'] = availabilityStatus;
    if (reviews != null) {
      data['reviews'] = reviews!.map((v) => v.toJson()).toList();
    }
    data['returnPolicy'] = returnPolicy;
    data['minimumOrderQuantity'] = minimumOrderQuantity;
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    data['images'] = images;
    data['thumbnail'] = thumbnail;
    return data;
  }
}

class Dimensions {
  double? width;
  double? height;
  double? depth;

  Dimensions({this.width, this.height, this.depth});

  Dimensions.fromJson(Map<String, dynamic> json) {
    width = (json['width'] as num).toDouble();
    height = (json['height'] as num).toDouble();
    depth = (json['depth'] as num).toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['width'] = width;
    data['height'] = height;
    data['depth'] = depth;
    return data;
  }
}

class Reviews {
  double? rating;
  String? comment;
  String? date;
  String? reviewerName;
  String? reviewerEmail;

  Reviews({
    this.rating,
    this.comment,
    this.date,
    this.reviewerName,
    this.reviewerEmail,
  });

  Reviews.fromJson(Map<String, dynamic> json) {
    rating = (json['rating'] as num).toDouble();
    comment = json['comment'];
    date = json['date'];
    reviewerName = json['reviewerName'];
    reviewerEmail = json['reviewerEmail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rating'] = rating;
    data['comment'] = comment;
    data['date'] = date;
    data['reviewerName'] = reviewerName;
    data['reviewerEmail'] = reviewerEmail;
    return data;
  }
}

class Meta {
  String? createdAt;
  String? updatedAt;
  String? barcode;
  String? qrCode;

  Meta({this.createdAt, this.updatedAt, this.barcode, this.qrCode});

  Meta.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    barcode = json['barcode'];
    qrCode = json['qrCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['barcode'] = barcode;
    data['qrCode'] = qrCode;
    return data;
  }
}

















// class ProductsModel {
//   List<Products>? products;
//   int? total;
//   int? skip;
//   int? limit;
//
//   ProductsModel({this.products, this.total, this.skip, this.limit});
//
//   ProductsModel.fromJson(Map<String, dynamic> json) {
//     if (json['products'] != null) {
//       products = <Products>[];
//       json['products'].forEach((v) {
//         products!.add(new Products.fromJson(v));
//       });
//     }
//     total = json['total'];
//     skip = json['skip'];
//     limit = json['limit'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.products != null) {
//       data['products'] = this.products!.map((v) => v.toJson()).toList();
//     }
//     data['total'] = this.total;
//     data['skip'] = this.skip;
//     data['limit'] = this.limit;
//     return data;
//   }
// }
//
// class Products {
//   int? id;
//   String? title;
//   String? description;
//   String? category;
//   double? price;
//   double? discountPercentage;
//   double? rating;
//   int? stock;
//   List<String>? tags;
//   String? brand;
//   String? sku;
//   int? weight;
//   Dimensions? dimensions;
//   String? warrantyInformation;
//   String? shippingInformation;
//   String? availabilityStatus;
//   List<Reviews>? reviews;
//   String? returnPolicy;
//   int? minimumOrderQuantity;
//   Meta? meta;
//   List<String>? images;
//   String? thumbnail;
//
//   Products(
//       {this.id,
//         this.title,
//         this.description,
//         this.category,
//         this.price,
//         this.discountPercentage,
//         this.rating,
//         this.stock,
//         this.tags,
//         this.brand,
//         this.sku,
//         this.weight,
//         this.dimensions,
//         this.warrantyInformation,
//         this.shippingInformation,
//         this.availabilityStatus,
//         this.reviews,
//         this.returnPolicy,
//         this.minimumOrderQuantity,
//         this.meta,
//         this.images,
//         this.thumbnail});
//
//   Products.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     title = json['title'];
//     description = json['description'];
//     category = json['category'];
//     price = json['price'];
//     discountPercentage = json['discountPercentage'];
//     rating = json['rating'];
//     stock = json['stock'];
//     tags = json['tags'].cast<String>();
//     brand = json['brand'];
//     sku = json['sku'];
//     weight = json['weight'];
//     dimensions = json['dimensions'] != null
//         ? new Dimensions.fromJson(json['dimensions'])
//         : null;
//     warrantyInformation = json['warrantyInformation'];
//     shippingInformation = json['shippingInformation'];
//     availabilityStatus = json['availabilityStatus'];
//     if (json['reviews'] != null) {
//       reviews = <Reviews>[];
//       json['reviews'].forEach((v) {
//         reviews!.add(new Reviews.fromJson(v));
//       });
//     }
//     returnPolicy = json['returnPolicy'];
//     minimumOrderQuantity = json['minimumOrderQuantity'];
//     meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
//     images = json['images'].cast<String>();
//     thumbnail = json['thumbnail'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['title'] = this.title;
//     data['description'] = this.description;
//     data['category'] = this.category;
//     data['price'] = this.price;
//     data['discountPercentage'] = this.discountPercentage;
//     data['rating'] = this.rating;
//     data['stock'] = this.stock;
//     data['tags'] = this.tags;
//     data['brand'] = this.brand;
//     data['sku'] = this.sku;
//     data['weight'] = this.weight;
//     if (this.dimensions != null) {
//       data['dimensions'] = this.dimensions!.toJson();
//     }
//     data['warrantyInformation'] = this.warrantyInformation;
//     data['shippingInformation'] = this.shippingInformation;
//     data['availabilityStatus'] = this.availabilityStatus;
//     if (this.reviews != null) {
//       data['reviews'] = this.reviews!.map((v) => v.toJson()).toList();
//     }
//     data['returnPolicy'] = this.returnPolicy;
//     data['minimumOrderQuantity'] = this.minimumOrderQuantity;
//     if (this.meta != null) {
//       data['meta'] = this.meta!.toJson();
//     }
//     data['images'] = this.images;
//     data['thumbnail'] = this.thumbnail;
//     return data;
//   }
// }
//
// class Dimensions {
//   double? width;
//   double? height;
//   double? depth;
//
//   Dimensions({this.width, this.height, this.depth});
//
//   Dimensions.fromJson(Map<String, dynamic> json) {
//     width = json['width'];
//     height = json['height'];
//     depth = json['depth'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['width'] = this.width;
//     data['height'] = this.height;
//     data['depth'] = this.depth;
//     return data;
//   }
// }
//
// class Reviews {
//   int? rating;
//   String? comment;
//   String? date;
//   String? reviewerName;
//   String? reviewerEmail;
//
//   Reviews(
//       {this.rating,
//         this.comment,
//         this.date,
//         this.reviewerName,
//         this.reviewerEmail});
//
//   Reviews.fromJson(Map<String, dynamic> json) {
//     rating = json['rating'];
//     comment = json['comment'];
//     date = json['date'];
//     reviewerName = json['reviewerName'];
//     reviewerEmail = json['reviewerEmail'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['rating'] = this.rating;
//     data['comment'] = this.comment;
//     data['date'] = this.date;
//     data['reviewerName'] = this.reviewerName;
//     data['reviewerEmail'] = this.reviewerEmail;
//     return data;
//   }
// }
//
// class Meta {
//   String? createdAt;
//   String? updatedAt;
//   String? barcode;
//   String? qrCode;
//
//   Meta({this.createdAt, this.updatedAt, this.barcode, this.qrCode});
//
//   Meta.fromJson(Map<String, dynamic> json) {
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//     barcode = json['barcode'];
//     qrCode = json['qrCode'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['createdAt'] = this.createdAt;
//     data['updatedAt'] = this.updatedAt;
//     data['barcode'] = this.barcode;
//     data['qrCode'] = this.qrCode;
//     return data;
//   }
// }
