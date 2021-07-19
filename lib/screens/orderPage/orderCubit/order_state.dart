part of 'order_cubit.dart';

enum StatusLoad {
  pure,
  loading,
  loaded,
}

enum StatusSummit { pure, loading, summited, error }

class OrderState extends Equatable {
  const OrderState(
      {this.preOrdenList = const [],
      this.statusLoad = StatusLoad.pure,
      this.statusSummit = StatusSummit.pure,
      this.indexSelected = 0,
      this.message = ''});

  final List<PreOrder> preOrdenList;
  final StatusLoad statusLoad;
  final StatusSummit statusSummit;
  final int indexSelected;
  final String message;

  OrderState copyWith(
      {List<PreOrder>? preOrdenList,
      StatusLoad? statusLoad,
      StatusSummit? statusSummit,
      String? message,
      int? indexSelected}) {
    return OrderState(
        preOrdenList: preOrdenList ?? this.preOrdenList,
        statusSummit: statusSummit ?? this.statusSummit,
        message: message ?? this.message,
        indexSelected: indexSelected ?? this.indexSelected,
        statusLoad: statusLoad ?? this.statusLoad);
  }

  /*Este método calcula los impuestos de la compra, multiplicando el impusto * la canntidad 
de productos seleccionados, ademas de mantener el acumulado de los impuestos de todos los productos.
   @Params :  
   @Return : double*/
  double impuestoShoppingCart() {
    double impuestos = 0;
    final list = preOrdenList[indexSelected].detalles;
    if (list.isNotEmpty) {
      for (Product product in list) {
        impuestos = impuestos + (product.montoIva * product.cantidad);
      }
    }
    return impuestos;
  }

/*Este método calcula el subtotal de la compra, multiplicando el precio sin iva * la canntidad 
de productos seleccionados, ademas de mantener el acumulado de todos los productos.
   @Params :  
   @Return : double*/
  double subtotalShoppingCart() {
    double subTotal = 0;
    final list = preOrdenList[indexSelected].detalles;
    if (list.isNotEmpty) {
      for (Product product in list) {
        subTotal = subTotal +
            (product.precioSinIva * product.cantidad);
      }
    }
    return subTotal;
  }

/*Este método calcula el total de la compra, multiplicando el precio con el iva  * la canntidad 
de productos seleccionados, ademas de mantener el acumulado de todos los productos.
   @Params :  
   @Return : double*/
  double totalShoppingCart() {
    double total = 0;
    final list = preOrdenList[indexSelected].detalles;
    if (list.isNotEmpty) {
      for (Product product in list) {
        total = total + (product.precioIva * product.cantidad);
      }
    }
    return total;
  }

  @override
  List<Object> get props =>
      [preOrdenList, statusLoad, statusSummit, indexSelected, message];
}
