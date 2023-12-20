import 'package:dio/dio.dart';

import 'post_models.dart';

class PostRepository {
  final Dio dio;
  PostRepository({
    required this.dio,
  });

  Future<List<PostModel>> getPosts() async {
    Response response = await dio.get(
      "/posts",
    );
    var data = response.data;

    List<PostModel> posts = [];

    for (var item in data) {
      posts.add(PostModel.fromJson(item));
    }

    return posts;
  }
}
