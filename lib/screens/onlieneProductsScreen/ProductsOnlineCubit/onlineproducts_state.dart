part of 'onlineproducts_cubit.dart';

enum Status { pure, loading, loaded, error }
enum StatusUpdate { pure, loading, updated, error }

class OnlineproductsState extends Equatable {
  OnlineproductsState(
      {this.categorySelected = '',
      this.listProduct = const [],
      this.codeProduc = '',
      this.statusUpdate = StatusUpdate.pure,
      this.listProductSearch = const [],
      this.status = Status.pure});

  final List<ProductApi> listProduct;
  final List<ProductApi> listProductSearch;
  final String codeProduc;
  final Status status;
  final String categorySelected;
  final StatusUpdate statusUpdate;

  OnlineproductsState copyWhith(
      {List<ProductApi>? listProduct,
      String? codeProduc,
      Status? status,
      StatusUpdate? statusUpdate,
      List<ProductApi>? listProductSearch,
      String? categorySelected}) {
    return OnlineproductsState(
        listProduct: listProduct ?? this.listProduct,
        codeProduc: codeProduc ?? this.codeProduc,
        categorySelected: categorySelected ?? this.categorySelected,
        listProductSearch: listProductSearch ?? this.listProductSearch,
        statusUpdate: statusUpdate ?? this.statusUpdate,
        status: status ?? this.status);
  }

  @override
  List<Object> get props => [
        listProduct,
        codeProduc,
        status,
        categorySelected,
        listProductSearch,
        statusUpdate
      ];
}
