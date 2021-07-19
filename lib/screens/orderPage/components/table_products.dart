import 'package:admin/models/product.dart';
import 'package:admin/screens/orderPage/orderCubit/order_cubit.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants.dart';

class OrderTableWidget extends StatelessWidget {
  OrderTableWidget({
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
            "Detalle",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(
            height: 500,
            width: double.infinity,
            child: Scrollbar(
              isAlwaysShown: true,
              controller: _controller,
              child: BlocBuilder<OrderCubit, OrderState>(
                builder: (context, state) {
                  if (state.preOrdenList.isNotEmpty) {
                    return DataTable2(
                        scrollController: _controller,
                        columnSpacing: defaultPadding,
                        minWidth: 600,
                        columns: [
                          DataColumn(
                            label: Text("Código"),
                          ),
                          DataColumn(
                            label: Text("Cantidad"),
                          ),
                          DataColumn(
                            label: Text("Precio\nUnitario",textAlign: TextAlign.center,),
                          ),
                          DataColumn(
                            label: Text("Impuesto"),
                          ),
                          DataColumn(
                          label: Text("Precio+\nImpuesto",textAlign: TextAlign.center,),
                        ),
                        ],
                        rows: List.generate(
                          state.preOrdenList[state.indexSelected].detalles
                              .length,
                          (index) => recentFileDataRow(
                              state.preOrdenList[state.indexSelected]
                                  .detalles[index],
                              context,
                              index,
                              true),
                        ));
                  }
                  return DataTable2(
                      scrollController: _controller,
                      columnSpacing: defaultPadding,
                      minWidth: 600,
                      columns: [
                        DataColumn(
                          label: Text("Código"),
                        ),
                        DataColumn(
                          label: Text("Cantidad"),
                        ),
                        DataColumn(
                          label: Text("Precio\nUnitario"),
                        ),
                        DataColumn(
                          label: Text("Impuesto"),
                        ),
                        DataColumn(
                          label: Text("Precio + Impuesto"),
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
    Product fileInfo, BuildContext context, int index, bool searchByCode) {
     
  return DataRow(
    cells: [
      DataCell(
        Text(
          fileInfo.codigoArticulo,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      DataCell(Text('x ' + fileInfo.cantidad.toInt().toString())),
      DataCell(Text(fileInfo.precioSinIva.toStringAsFixed(2))),
      DataCell(Text(fileInfo.montoIva.toStringAsFixed(2))),
      DataCell(Text(fileInfo.precioIva.toStringAsFixed(2))),
    ],
  );
}
