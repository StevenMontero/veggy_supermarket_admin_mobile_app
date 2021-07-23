import 'dart:convert';

import 'package:admin/models/product_api.dart';
import 'package:dio/dio.dart';

class QuposRepository {
  final dioClient = Dio();
  String _basicAuth = 'Basic ' + base64Encode(utf8.encode('PROYECTO:12345'));
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
   

    final response =
        await dioClient.get('http://186.177.135.3:45570/api/Articulos?active=1',
            options: Options(headers: {
              'authorization': _basicAuth,
            }));

    if (response.statusCode == 200) {
      return response.data;
    }
    return [];
  }

  Future<Map<String, dynamic>> imageFromBase64String(String code) async {
    try {
      final response = await dioClient.get(
          'http://186.177.135.3:45570/api/Articulos/ImagenBase64?code=$code',
          options: Options(headers: {
            'authorization': _basicAuth,
            'Accept': "*/*",
          }));
      if (response.statusCode == 200) {
        return {
          'exito': true,
          'image': base64Decode(response.data),
        };
      }
      return {
        'exito': false,
        'image': '',
      };
    } on DioError catch (e) {
      return {
        'exito': false,
        'image': '',
      };
    }
  }
}
