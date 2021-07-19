import 'dart:convert';
import 'package:admin/models/preorder.dart';
import 'package:dio/dio.dart';

class QuposOrderRepository {
  final dioClient = Dio();

  Future<Map<String, dynamic>> postPreventa(PreOrder preOrder) async {
    print(jsonEncode(preOrder.toJson()));
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('PROYECTO:12345'));

    try {
      final response =
          await dioClient.post('http://186.177.135.3:45570/api/Preventas',
              data: jsonEncode(preOrder.toJson()),
              options: Options(headers: {
                'authorization': basicAuth,
                "Access-Control-Allow-Origin": "*",
                "Content-Type": "application/json",
                "Access-Control-Allow-Headers":
                    "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
                "Access-Control-Allow-Methods": "POST, OPTIONS",
                'Accept': "*/*",
              }));
      return {
        'exito': response.data[0]["exito"],
        "numero_pedido": response.data[0]["numero_pedido_generado"],
        "mensajes": response.data[0]["mensajes"],
      };
    } on DioError catch (e) {
      return {
        'exito': false,
        "numero_pedido": '-1',
        "mensajes": e.message,
      };
    }
  }
}
