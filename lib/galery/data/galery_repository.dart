import 'package:dio/dio.dart';

class GalleryRepository {
  final Dio dio;
  GalleryRepository({
    required this.dio,
  });

  Future<List<String>> getImages() async {
    Response response = await dio.get("/shibes?count=30");
    var images = <String>[];
    for (var image in response.data) {
      images.add(image);
    }
    return images;
  }
}
