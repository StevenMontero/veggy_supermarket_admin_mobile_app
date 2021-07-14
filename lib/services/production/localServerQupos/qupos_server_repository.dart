import 'dart:convert';

import 'package:admin/models/product_api.dart';
import 'package:dio/dio.dart';

class QuposRepository {
  final dioClient = Dio();

  Future<List<ProductApi>> getProductsQupos() async {
    // final response = await dioClient.get('201.207.180.249:45570/api/Articulos');
    final response = await dioClient
        .get('http://186.177.135.3:45570/api/Articulos?active=1');

    if (response.statusCode == 200) {
      return response.data
          .map<ProductApi>((data) => ProductApi.fromJson(data))
          .toList();
    }
    return [];
  }

  Future<List<dynamic>> getProductsQuposRaw() async {
    // final response = await dioClient.get('201.207.180.249:45570/api/Articulos');
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('pruebas:123456'));

    final response =
        await dioClient.get('http://186.177.135.3:45570/api/Articulos?active=1',
            options: Options(headers: {
              'authorization': basicAuth,
            }));

    if (response.statusCode == 200) {
      return response.data;
    }
    return [];
  }
}
