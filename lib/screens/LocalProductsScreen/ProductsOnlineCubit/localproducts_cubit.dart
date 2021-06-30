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

  void loadProduct() async {
    emit(state.copyWhith(status: StatusLocal.loading));
    final products = await _repoLocal.getProductsQupos();
    emit(state.copyWhith(
      status: StatusLocal.loaded,
      listProduct: products,
    ));
  }

  void searchCodeProduct(String code) async {
    emit(state.copyWhith(status: StatusLocal.loading));
    final products =
        List<ProductApi>.from(state.listProduct.where((x) => x.code == code));
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
}
