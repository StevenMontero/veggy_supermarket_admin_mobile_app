import 'package:admin/screens/LocalProductsScreen/local_products_screen.dart';
import 'package:admin/screens/adminImages/add_image_screen.dart';
import 'package:admin/screens/adminImages/admin_images_screen.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:admin/screens/onlieneProductsScreen/online_products_screen.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    'main': (BuildContext context) => MainScreen(),
    '/': (BuildContext context) => ProdectsOnlineScreen(),
    'qupos': (BuildContext context) => ProdectsLocalScreen(),
    'images': (BuildContext context) => AdminImagesScreen(),
    'addImage': (BuildContext context) => AddImageScreen(),
  };
}
