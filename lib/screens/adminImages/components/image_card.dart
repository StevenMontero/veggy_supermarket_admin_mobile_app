import 'package:flutter/material.dart';

class ImageCard extends StatelessWidget {
  late final String imageURL;
  late final VoidCallback onPressed;

  ImageCard({
    required this.imageURL,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          (imageURL != "") ? Image.network(imageURL) : Image.asset('imagen_no_disponible.png'),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: onPressed,
                icon: Icon(Icons.delete))
            ],
          ),
        ],
      ),
    );
  }
}
