import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:formation_lh_23/galery/presentation/image_screen.dart';
import 'package:formation_lh_23/users/data/user_model.dart';
import 'package:formation_lh_23/users/presentation/add_or_update_user_widget.dart';
import 'package:formation_lh_23/users/presentation/confirm_widget.dart';
import 'package:formation_lh_23/users/services/user_services.dart';

@RoutePage()
class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  late UserServices _userServices;
  late Stream<QuerySnapshot<Map<String, dynamic>>> userStream;

  @override
  void initState() {
    _userServices = UserServices();
    userStream =
        _userServices.users.orderBy("createAt", descending: true).snapshots();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User APP"),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: userStream,
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CupertinoActivityIndicator(
                radius: 50,
              ),
            );
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text(
                "Une erreur inconue !!",
              ),
            );
          }

          if (snapshot.hasData) {
            var data = snapshot.data?.docs;

            if (data?.isEmpty ?? true) {
              return const Center(
                child: Text(
                  "No user yet  !!",
                ),
              );
            }

            return ListView.separated(
              itemBuilder: (context, index) {
                var result = data[index].data();
                result['id'] = data[index].id;
                var user = PersonModel.fromJson(result);

                return ListTile(
                  onTap: () {
                    if (user.image != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ImageScreen(image: user.image!);
                          },
                        ),
                      );
                    }
                  },
                  leading: Hero(
                    tag: user.image ?? "",
                    child: Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: user.image != null
                            ? DecorationImage(
                                image: NetworkImage(user.image!),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                    ),
                  ),
                  title: Text(user.name),
                  subtitle: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user.email),
                      Text(user.tel),
                    ],
                  ),
                  trailing: PopupMenuButton<int>(
                    onSelected: (value) {
                      if (value == 0) {
                        showCustomDialgue(
                          context: context,
                          title: "Add user",
                          child: AddOrUpdateUserWidget(
                            user: user,
                            readOnly: true,
                          ),
                        );
                      }

                      if (value == 1) {
                        showCustomDialgue(
                          context: context,
                          title: "Add user",
                          child: AddOrUpdateUserWidget(
                            user: user,
                            readOnly: false,
                          ),
                        );
                      }

                      if (value == 2) {
                        showCustomDialgue(
                          context: context,
                          title: "Add user",
                          child: ConformWidget(
                            onConfirm: () async {
                              await _userServices.deleteUser(id: user.id);
                              if (mounted) {
                                context.router.pop();
                              }
                            },
                          ),
                        );
                      }
                    },
                    itemBuilder: (context) {
                      return [
                        const PopupMenuItem(
                          value: 0,
                          child: Text("View"),
                        ),
                        const PopupMenuItem(
                          value: 1,
                          child: Text("Edit"),
                        ),
                        const PopupMenuItem(
                          value: 2,
                          child: Text("Delete"),
                        ),
                      ];
                    },
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
              itemCount: data!.length,
            );
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showCustomDialgue(
            context: context,
            title: "Add user",
            child: const AddOrUpdateUserWidget(
              readOnly: false,
            ),
          );
        },
        label: const Text("Add"),
        icon: const Icon(Icons.add),
      ),
    );
  }
}

Future showCustomDialgue({
  required BuildContext context,
  required Widget child,
  required String title,
  Duration duration = const Duration(milliseconds: 500),
}) async {
  return showGeneralDialog(
    barrierLabel: title,
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: duration,
    context: context,
    pageBuilder: (context, anim1, anim2) {
      return child;
    },
    transitionBuilder: (context, anim1, anim2, child) {
      return SlideTransition(
        position: Tween(
          begin: const Offset(0, 1),
          end: const Offset(0, 0),
        ).animate(anim1),
        child: child,
      );
    },
  );
}
