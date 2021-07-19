import 'package:admin/screens/main/cubit/mainpage_cubit.dart';
import 'package:admin/screens/orderPage/orderCubit/order_cubit.dart';
import 'package:admin/util/sizingInfo.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants.dart';

class ResumeOrderWidget extends StatelessWidget {
  ResumeOrderWidget() : super();

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(defaultPadding),
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ElevatedButton.icon(
                  label: Text('Volver'),
                  icon: Icon(Icons.arrow_back_ios_rounded),
                  onPressed: () =>
                      context.read<MainpageCubit>().changedPage('orders')),
              SizedBox(
                height: 16,
              ),
              Text(
                "Información - Orden",
                style: Theme.of(context).textTheme.headline5,
              ),
              SizedBox(
                height: 24,
              ),
              BlocBuilder<OrderCubit, OrderState>(
                builder: (context, state) {
                  return isMobile(context)
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Resumen - Orden",
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              "SubTotal: CRC ${state.subtotalShoppingCart().toStringAsFixed(2)} ",
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            Divider(),
                            SizedBox(
                              height: 2.0,
                            ),
                            Text(
                              "Impuestos: CRC ${state.impuestoShoppingCart().toStringAsFixed(2)} ",
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            Divider(),
                            SizedBox(
                              height: 2.0,
                            ),
                            Text(
                              "Total: CRC ${state.totalShoppingCart().toStringAsFixed(2)} ",
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Text(
                              "Información - Cliente",
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              "Nombre: ${state.preOrdenList[state.indexSelected].nombreCliente} ",
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            Divider(),
                            SizedBox(
                              height: 2.0,
                            ),
                            Text(
                              "Cédula: ${state.preOrdenList[state.indexSelected].cedula} ",
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            Divider(),
                            SizedBox(
                              height: 2.0,
                            ),
                            Text(
                              "${state.preOrdenList[state.indexSelected].notas} ",
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ],
                        )
                      : Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Resumen - Orden",
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  "SubTotal: CRC ${state.subtotalShoppingCart().toStringAsFixed(2)} ",
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                Divider(),
                                SizedBox(
                                  height: 2.0,
                                ),
                                Text(
                                  "Impuestos: CRC ${state.impuestoShoppingCart().toStringAsFixed(2)} ",
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                Divider(),
                                SizedBox(
                                  height: 2.0,
                                ),
                                Text(
                                  "Total: CRC ${state.totalShoppingCart().toStringAsFixed(2)} ",
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 50,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Información - Cliente",
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  "Nombre: ${state.preOrdenList[state.indexSelected].nombreCliente} ",
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                Divider(),
                                SizedBox(
                                  height: 2.0,
                                ),
                                Text(
                                  "Cédula: ${state.preOrdenList[state.indexSelected].cedula} ",
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                Divider(),
                                SizedBox(
                                  height: 2.0,
                                ),
                                Text(
                                  "${state.preOrdenList[state.indexSelected].notas} ",
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ],
                            ),
                          ],
                        );
                },
              ),
              SizedBox(
                height: 16,
              ),
              BlocBuilder<OrderCubit, OrderState>(
                builder: (context, state) {
                  return ButtonBar(
                    alignment: MainAxisAlignment.start,
                    children: [
                      ElevatedButton.icon(
                          style:
                              ElevatedButton.styleFrom(primary: Colors.green),
                          label: Text('Enviar a Qupos'),
                          icon: Icon(Icons.send),
                          onPressed: () => context
                              .read<OrderCubit>()
                              .sedOrderQuposServer(
                                  state.preOrdenList[state.indexSelected])),
                      ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(primary: Colors.red),
                          label: Text('Cancelar Orden'),
                          icon: Icon(Icons.cancel),
                          onPressed: () {
                            _showDialog(
                              context,
                              '¿Seguro que desea cancelar la orden de compra?',
                            );
                          })
                    ],
                  );
                },
              ),
            ]));
  }
}

var _txtCustomHead = TextStyle(
  color: Colors.white,
  fontSize: 23.0,
  fontWeight: FontWeight.w600,
  fontFamily: "Gotik",
);

/// Card Popup if success payment
_showDialog(BuildContext ctx, String message) {
  showDialog(
    barrierDismissible: false,
    context: ctx,
    builder: (context) => SimpleDialog(
      backgroundColor: bgColor,
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(top: 30.0, right: 60.0, left: 60.0),
            color: bgColor,
            child: Image.asset(
              "assets/images/error.png",
              height: 110.0,
              // color: Colors.transparent,
            )),
        Center(
            child: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: _txtCustomHead,
          ),
        )),
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0, right: 8.0, top: 10),
          child: Container(
            alignment: Alignment.bottomRight,
            child: ButtonBar(children: [
              MaterialButton(
                  color: primaryColor,
                  textColor: Colors.white,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('No')),
              MaterialButton(
                  color: primaryColor,
                  textColor: Colors.white,
                  onPressed: () {
                    ctx.read<OrderCubit>().cancelOrder();
                    ctx.read<OrderCubit>().deletePreorder();
                    ctx.read<MainpageCubit>().changedPage('orders');
                    Navigator.of(context).pop();
                  },
                  child: Text('Si'))
            ]),
          ),
        )
      ],
    ),
  );
}
