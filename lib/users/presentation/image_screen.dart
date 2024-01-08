import 'package:flutter/material.dart';

class ImageScreen extends StatefulWidget {
  final String image;
  const ImageScreen({
    super.key,
    required this.image,
  });

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Hero(
            tag: widget.image,
            child: Image.network(
              widget.image,
            ),
          ),
        ),
      ),
    );
  }
}
