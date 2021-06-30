

import 'package:admin/models/product_api.dart';
import 'package:dio/dio.dart';

class QuposRepository {
  final dioClient = Dio();

  Future<List<ProductApi>> getProductsQupos() async {
    // final response = await dioClient.get('201.207.180.249:45570/api/Articulos');
    final response = await dioClient
        .get('https://60db9bd8801dcb001729124f.mockapi.io/veggy/Articulos');

    if (response.statusCode == 200) {
      return response.data.map<ProductApi>((data)=> ProductApi.fromJson(data)).toList();
    }
    return [];
  }
}
