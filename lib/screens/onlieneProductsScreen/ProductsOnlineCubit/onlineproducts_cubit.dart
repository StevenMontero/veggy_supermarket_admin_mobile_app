import 'package:admin/models/product_api.dart';
import 'package:admin/services/production/repositories/product_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'onlineproducts_state.dart';

class OnlineproductsCubit extends Cubit<OnlineproductsState> {
  OnlineproductsCubit() : super(OnlineproductsState());
  final _repo = ProductRepository();

  void loadProduct(String category) async {
    emit(state.copyWhith(status: Status.loading));
    final products = await _repo.getProductsByCategory(category);
    emit(state.copyWhith(
        status: Status.loaded,
        listProduct: products,
        categorySelected: category));
  }

  void searchCodeProduct(String code) async {
    emit(state.copyWhith(status: Status.loading));
    final products =
        List<ProductApi>.from(state.listProduct.where((x) => x.code == code));
    if (products.isNotEmpty) {
      emit(state.copyWhith(status: Status.loaded, listProductSearch: products));
    } else {
      emit(state.copyWhith(status: Status.loaded, listProductSearch: []));
    }
  }

  void stateusCahenged(
      {required String category,
      required int active,
      required int indexInList,
      required bool isSearchByCode,
      required String id}) async {
    emit(state.copyWhith(statusUpdate: StatusUpdate.loading));
    final products = List<ProductApi>.from(state.listProduct);

    final isUpdated =
        await _repo.updateStateProductsByCategory(category, id, active);

    if (isUpdated) {
      if (isSearchByCode) {
        final productsSearchList =
            List<ProductApi>.from(state.listProductSearch);
        productsSearchList[indexInList].active = active;
        final auxIndex = products.indexWhere((element) => element.code == id);
        products[auxIndex].active = active;
      } else {
        products[indexInList].active = active;
      }

      emit(state.copyWhith(
          statusUpdate: StatusUpdate.updated, listProduct: products));
    }
  }
}
