import 'package:bloc/bloc.dart';
import 'package:formation_lh_23/galery/data/galery_repository.dart';
import 'package:meta/meta.dart';

part 'galery_state.dart';

class GalleryCubit extends Cubit<GalleryState> {
  final GalleryRepository repository;
  GalleryCubit({
    required this.repository,
  }) : super(GalleryState(
          images: [],
        ));

  void getImages() async {
    emit(
      state.copyWith(
        isLoadingImages: true,
        errorLoadingImages: false,
        successLoadingImages: false,
        message: null,
      ),
    );

    try {
      var images = await repository.getImages();
      emit(
        state.copyWith(
          images: images,
          isLoadingImages: false,
          successLoadingImages: true,
          errorLoadingImages: false,
          message: null,
        ),
      );
    } catch (e) {
      print(e);
      emit(
        state.copyWith(
          isLoadingImages: false,
          successLoadingImages: false,
          errorLoadingImages: true,
          message: e.toString(),
        ),
      );
    }
  }
}
