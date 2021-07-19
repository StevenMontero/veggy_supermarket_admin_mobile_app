import 'package:admin/models/preorder.dart';
import 'package:admin/models/product.dart';
import 'package:admin/services/production/localServerQupos/qupos_server_order_repository.dart';
import 'package:admin/services/production/repositories/order_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderState());

  final _orderRepo = OrderFirebaseRepository();

  void loadListOrder() async {
    emit(state.copyWith(statusLoad: StatusLoad.loading));
    final _listOrder = await _orderRepo.getOrdenes();
    emit(state.copyWith(
        preOrdenList: _listOrder, statusLoad: StatusLoad.loaded));
  }

  void cancelOrder() {
    _orderRepo.deleteOrder(state.preOrdenList[state.indexSelected]);
  }

  void indexSlectedChanged(int index) async {
    emit(state.copyWith(indexSelected: index));
  }

  void deletePreorder() {
    final listUpdate = List<PreOrder>.from(state.preOrdenList)
      ..removeAt(state.indexSelected);
    emit(state.copyWith(preOrdenList: listUpdate));
  }

  void sedOrderQuposServer(PreOrder preOrder) async {
    emit(state.copyWith(statusSummit: StatusSummit.loading));
    final _quposServerLocal = QuposOrderRepository();
    final responce = await _quposServerLocal.postPreventa(preOrder);
    if (responce['exito']) {
      _orderRepo.deleteOrder(preOrder);

      emit(state.copyWith(
          statusSummit: StatusSummit.summited,
          message: 'NumeroPedido: ${responce['numero_pedido']}'));
    } else {
      emit(state.copyWith(
          statusSummit: StatusSummit.error, message: responce['mensajes']));
    }
  }
}
