import 'package:admin/screens/onlieneProductsScreen/ProductsOnlineCubit/onlineproducts_cubit.dart';
import 'package:admin/util/categories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants.dart';

class FilterWidget extends StatelessWidget {
  FilterWidget() : super();

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
            "Filtros - Productos Online",
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            "Categorías",
            style: Theme.of(context).textTheme.bodyText2,
          ),
          SizedBox(
            height: 5.0,
          ),
          BlocBuilder<OnlineproductsCubit, OnlineproductsState>(
            buildWhen: (previous, current) =>
                current.categorySelected != previous.categorySelected,
            builder: (context, state) {
              return DropdownButton<String>(
                  value: state.categorySelected != ''
                      ? state.categorySelected
                      : null,
                  isExpanded: true,
                  hint: Text('Categorías'),
                  items: List<DropdownMenuItem<String>>.generate(
                      categiries.length,
                      (index) => DropdownMenuItem<String>(
                            value: categiries[index],
                            child: Text(categiries[index]),
                          )),
                  onChanged: (value) {
                    context
                        .read<OnlineproductsCubit>()
                        .loadProduct(value ?? '');
                  });
            },
          ),
          SizedBox(
            height: 16,
          ),
          BlocBuilder<OnlineproductsCubit, OnlineproductsState>(
            builder: (context, state) {
              return state.listProduct.isNotEmpty
                  ? TextFormField(
                      onChanged: (value) => context
                          .read<OnlineproductsCubit>()
                          .searchCodeProduct(value),
                      decoration: InputDecoration(
                        icon: Icon(Icons.qr_code_rounded),
                        labelText: 'Código del producto',
                        labelStyle: TextStyle(
                          color: Colors.green,
                        ),
                        hintText: 'Buscar por código',
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
