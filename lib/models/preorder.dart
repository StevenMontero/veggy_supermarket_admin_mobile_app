import 'package:admin/models/product.dart';

class PreOrder {
  late String codigoCliente;
  late String ordenCompra;
  late DateTime fechaHora;
  late String notas;
  late String cedula;
  late String tipoCedula;
  late String email;
  late String nombreCliente;
  late int cargoEnvio;
  late String bodega;
  late List<Product> detalles;

  PreOrder(
      {required this.codigoCliente,
      required this.ordenCompra,
      required this.fechaHora,
      required this.notas,
      required this.cedula,
      required this.tipoCedula,
      required this.email,
      required this.nombreCliente,
      required this.cargoEnvio,
      required this.bodega,
      required this.detalles});

  PreOrder.fromJson(Map<String, dynamic> json) {
    this.codigoCliente = json['codigo_cliente'];
    this.ordenCompra = json['orden_compra'];
    this.fechaHora = DateTime.parse(json['fecha_hora']);
    this.notas = json['notas'];
    this.cedula = json['cedula'];
    this.tipoCedula = json['tipo_cedula'];
    this.email = json['email'];
    this.nombreCliente = json['nombre_cliente'];
    this.cargoEnvio = json['cargo_envio'];
    this.bodega = json['bodega'];
    this.detalles = List<Product>.from(
        json['detalles'].map((product) => Product.fromJson(product)));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['codigo_cliente'] = this.codigoCliente;
    data['orden_compra'] = this.ordenCompra;
    data['fecha_hora'] = this.fechaHora.toString();
    data['notas'] = this.notas;
    data['cedula'] = this.cedula;
    data['tipo_cedula'] = this.tipoCedula;
    data['email'] = this.email;
    data['nombre_cliente'] = this.nombreCliente;
    data['cargo_envio'] = this.cargoEnvio;
    data['bodega'] = this.bodega;
    data['detalles'] = this.detalles.map((v) => v.toJson()).toList();
    return data;
  }
}
