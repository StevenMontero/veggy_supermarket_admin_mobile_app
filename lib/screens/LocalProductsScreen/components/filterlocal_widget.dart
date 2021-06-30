import 'package:admin/screens/LocalProductsScreen/ProductsOnlineCubit/localproducts_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants.dart';

class FilterWidgetLocal extends StatelessWidget {
  FilterWidgetLocal() : super();

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(defaultPadding),
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "Filtros",
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            "Productos en el Sistema Qupos",
            style: Theme.of(context).textTheme.bodyText2,
          ),
          SizedBox(
            height: 5.0,
          ),
         
         
          BlocBuilder<LocalproductsCubit, LocalproductsState>(
            builder: (context, state) {
              return state.listProduct.isNotEmpty
                  ? TextFormField(
                      onChanged: (value) => context
                          .read<LocalproductsCubit>()
                          .searchCodeProduct(value),
                      decoration: InputDecoration(
                        icon: Icon(Icons.qr_code_rounded),
                        labelText: 'Codigo del producto',
                        labelStyle: TextStyle(
                          color: Colors.green,
                        ),
                        hintText: 'Buscar por codigo',
                        suffixIcon: Icon(
                          Icons.check_circle,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                        ),
                      ),
                    )
                  : Container();
            },
          ),
        ]));
  }
}
