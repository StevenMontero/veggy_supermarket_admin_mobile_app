import 'package:flutter/material.dart';
import 'components/image_banners_view.dart';
import 'package:admin/screens/widgets/header.dart';

class AdminImagesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  SafeArea(child: _Body());
  }
}

class _Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Header(),
          Expanded(child: ImageBannersView()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add, size: 30.0),
          backgroundColor: Colors.white,
          onPressed: () => Navigator.pushNamed(context, 'addImage')),
    );
  }
}
