import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:formation_lh_23/shared/theming/app_colors.dart';
import 'package:formation_lh_23/shared/widgets/app_input.dart';
import 'package:formation_lh_23/users/data/user_model.dart';
import 'package:formation_lh_23/users/services/user_services.dart';

import '../../shared/widgets/app_button.dart';

@RoutePage()
class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _telController;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late UserServices _userServices;
  bool isLoading = false;

  @override
  void initState() {
    _userServices = UserServices();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _telController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _telController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User APP"),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: _userServices.users.snapshots(),
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
                var user = UserModel.fromJson(result);

                return ListTile(
                  title: Text(user.name),
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
            child: Align(
              alignment: Alignment.center,
              child: Form(
                key: _formKey,
                child: Container(
                  height: MediaQuery.sizeOf(context).height * .65,
                  width: MediaQuery.sizeOf(context).width * .9,
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 20,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Material(
                    color: AppColors.white,
                    child: Column(
                      children: [
                        const Text(
                          "Add user",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Spacer(),
                        AppInput(
                          controller: _nameController,
                          label: "name",
                          hint: "Enter your name...",
                          keyboardType: TextInputType.name,
                          validators: [FormBuilderValidators.required()],
                        ),
                        const SizedBox(height: 20),
                        AppInput(
                          controller: _emailController,
                          label: "Email",
                          hint: "Enter your email...",
                          keyboardType: TextInputType.emailAddress,
                          validators: [
                            FormBuilderValidators.required(),
                            FormBuilderValidators.email()
                          ],
                        ),
                        const SizedBox(height: 20),
                        AppInput(
                          controller: _telController,
                          label: "Tel",
                          hint: "Enter your tel...",
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          validators: [
                            FormBuilderValidators.required(),
                          ],
                        ),
                        Spacer(),
                        Row(
                          children: [
                            Expanded(
                              child: AppButton(
                                loading: isLoading,
                                onPressed: () async {
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    var data = {
                                      "name": _nameController.text,
                                      "email": _emailController.text,
                                      "tel": _telController.text,
                                    };
                                    await _userServices.addUser(data: data);
                                    setState(() {
                                      isLoading = true;
                                    });
                                    _emailController.clear();
                                    _nameController.clear();
                                    _telController.clear();
                                    context.router.pop();
                                  }
                                },
                                bgColor: const Color.fromRGBO(35, 204, 183, 1),
                                child: const Text(
                                  "Save",
                                  style: TextStyle(
                                    color: AppColors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: AppButton(
                                onPressed: () {
                                  _emailController.clear();
                                  _nameController.clear();
                                  _telController.clear();
                                  context.router.pop();
                                },
                                borderColor: AppColors.bordeColor,
                                child: const Text(
                                  "Cancel",
                                  style: TextStyle(
                                    color: AppColors.blackBlue,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
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
