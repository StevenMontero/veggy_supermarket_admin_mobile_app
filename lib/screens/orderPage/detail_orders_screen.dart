import 'package:admin/screens/main/cubit/mainpage_cubit.dart';
import 'package:admin/screens/orderPage/orderCubit/order_cubit.dart';
import 'package:admin/screens/widgets/header.dart';

import 'package:admin/screens/onlieneProductsScreen/ProductsOnlineCubit/onlineproducts_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants.dart';

import 'components/filter_widget.dart';
import 'components/table_products.dart';

class OrdersDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnlineproductsCubit(),
      child: SafeArea(child: Body()),
    );
  }
}

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(defaultPadding),
      child: BlocListener<OrderCubit, OrderState>(
        listenWhen: (previous, current) =>
            previous.statusSummit != current.statusSummit,
        listener: (context, state) {
          if (state.statusSummit == StatusSummit.summited) {
            _showDialog(
                context, '¡Orden enviada al sistema!\n${state.message}', false);
          } else if (state.statusSummit == StatusSummit.error) {
            _showDialog(context, '¡Ocurrió un error!\n${state.message}', true);
          }
        },
        child: Column(
          children: [
            Header(),
            SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      ResumeOrderWidget(),
                      SizedBox(height: defaultPadding),
                      OrderTableWidget(),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

var _txtCustomHead = TextStyle(
  color: Colors.white,
  fontSize: 23.0,
  fontWeight: FontWeight.w600,
  fontFamily: "Gotik",
);

/// Card Popup if success payment
_showDialog(BuildContext ctx, String message, bool error) {
  showDialog(
    barrierDismissible: false,
    context: ctx,
    builder: (context) => SimpleDialog(
      backgroundColor: bgColor,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 30.0, right: 60.0, left: 60.0),
          color: bgColor,
          child: error
              ? Image.asset(
                  "assets/images/error.png",
                  height: 110.0,
                  // color: Colors.transparent,
                )
              : Image.asset(
                  "assets/images/checklist.png",
                  height: 110.0,
                  color: Colors.lightGreen,
                ),
        ),
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
            child: MaterialButton(
                color: primaryColor,
                textColor: Colors.white,
                onPressed: () {
                  if (error) {
                    Navigator.of(context).pop();
                  } else {
                    ctx.read<OrderCubit>().deletePreorder();
                    ctx.read<MainpageCubit>().changedPage('orders');
                    Navigator.of(context).pop();
                  }
                },
                child: Text('Listo')),
          ),
        )
      ],
    ),
  );
}
