import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formation_lh_23/counter_with_bloc/logic/bloc/counter_bloc.dart';
import 'package:formation_lh_23/posts_app_wiht_bloc/logic/bloc/post_bloc.dart';
import 'package:formation_lh_23/services_locator.dart';

import '../../counter_with_cubit/logic/cubit/counter_cubit.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Post App With Bloc"),
      ),
      body: Column(
        children: [
          Container(
            height: 100,
            color: Colors.blueAccent,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        "Counter Bloc",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      BlocBuilder<CounterBloc, CounterState2>(
                        builder: (context, state) {
                          return Text(
                            state.counter.toString(),
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const VerticalDivider(),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        "Counter Cubic",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        getIt.get<CounterCubit>().state.counter.toString(),
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<PostBloc, PostState>(
              builder: (context, state) {
                if (state is PostFailureLoadingState) {
                  return Center(child: Text(state.message));
                }

                if (state is PostLoadingState) {
                  return const Center(
                    child: CupertinoActivityIndicator(),
                  );
                }

                if (state is PostSuccessLoadingState) {
                  var posts = state.posts;
                  return RefreshIndicator(
                    onRefresh: () async {
                      context.read<PostBloc>().add(LoadPostsEvent());
                    },
                    child: ListView.separated(
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        var post = posts[index];
                        return ListTile(
                          title: Text(post.title),
                          subtitle: Text(post.body),
                          trailing: const Icon(Icons.arrow_forward_ios),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider();
                      },
                    ),
                  );
                }
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }
}
