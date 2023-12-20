import 'package:bloc/bloc.dart';
import 'package:formation_lh_23/posts_app_wiht_bloc/data/post_models.dart';
import 'package:formation_lh_23/posts_app_wiht_bloc/data/post_repository.dart';
import 'package:meta/meta.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository repository;
  PostBloc({required this.repository}) : super(PostInitialSate()) {
    on<LoadPostsEvent>((event, emit) async {
      emit(PostLoadingState());

      try {
        var posts = await repository.getPosts();
        emit(
          PostSuccessLoadingState(posts: posts),
        );
      } catch (e) {
        emit(
          PostFailureLoadingState(
            message: e.toString(),
          ),
        );
      }
    });
  }
}
