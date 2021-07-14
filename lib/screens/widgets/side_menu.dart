import 'package:admin/screens/main/cubit/mainpage_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: SvgPicture.asset(
              "assets/icons/LOGO_VEGGY_PRINCIPAL.svg",
            ),
          ),
          Divider(),
          DrawerListTile(
            title: "Imagenes promocionales",
            svgSrc: "assets/icons/menu_dashbord.svg",
            press: () {
              context.read<MainpageCubit>().changedPage('images');
              Navigator.of(context).pop();
            },
          ),
          Divider(),
          DrawerListTile(
            title: "Productos en Qupos",
            svgSrc: "assets/icons/menu_doc.svg",
            press: () {
              context.read<MainpageCubit>().changedPage('qupos');
              Navigator.of(context).pop();
            },
          ),
          Divider(),
          DrawerListTile(
            title: "Productos Subidos",
            svgSrc: "assets/icons/menu_store.svg",
            press: () {
              context.read<MainpageCubit>().changedPage('/');
              Navigator.of(context).pop();
            },
          ),
          Divider(),
          DrawerListTile(
            title: "Emails clientes",
            svgSrc: "assets/icons/menu_notification.svg",
            press: () {
              context.read<MainpageCubit>().changedPage('emails');
              Navigator.of(context).pop();
            },
          ),
          Divider(),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        color: Colors.white54,
        height: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white54),
      ),
    );
  }
}
