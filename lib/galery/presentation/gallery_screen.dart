import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formation_lh_23/galery/logic/cubit/galery_cubit.dart';
import 'package:formation_lh_23/services_locator.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gallery App"),
        centerTitle: true,
      ),
      body: BlocBuilder<GalleryCubit, GalleryState>(
        bloc: getIt.get<GalleryCubit>(),
        builder: (context, state) {
          if (state.errorLoadingImages) {
            return Center(
              child: Text("${state.message}"),
            );
          }

          if (state.isLoadingImages) {
            return const Center(
              child: CupertinoActivityIndicator(
                radius: 50,
              ),
            );
          }

          if (state.images.isEmpty) {
            return const Center(
              child: Text("No images yet"),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              getIt.get<GalleryCubit>().getImages();
            },
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemCount: state.images.length,
              itemBuilder: (context, index) {
                print("object");
                var image = state.images[index];
                return Image.network(
                  image,
                  fit: BoxFit.cover,
                );
                // return CachedNetworkImage(
                //   imageUrl: image,
                //   placeholder: (context, url) =>
                //       const CupertinoActivityIndicator(),
                //   errorWidget: (context, url, error) => const Icon(Icons.error),
                // );
              },
            ),
          );
        },
      ),
    );
  }
}
