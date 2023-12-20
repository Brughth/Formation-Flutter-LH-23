part of 'post_bloc.dart';

@immutable
sealed class PostState {}

final class PostInitialSate extends PostState {}

final class PostLoadingState extends PostState {}

final class PostSuccessLoadingState extends PostState {
  final List<PostModel> posts;

  PostSuccessLoadingState({
    required this.posts,
  });
}

final class PostFailureLoadingState extends PostState {
  final String message;

  PostFailureLoadingState({
    required this.message,
  });
}
