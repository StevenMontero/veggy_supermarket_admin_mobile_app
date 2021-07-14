
import 'package:admin/screens/LocalProductsScreen/ProductsOnlineCubit/localproducts_cubit.dart';
import 'package:admin/screens/LocalProductsScreen/components/filterlocal_widget.dart';
import 'package:admin/screens/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constants.dart';

import 'components/table_productslocal.dart';


class ProdectsLocalScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => LocalproductsCubit()..loadInitialProduct(),
        child: Body(),
      ),
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
                    FilterWidgetLocal(),
                    SizedBox(height: defaultPadding),
                    ProdectsTableWidgetLocal(),
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
