part of 'galery_cubit.dart';

@immutable
class GalleryState {
  final bool isLoadingImages;
  final bool successLoadingImages;
  final bool errorLoadingImages;
  final String? message;

  final List<String> images;

  GalleryState({
    this.isLoadingImages = false,
    this.successLoadingImages = false,
    this.errorLoadingImages = false,
    this.message,
    required this.images,
  });

  GalleryState copyWith({
    bool? isLoadingImages,
    bool? successLoadingImages,
    bool? errorLoadingImages,
    String? message,
    List<String>? images,
  }) {
    return GalleryState(
      images: images ?? this.images,
      isLoadingImages: isLoadingImages ?? this.isLoadingImages,
      successLoadingImages: successLoadingImages ?? this.successLoadingImages,
      errorLoadingImages: errorLoadingImages ?? this.errorLoadingImages,
      message: message ?? this.message,
    );
  }
}
