import 'package:dio/dio.dart';

class GalleryRepository {
  final Dio dio;
  GalleryRepository({
    required this.dio,
  });

  Future<List<String>> getImages() async {
    // var _dio = Dio();

    // (_dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
    //     (HttpClient dioClient) {
    //   dioClient.badCertificateCallback =
    //       ((X509Certificate cert, String host, int port) => true);
    //   return dioClient;
    // };
    Response response = await dio.get("/shibes?count=30");
    var images = <String>[];
    for (var image in response.data) {
      images.add(image);
    }
    print(images);
    return images;
  }
}
