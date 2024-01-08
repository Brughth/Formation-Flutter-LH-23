import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:formation_lh_23/auth/logic/cubit/auth_cubit.dart';
import 'package:formation_lh_23/routers/app_router.dart';

import '../../shared/theming/app_colors.dart';
import '../../shared/widgets/app_button.dart';
import '../../shared/widgets/app_input.dart';
import '../../shared/widgets/app_snackbar.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _emailController;
  late TextEditingController _pwController;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _emailController = TextEditingController();
    _pwController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: AutofillGroup(
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state.errorLogingIn) {
              AppSnackBar.showError(
                message: "${state.message}",
                context: context,
              );
            }

            if (state.successLogingIn) {
              context.router.pushAndPopUntil(
                ApplicationRoute(),
                predicate: (route) => false,
              );
            }
          },
          builder: (context, state) {
            return Form(
              key: _formKey,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                        text: "Formation ",
                        style: TextStyle(
                          fontSize: 37,
                          fontWeight: FontWeight.w700,
                          letterSpacing: .2,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: "Local",
                            style: TextStyle(
                              fontSize: 37,
                              fontWeight: FontWeight.w700,
                              height: 1,
                              letterSpacing: .2,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: "Host \n Academy",
                            style: TextStyle(
                              color: AppColors.lightGreen,
                              fontSize: 37,
                              fontWeight: FontWeight.w700,
                              letterSpacing: .2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * .03,
                    ),
                    AppInput(
                      controller: _emailController,
                      label: "Email",
                      hint: "Entez votre addresse mail",
                      validators: [
                        FormBuilderValidators.required(),
                        FormBuilderValidators.email()
                      ],
                      keyboardType: TextInputType.emailAddress,
                    ),
                    AppInput(
                      controller: _pwController,
                      label: "Mot de passe",
                      hint: "Entez votre mot de passe",
                      validators: [
                        FormBuilderValidators.required(),
                      ],
                      obscureText: false,
                      keyboardType: TextInputType.visiblePassword,
                      maxLines: 1,
                    ),
                    SizedBox(
                      height: screenHeight * .05,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppButton(
                          bgColor: AppColors.lightBlue,
                          loading: state.isLogingIn,
                          loadingColor: AppColors.white,
                          onPressed: () async {
                            if (_formKey.currentState?.validate() ?? false) {
                              context.read<AuthCubit>().login(
                                    email: _emailController.text,
                                    password: _pwController.text,
                                  );
                            }
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        AppButton(
                          loadingColor: AppColors.white,
                          bgColor: AppColors.lightGreen,
                          onPressed: () {
                            context.router.push(const RegisterRoute());
                          },
                          child: const Text(
                            "Register",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
