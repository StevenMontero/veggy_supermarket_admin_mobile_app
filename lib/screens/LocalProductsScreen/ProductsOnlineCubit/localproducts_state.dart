part of 'localproducts_cubit.dart';

enum StatusLocal { pure, loading, loaded, error }
enum StatusUpdateLocal { pure, loading, updated, error }

class LocalproductsState extends Equatable {
  LocalproductsState(
      {this.categorySelected = '',
      this.listProduct = const [],
      this.listProductRaw = const [],
      this.codeProduc = '',
      this.lastIndex = 0,
      this.previousIndex = 0,
      this.advancedQuantity = 0,
      this.statusUpdate = StatusUpdateLocal.pure,
      this.listProductSearch = const [],
      this.status = StatusLocal.pure});

  final List<ProductApi> listProduct;
  final List<ProductApi> listProductSearch;
  final List<dynamic> listProductRaw;
  final String codeProduc;
  final StatusLocal status;
  final String categorySelected;
  final StatusUpdateLocal statusUpdate;
  final int lastIndex;
  final int previousIndex;
  final int advancedQuantity;

  LocalproductsState copyWhith(
      {List<ProductApi>? listProduct,
      String? codeProduc,
      StatusLocal? status,
      StatusUpdateLocal? statusUpdate,
      List<ProductApi>? listProductSearch,
      List<dynamic>? listProductRaw,
      int? lastIndex,
      int? previousIndex,
      int? advancedQuantity,
      String? categorySelected}) {
    return LocalproductsState(
        listProduct: listProduct ?? this.listProduct,
        codeProduc: codeProduc ?? this.codeProduc,
        categorySelected: categorySelected ?? this.categorySelected,
        listProductSearch: listProductSearch ?? this.listProductSearch,
        listProductRaw: listProductRaw ?? this.listProductRaw,
        statusUpdate: statusUpdate ?? this.statusUpdate,
        lastIndex: lastIndex ?? this.lastIndex,
        previousIndex: previousIndex ?? this.previousIndex,
        advancedQuantity: advancedQuantity ?? this.advancedQuantity,
        status: status ?? this.status);
  }

  @override
  List<Object> get props => [
        listProduct,
        codeProduc,
        status,
        categorySelected,
        listProductSearch,
        listProductRaw,
        lastIndex,
        previousIndex,
        statusUpdate
      ];
}
