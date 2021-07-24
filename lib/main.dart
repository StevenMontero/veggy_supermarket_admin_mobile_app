import 'package:admin/constants.dart';
import 'package:admin/controllers/MenuController.dart';
import 'package:admin/routes/routes.dart';
import 'package:admin/screens/adminImages/cubit/imagebanners_cubit.dart';
import 'package:admin/screens/main/cubit/mainpage_cubit.dart';
import 'package:admin/screens/orderPage/orderCubit/order_cubit.dart';
import 'package:admin/services/production/repositories/banners_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => MenuController(),
          ),
          BlocProvider(
            create: (context) =>
                ImagebannersCubit(BannerRepository())..getAllBannersImages(),
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => MainpageCubit()),
            BlocProvider(create: (context) => OrderCubit())
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Veggy Admin',
            theme: ThemeData.dark().copyWith(
              scaffoldBackgroundColor: bgColor,
              textTheme:
                  GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
                      .apply(bodyColor: Colors.white),
              canvasColor: secondaryColor,
            ),
            routes: getApplicationRoutes(),
            initialRoute: 'main',
          ),
        ));
  }
}
