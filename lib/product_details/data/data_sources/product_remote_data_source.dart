import 'package:flutter/material.dart';
import 'package:web_scraping_task/core/errors/failures.dart';
import 'package:web_scraping_task/product_details/data/models/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;

abstract class ProductRemoteDataSource {
  Future<ProductModel> getProduct();

  Future<ProductPriceList> getAmazonPrice();

  Future<ProductPriceList> getJumiaPrice();

  Future<ProductPriceList> getDpPrice();
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final http.Client client;

  ProductRemoteDataSourceImpl({required this.client});
//get product details from dubai phones
  @override
  Future<ProductModel> getProduct() async {
    final response = await http.Client().get(Uri.parse(
        'https://www.dubaiphone.net/en/shop/apple-airpods-pro-2-3606#attr=10545,10609,10608,10546,10610'));
    if (response.statusCode == 200) {
      var document = parser.parse(response.body);
      try {
        var responseTitle =
            document.getElementsByClassName('col-md-6 col-xl-4')[0].children[0];
        debugPrint(responseTitle.text.trim());
        var responseImage = document
            .getElementsByClassName(
                'd-flex align-items-center justify-content-center h-100')[0]
            .children[0]
            .attributes
            .values
            .first
            .toString();
        debugPrint(responseImage.trim());
        return ProductModel(
          productTitle: responseTitle.text.trim(),
          productImage: 'https://www.dubaiphone.net${responseImage.trim()}',
        );
      } catch (e) {
        throw ServerFailure();
      }
    } else {
      throw ServerFailure();
    }
  }
//get amazon price
  @override
  Future<ProductPriceList> getAmazonPrice() async {
    final response = await http.Client().get(Uri.parse(
      'https://www.amazon.eg/dp/B0BDK4GJXC',
    ));
    if (response.statusCode == 200) {
      var document = parser.parse(response.body);
      // debugPrint(document.getElementById('availability')?.text.trim());
      try {
        var responsePrice =  document
            .getElementsByTagName('span.a-price-whole')[0]
            .text.trim().replaceAll(',', '').replaceAll('.', '')
            .trim();

        debugPrint(responsePrice.substring(0, responsePrice.length - 1));

        var responseStock =
            document.getElementById('availability')?.text.trim();
        debugPrint(document.getElementById('availability')?.text.trim());

        var responseImage =
            'https://press.aboutamazon.com/system/files-encrypted/nasdaq_kms/inline-images/Amazon-logo.jpg';
        debugPrint(responseImage.trim());
        return ProductPriceList(
          companyName: 'Amazon EG',
          companyImage: responseImage.trim(),
          companyPrice: double.parse(responsePrice.substring(0, responsePrice.length - 1)),
          companyStock: responseStock != null && responseStock.contains('اطلبه الآن') ? true : false,
        );
      } catch (e) {
        print(e.toString());
        throw ServerFailure();
      }
    } else {
      throw ServerFailure();
    }
  }
//get jumia price
  @override
  Future<ProductPriceList> getJumiaPrice() async {
    final response = await http.Client().get(Uri.parse(
      'https://www.jumia.com.eg/apple-airpods-pro-2nd-generation-white-31064038.html',
    ));
    if (response.statusCode == 200) {
      var document = parser.parse(response.body);
      debugPrint(document
          .getElementsByTagName('p.-df.-i-ctr.-fs12.-pbs.-rd5')[0]
          .text);
      try {
        var responsePrice = document
            .getElementsByTagName('span.-b.-ltr.-tal.-fs24')[0]
            .text
            .trim()
            .replaceAll(',', '')
            .replaceAll('EGP ', '')
            .replaceAll('.00', '')
            .trim();
        debugPrint(responsePrice);

        var responseStock = document
            .getElementsByTagName('p.-df.-i-ctr.-fs12.-pbs.-rd5')[0]
            .text;
        var responseImage =
            'https://1000logos.net/wp-content/uploads/2022/02/Jumia-Logo.png';
        debugPrint(responseImage.trim());
        return ProductPriceList(
          companyName: 'Jumia EG',
          companyImage: responseImage.trim(),
          companyPrice: double.parse(responsePrice),
          companyStock: responseStock.contains('left') ? true : false,
        );
      } catch (e) {
        throw ServerFailure();
      }
    } else {
      throw ServerFailure();
    }
  }
//get dubai phones price
  @override
  Future<ProductPriceList> getDpPrice() async {
    final response = await http.Client().get(Uri.parse(
        'https://www.dubaiphone.net/en/shop/apple-airpods-pro-2-3606#attr=10545,10609,10608,10546,10610'));
    if (response.statusCode == 200) {
      var document = parser.parse(response.body);
      try {
        var responsePrice = document
            .getElementsByClassName('oe_price_h4 css_editable_mode_hidden')[0]
            .children[1]
            .text
            .trim()
            .replaceAll(',', '')
            .replaceAll('EGP', '')
            .replaceAll('.00', '')
            .trim();
        debugPrint(responsePrice);

        var responseStock = 'in stock';
        var responseImage = document
            .getElementsByTagName('img.img.img-fluid')[0]
            .attributes
            .values
            .first;
        debugPrint(responseImage.trim());
        return ProductPriceList(
          companyName: 'Dubai Phone',
          companyImage: 'https://www.dubaiphone.net${responseImage.trim()}',
          companyPrice: double.parse(responsePrice),
          companyStock:
              responseStock.toUpperCase() == 'IN STOCK' ? true : false,
        );
      } catch (e) {
        throw ServerFailure();
      }
    } else {
      throw ServerFailure();
    }
  }
}
