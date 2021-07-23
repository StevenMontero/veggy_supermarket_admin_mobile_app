class Product {
  late String codigoArticulo;

  late double cantidad;

  late String notas;

  late String envioParcial;

  late double precioSinIva;

  late double montoIva;

  late double porcentajeIva;

  late String codigoTarifa;

  late double precioIva;

  late double porcentajeDescuento;

  late double montoDescuento;

  late String bonificacion;

  late String codImpuesto;

  Product(
      {required this.codigoArticulo,
      required this.cantidad,
      required this.notas,
      required this.envioParcial,
      required this.precioSinIva,
      required this.montoIva,
      required this.porcentajeIva,
      required this.codigoTarifa,
      required this.precioIva,
      required this.porcentajeDescuento,
      required this.montoDescuento,
      required this.bonificacion,
      required this.codImpuesto});
  Product.fromJson(Map<String, dynamic> json) {
    this.codigoArticulo = json['codigo_articulo'];
    this.cantidad = json['cantidad'].toDouble();
    this.notas = json['notas'];
    this.envioParcial = json['envio_parcial'];
    this.precioSinIva = json['precio_sin_iva'].toDouble() ?? 0;
    this.montoIva = json['monto_iva'] > 0 ? json['monto_iva'] : 0.0;
    this.porcentajeIva = json['porcentaje_iva'].toDouble() ?? 0.0;
    this.codigoTarifa = json['codigo_tarifa'];
    this.precioIva = json['monto_iva'] > 0 ? json['precio_iva'] : 0.0;
    this.porcentajeDescuento = json['porcentaje_descuento'].toDouble() ?? 0.0;
    this.montoDescuento = json['monto_descuento'].toDouble() ?? 0.0;
    this.bonificacion = json['bonificacion'];
    this.codImpuesto = json['cod_impuesto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['codigo_articulo'] = this.codigoArticulo.toString();
    data['cantidad'] = this.cantidad;
    data['notas'] = this.notas.toString();
    data['envio_parcial'] = this.envioParcial.toString();
    data['precio_sin_iva'] = this.precioSinIva;
    data['monto_iva'] = this.montoIva.toString();
    data['porcentaje_iva'] = this.porcentajeIva;
    data['codigo_tarifa'] = this.codigoTarifa.toString();
    data['precio_iva'] = this.precioIva;
    data['porcentaje_descuento'] = this.porcentajeDescuento;
    data['monto_descuento'] = this.montoDescuento;
    data['bonificacion'] = this.bonificacion.toString();
    data['cod_impuesto'] = this.codImpuesto.toString();
    return data;
  }

  void addQuantity(double cantidad) {
    if (this.cantidad == 0) {
      this.cantidad = cantidad;
    } else {
      double total =
          cantidad <= 0 ? this.cantidad + 1 : cantidad + this.cantidad;
      this.cantidad = total;
    }
  }
}
