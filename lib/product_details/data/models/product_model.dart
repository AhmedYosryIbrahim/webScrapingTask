// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

import 'package:web_scraping_task/product_details/domain/entities/product.dart';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel extends Product {
  ProductModel({
    required this.productImage,
    required this.productTitle,
  }) : super(
          image: productImage,
          title: productTitle,
        );

  String productImage;
  String productTitle;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        productImage: json["productImage"],
        productTitle: json["productTitle"],

      );

  Map<String, dynamic> toJson() => {
        "productImage": productImage,
        "productTitle": productTitle,

      };
}

class ProductPriceList extends Price {
  ProductPriceList({
    required this.companyImage,
    required this.companyName,
    required this.companyPrice,
    required this.companyStock,
  }) : super(
          image: companyImage,
          name: companyName,
          price: companyPrice,
          stock: companyStock,
        );

  String companyImage;
  String companyName;
  double companyPrice;
  bool companyStock;

  factory ProductPriceList.fromJson(Map<String, dynamic> json) =>
      ProductPriceList(
        companyImage: json["companyImage"],
        companyName: json["companyName"],
        companyPrice: json["companyPrice"],
        companyStock: json["companyStock"],
      );

  Map<String, dynamic> toJson() => {
        "companyImage": companyImage,
        "companyName": companyName,
        "companyPrice": companyPrice,
        "companyStock": companyStock,
      };
}
