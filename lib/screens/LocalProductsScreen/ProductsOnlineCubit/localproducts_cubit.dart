import 'package:admin/models/product_api.dart';
import 'package:admin/services/production/localServerQupos/qupos_server_repository.dart';
import 'package:admin/services/production/repositories/product_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'localproducts_state.dart';

class LocalproductsCubit extends Cubit<LocalproductsState> {
  LocalproductsCubit() : super(LocalproductsState());
  final _repo = ProductRepository();
  final _repoLocal = QuposRepository();

  void loadInitialProduct() async {
    emit(state.copyWhith(status: StatusLocal.loading));
    final productsRawData = await _repoLocal.getProductsQuposRaw();
    emit(state.copyWhith(listProductRaw: productsRawData));
    final productsAPI = _listProductPaginatated(state.lastIndex,
        productsRawData.length >= 10 ? 10 : productsRawData.length);
    emit(state.copyWhith(
        status: StatusLocal.loaded,
        listProductRaw: productsRawData,
        lastIndex: productsAPI.length,
        listProduct: productsAPI));
  }

  void get10MoreProducts() async {
    emit(state.copyWhith(status: StatusLocal.loading));
    final leghtRawData = state.listProductRaw.length;
    List<ProductApi> products = [];
    if (leghtRawData > state.lastIndex) {
      int auxSubtract = state.listProductRaw.length - state.lastIndex;
      if (auxSubtract >= 10) {
        products =
            _listProductPaginatated(state.lastIndex, state.lastIndex + 10);
      } else {
        products = _listProductPaginatated(state.lastIndex, auxSubtract);
      }
    }
    final auxJoinList = state.listProduct + products;

    emit(state.copyWhith(
      status: StatusLocal.loaded,
      listProduct: auxJoinList,
      lastIndex: auxJoinList.length,
    ));
  }

  void searchCodeProduct(String code) async {
    emit(state.copyWhith(status: StatusLocal.loading));
    final product =
        state.listProductRaw.where((x) => x['code'] == code).toList();
    List<ProductApi> products = [];
    if (product.isNotEmpty) {
      products = product.map((e) => ProductApi.fromJson(e)).toList();
    }

    if (products.isNotEmpty) {
      emit(state.copyWhith(
          status: StatusLocal.loaded, listProductSearch: products));
    } else {
      emit(state.copyWhith(status: StatusLocal.loaded, listProductSearch: []));
    }
  }

  void addProduct(
      {required String category, required ProductApi product}) async {
    emit(state.copyWhith(statusUpdate: StatusUpdateLocal.loading));
    await _repo.addProduct(category, product);
    emit(state.copyWhith(statusUpdate: StatusUpdateLocal.updated));
  }

  List<ProductApi> _listProductPaginatated(int lastIndex, int endIndex) {
    List<ProductApi> list = [];
    for (int i = lastIndex; i < endIndex; i++) {
      list.add(ProductApi.fromJson(state.listProductRaw[i]));
    }
    return list;
  }
}
