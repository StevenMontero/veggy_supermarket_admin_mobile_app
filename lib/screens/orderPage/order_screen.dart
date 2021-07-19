import 'package:admin/screens/main/cubit/mainpage_cubit.dart';
import 'package:admin/screens/orderPage/orderCubit/order_cubit.dart';
import 'package:admin/screens/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants.dart';

class OrdersOnlineScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<OrderCubit>()..loadListOrder();
    return SafeArea(
      child: Body(),
    );
  }
}

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Header(),
      SizedBox(height: defaultPadding),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ElevatedButton.icon(
            label: Text('Refrescar'),
            icon: Icon(Icons.refresh),
            onPressed: () => context.read<OrderCubit>().loadListOrder()),
      ),
      SizedBox(height: defaultPadding),
      BlocBuilder<OrderCubit, OrderState>(
        builder: (context, state) {
          return state.statusLoad == StatusLoad.loading
              ? Center(child: CircularProgressIndicator())
              : Expanded(
                  child: state.preOrdenList.isEmpty
                      ? Center(
                          child: Text('No hay órdenes de compra'),
                        )
                      : ListView.builder(
                          itemCount: state.preOrdenList.length,
                          itemBuilder: (context, index) {
                            final fecha = state
                                    .preOrdenList[index].fechaHora.day
                                    .toString() +
                                '/' +
                                state.preOrdenList[index].fechaHora.month
                                    .toString() +
                                '/' +
                                state.preOrdenList[index].fechaHora.year
                                    .toString();
                            return Column(
                              children: [
                                Container(
                                  color: secondaryColor,
                                  child: ListTile(
                                    onTap: () {
                                      context
                                          .read<OrderCubit>()
                                          .indexSlectedChanged(index);
                                      context
                                          .read<MainpageCubit>()
                                          .changedPage('ordersDetail');
                                    },
                                    trailing: IconButton(
                                      icon:
                                          Icon(Icons.arrow_forward_ios_rounded),
                                      onPressed: () {
                                        context
                                            .read<OrderCubit>()
                                            .indexSlectedChanged(index);
                                        context
                                            .read<MainpageCubit>()
                                            .changedPage('ordersDetail');
                                      },
                                    ),
                                    leading: Icon(
                                        Icons.notifications_active_rounded),
                                    title: Text('OrdenCompra: ' +
                                        state.preOrdenList[index].ordenCompra),
                                    subtitle: Text(
                                      state.preOrdenList[index].nombreCliente +
                                          ' - ' +
                                          fecha,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                Divider(
                                  height: 10,
                                ),
                              ],
                            );
                          },
                        ));
        },
      ),
    ]);
  }
}
