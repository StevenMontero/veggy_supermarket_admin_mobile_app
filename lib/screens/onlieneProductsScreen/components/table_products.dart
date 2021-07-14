import 'package:admin/models/product_api.dart';
import 'package:admin/screens/onlieneProductsScreen/ProductsOnlineCubit/onlineproducts_cubit.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants.dart';

class ProdectsTableWidget extends StatelessWidget {
  ProdectsTableWidget({
    Key? key,
  }) : super(key: key);
  final ScrollController _controller =
      ScrollController(initialScrollOffset: 0.0);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Productos",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(
            height: 500,
            width: double.infinity,
            child: Scrollbar(
              isAlwaysShown: true,
              controller: _controller,
              child: BlocBuilder<OnlineproductsCubit, OnlineproductsState>(
                builder: (context, state) {
                  if (state.listProduct.isNotEmpty) {
                    return DataTable2(
                        scrollController: _controller,
                        columnSpacing: defaultPadding,
                        minWidth: 600,
                        columns: [
                          DataColumn(
                            label: Text(""),
                          ),
                          DataColumn(
                            label: Text("Nombre Producto"),
                          ),
                          DataColumn(
                            label: Text("Código"),
                          ),
                        ],
                        rows: state.listProductSearch.isNotEmpty
                            ? List.generate(
                                state.listProductSearch.length,
                                (index) => recentFileDataRow(
                                    state.listProductSearch[index],
                                    context,
                                    index,
                                    true),
                              )
                            : List.generate(
                                state.listProduct.length,
                                (index) => recentFileDataRow(
                                    state.listProduct[index],
                                    context,
                                    index,
                                    false),
                              ));
                  }
                  return DataTable2(
                      scrollController: _controller,
                      columnSpacing: defaultPadding,
                      minWidth: 600,
                      columns: [
                        DataColumn(
                          label: Text(""),
                        ),
                        DataColumn(
                          label: Text("Nombre Producto"),
                        ),
                        DataColumn(
                          label: Text("Código"),
                        ),
                      ],
                      rows: [
                        DataRow(cells: [
                          DataCell(
                            Text(
                              '',
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          DataCell(
                            Text(
                              '',
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          DataCell(
                            Text(
                              '',
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ])
                      ]);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

DataRow recentFileDataRow(
    ProductApi fileInfo, BuildContext context, int index, bool searchByCode) {
  return DataRow(
    cells: [
      DataCell(
        ElevatedButton.icon(
            style: ElevatedButton.styleFrom(primary: Colors.indigo),
            onPressed: () {
              fileInfo.active == 1
                  ? context.read<OnlineproductsCubit>().stateusCahenged(
                      category: fileInfo.itemGroup,
                      active: 0,
                      isSearchByCode: searchByCode,
                      indexInList: index,
                      id: fileInfo.code)
                  : context.read<OnlineproductsCubit>().stateusCahenged(
                      category: fileInfo.itemGroup,
                      active: 1,
                      isSearchByCode: searchByCode,
                      indexInList: index,
                      id: fileInfo.code);
            },
            icon: fileInfo.active == 1
                ? Icon(
                    Icons.toggle_on,
                    color: Colors.green,
                  )
                : Icon(Icons.toggle_off, color: Colors.red),
            label: fileInfo.active == 1 ? Text('Activo') : Text('Desactivado')),
      ),
      DataCell(
        Text(
          fileInfo.name,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      DataCell(Text(fileInfo.code)),
    ],
  );
}
