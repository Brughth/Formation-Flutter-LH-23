import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formation_lh_23/galery/logic/cubit/galery_cubit.dart';
import 'package:formation_lh_23/galery/presentation/image_screen.dart';
import 'package:formation_lh_23/services_locator.dart';

@RoutePage()
class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
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

          // var images = state.images;

          // images[1] = state.images.first;

          return RefreshIndicator(
            onRefresh: () async {
              getIt.get<GalleryCubit>().getImages();
            },
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: screenWidth < 800
                    ? 2
                    : (screenWidth <= 1200 && screenWidth >= 800)
                        ? 3
                        : 4,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemCount: state.images.length,
              itemBuilder: (context, index) {
                print("object");
                var image = state.images[index];

                return InkWell(
                  onTap: () async {
                    var result = await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return ImageScreen(
                            image: image,
                          );
                        },
                      ),
                    );

                    print("Return Value: $result");
                  },
                  child: Hero(
                    tag: image,
                    child: Image.network(
                      image,
                      fit: BoxFit.cover,
                    ),
                  ),
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
