part of 'localproducts_cubit.dart';

enum StatusLocal { pure, loading, loaded, error }
enum StatusUpdateLocal { pure, loading, updated, error }

class LocalproductsState extends Equatable {
  LocalproductsState(
      {this.categorySelected = '',
      this.listProduct = const [],
      this.codeProduc = '',
      this.statusUpdate = StatusUpdateLocal.pure,
      this.listProductSearch = const [],
      this.status = StatusLocal.pure});

  final List<ProductApi> listProduct;
  final List<ProductApi> listProductSearch;
  final String codeProduc;
  final StatusLocal status;
  final String categorySelected;
  final StatusUpdateLocal statusUpdate;

  LocalproductsState copyWhith(
      {List<ProductApi>? listProduct,
      String? codeProduc,
      StatusLocal? status,
      StatusUpdateLocal? statusUpdate,
      List<ProductApi>? listProductSearch,
      String? categorySelected}) {
    return LocalproductsState(
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
