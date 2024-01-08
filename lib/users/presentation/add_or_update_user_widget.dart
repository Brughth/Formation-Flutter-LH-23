import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:formation_lh_23/shared/widgets/app_snackbar.dart';
import 'package:formation_lh_23/users/data/user_model.dart';
import 'package:image_picker/image_picker.dart';

import '../../shared/theming/app_colors.dart';
import '../../shared/widgets/app_button.dart';
import '../../shared/widgets/app_input.dart';
import '../services/user_services.dart';

class AddOrUpdateUserWidget extends StatefulWidget {
  final PersonModel? user;
  final bool readOnly;
  const AddOrUpdateUserWidget({
    super.key,
    this.user,
    required this.readOnly,
  });

  @override
  State<AddOrUpdateUserWidget> createState() => _AddOrUpdateUserWidgetState();
}

class _AddOrUpdateUserWidgetState extends State<AddOrUpdateUserWidget> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _telController;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late UserServices _userServices;
  bool isLoading = false;
  File? _image;

  @override
  void initState() {
    _userServices = UserServices();
    _nameController = TextEditingController(
      text: widget.user?.name,
    );
    _emailController = TextEditingController(
      text: widget.user?.email,
    );
    _telController = TextEditingController(
      text: widget.user?.tel,
    );
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _telController.dispose();
    super.dispose();
  }

  Future<XFile?> getImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: source,
    );
    return image;
  }

  @override
  Widget build(BuildContext context) {
    print(!widget.readOnly);
    return Align(
      alignment: Alignment.center,
      child: Form(
        key: _formKey,
        child: Container(
          height: MediaQuery.sizeOf(context).height * .9,
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
                Text(
                  widget.user != null ? "Edit user" : "Add user",
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 103.8,
                      backgroundColor: Colors.transparent,
                    ),
                    CircleAvatar(
                      backgroundColor: AppColors.lightGreen,
                      radius: 90,
                      child: CircleAvatar(
                        backgroundColor: AppColors.white,
                        radius: 88,
                        backgroundImage: _image != null
                            ? FileImage(_image!)
                            : widget.user?.image != null
                                ? NetworkImage(widget.user!.image!)
                                    as ImageProvider
                                : null,
                      ),
                    ),
                    if (!widget.readOnly)
                      Positioned(
                        right: 0,
                        bottom: 45,
                        child: InkWell(
                          onTap: () async {
                            var image = await getImage(ImageSource.gallery);
                            if (image != null) {
                              setState(() {
                                _image = File(image.path);
                              });
                            } else {
                              if (mounted) {
                                AppSnackBar.showError(
                                  message: "Aucune image selectionnee",
                                  context: context,
                                );
                              }
                            }
                          },
                          customBorder: const CircleBorder(),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.gray,
                                width: 1,
                              ),
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              color: AppColors.lightGreen,
                            ),
                          ),
                        ),
                      )
                  ],
                ),
                const Spacer(),
                AppInput(
                  enable: !widget.readOnly,
                  controller: _nameController,
                  label: "name",
                  hint: "Enter your name...",
                  keyboardType: TextInputType.name,
                  validators: [FormBuilderValidators.required()],
                ),
                const SizedBox(height: 20),
                AppInput(
                  enable: !widget.readOnly,
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
                  enable: !widget.readOnly,
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
                    if (!widget.readOnly) ...[
                      Expanded(
                        child: AppButton(
                          loading: isLoading,
                          onPressed: () async {
                            if (_formKey.currentState?.validate() ?? false) {
                              if (widget.user == null) {
                                if (_image == null) {
                                  AppSnackBar.showError(
                                    message: "Please select image",
                                    context: context,
                                  );
                                  return;
                                }
                              }
                              setState(() {
                                isLoading = true;
                              });
                              var data = {
                                "name": _nameController.text,
                                "email": _emailController.text,
                                "tel": _telController.text,
                              };

                              if (_image != null) {
                                var imageUrl = await _userServices
                                    .uploadFileToFirebaseAndGetDownloadURL(
                                  image: _image!,
                                );
                                data['image'] = imageUrl;
                              }

                              if (widget.user != null) {
                                await _userServices.updateUser(
                                  id: widget.user!.id,
                                  data: data,
                                );
                              } else {
                                await _userServices.addUser(data: data);
                              }

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
                    ],
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
    );
  }
}
