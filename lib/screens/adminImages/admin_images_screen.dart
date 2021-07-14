import 'package:flutter/material.dart';
import 'components/image_banners_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:admin/screens/widgets/header.dart';
import 'package:admin/screens/adminImages/cubit/imagebanners_cubit.dart';
import 'package:admin/services/production/repositories/banners_repository.dart';

class AdminImagesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ImagebannersCubit(BannerRepository())..getAllBannersImages(),
      child: _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Header(),
          ImageBannersView(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add, size: 30.0),
          backgroundColor: Colors.white,
          onPressed: () => Navigator.pushNamed(context, 'addImage')),
    );
  }
}
