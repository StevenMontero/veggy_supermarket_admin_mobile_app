import 'package:admin/screens/LocalProductsScreen/local_products_screen.dart';
import 'package:admin/screens/ViewEmails/view_emails_screen.dart';
import 'package:admin/screens/adminImages/admin_images_screen.dart';
import 'package:admin/screens/onlieneProductsScreen/online_products_screen.dart';
import 'package:admin/screens/orderPage/detail_orders_screen.dart';
import 'package:admin/screens/orderPage/order_screen.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

class MainpageCubit extends Cubit<Widget> {
  MainpageCubit() : super(ProdectsOnlineScreen());

  Map<String, Widget> getApplicationScreen = {
    '/': ProdectsOnlineScreen(),
    'qupos': ProdectsLocalScreen(),
    'images': AdminImagesScreen(),
    'emails': ViewEmailsScreen(),
    'orders': OrdersOnlineScreen(),
    'ordersDetail': OrdersDetailScreen(),
  };

  void changedPage(String raute) {
    emit(getApplicationScreen[raute]!);
  }
}
