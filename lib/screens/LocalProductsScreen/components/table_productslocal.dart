import 'package:admin/models/product_api.dart';
import 'package:admin/screens/LocalProductsScreen/ProductsOnlineCubit/localproducts_cubit.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants.dart';

class ProdectsTableWidgetLocal extends StatelessWidget {
  ProdectsTableWidgetLocal({
    Key? key,
  }) : super(key: key);

  final ScrollController _controller = ScrollController();

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
            height: 5,
          ),
          SizedBox(
            height: 500,
            width: double.infinity,
            child: Scrollbar(
              isAlwaysShown: true,
              controller: _controller,
              child: BlocBuilder<LocalproductsCubit, LocalproductsState>(
                  builder: (context, state) {
                if (state.status == StatusLocal.loaded) {
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
                        )
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
                return Center(
                  child: SingleChildScrollView(
                      controller: _controller,
                      child: CircularProgressIndicator()),
                );
              }),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          BlocBuilder<LocalproductsCubit, LocalproductsState>(
            builder: (context, state) {
              return Row(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.indigo),
                    onPressed: state.listProduct.isNotEmpty &&
                            state.previousIndex > 0 &&
                            state.listProductSearch.isEmpty
                        ? () => context
                            .read<LocalproductsCubit>()
                            .getBack10Products()
                        : null,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Volver',
                        ),
                        Icon(
                          Icons.arrow_left,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  ElevatedButton(
                    // icon: Icon(Icons.arrow_left),
                    style: ElevatedButton.styleFrom(primary: Colors.indigo),
                    onPressed: state.listProduct.isNotEmpty &&
                            state.listProductRaw.length > state.lastIndex &&
                            state.listProductSearch.isEmpty
                        ? () => context
                            .read<LocalproductsCubit>()
                            .get10MoreProducts()
                        : null,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Siguiente',
                        ),
                        Icon(
                          Icons.arrow_right,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ],
              );
            },
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
              context
                  .read<LocalproductsCubit>()
                  .addProduct(category: fileInfo.itemGroup, product: fileInfo);
              _showDialog(context);
            },
            icon: Icon(Icons.add),
            label: Text('Agregar')),
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

var _txtCustomHead = TextStyle(
  color: Colors.white,
  fontSize: 23.0,
  fontWeight: FontWeight.w600,
  fontFamily: "Gotik",
);

/// Card Popup if success payment
_showDialog(BuildContext ctx) {
  showDialog(
    context: ctx,
    builder: (context) => SimpleDialog(
      backgroundColor: bgColor,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 30.0, right: 60.0, left: 60.0),
          color: bgColor,
          child: Image.asset(
            "assets/images/checklist.png",
            height: 110.0,
            color: Colors.lightGreen,
          ),
        ),
        Center(
            child: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Text(
            '¡Producto agregado!',
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
                onPressed: () => Navigator.of(ctx).pop(),
                child: Text('Listo')),
          ),
        )
      ],
    ),
  );
}
