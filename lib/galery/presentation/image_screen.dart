import 'package:flutter/material.dart';

class ImageScreen extends StatelessWidget {
  final String image;
  const ImageScreen({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        SafeArea(
          child: Center(
            child: Hero(
              tag: image,
              child: Image.network(image),
            ),
          ),
        ),
        Positioned(
          top: MediaQuery.paddingOf(context).top,
          child: IconButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
            ),
          ),
        )
      ],
    ));
  }
}
