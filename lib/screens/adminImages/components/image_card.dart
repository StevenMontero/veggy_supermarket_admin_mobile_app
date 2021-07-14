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
          (imageURL != "")
              ? FadeInImage(
                  image: NetworkImage(imageURL),
                  placeholder: AssetImage('assets/images/loadingGif.gif') ,
                  height: 200,
                  width: 400,
                  fit: BoxFit.fill,
                )
              : Image(
                  image: AssetImage('imagen_no_disponible.png'),
                  height: 200,
                  width: 400,
                  fit: BoxFit.fill,
                ),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [
              IconButton(onPressed: onPressed, icon: Icon(Icons.delete))
            ],
          ),
        ],
      ),
    );
  }
}
