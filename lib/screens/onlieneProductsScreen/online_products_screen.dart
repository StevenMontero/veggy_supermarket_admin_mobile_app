
import 'package:admin/screens/widgets/header.dart';

import 'package:admin/screens/onlieneProductsScreen/ProductsOnlineCubit/onlineproducts_cubit.dart';
import 'package:admin/screens/onlieneProductsScreen/components/filter_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants.dart';

import 'components/table_products.dart';


class ProdectsOnlineScreen extends StatelessWidget {
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
                    FilterWidget(),
                    SizedBox(height: defaultPadding),
                    ProdectsTableWidget(),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
