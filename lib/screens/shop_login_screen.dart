import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_application/app_cubit/app_cubit.dart';
import 'package:shop_application/network/local/cache_helper.dart';
import 'package:shop_application/screens/shop_layout.dart';
import 'package:shop_application/screens/shop_register_screen.dart';
import 'package:shop_application/widgets/custom_text_form_field.dart';
import 'package:shop_application/widgets/widgets.dart';

import '../network/end_points.dart';
import '../shop_cubit/shop_cubit.dart';

class ShopLoginScreen extends StatefulWidget {
  static const String routeName = '/shop_login_screen';

  const ShopLoginScreen({super.key});

  @override
  State<ShopLoginScreen> createState() => _ShopLoginScreenState();
}

class _ShopLoginScreenState extends State<ShopLoginScreen> {
  var formKey = GlobalKey<FormState>();
  SharedPreferences? preferences;

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AppCubit>(context);
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) async {
        if (state is ShopLoginSuccessState) {
          if (state.loginModel.status == true) {
            await CacheHelper.saveData(
              key: EndPoints.token,
              value: state.loginModel.data!.token,
            ).then((value) => {
                  token = state.loginModel.data!.token,
                  Fluttertoast.showToast(
                    msg: state.loginModel.message!,
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  ),
                  navigationAndRemove(context, ShopLayout.routeName),
                });
          } else {
            Fluttertoast.showToast(
              msg: state.loginModel.message!,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    const Text(
                      "LOGIN",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      "Login now to browse our hot offers",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    CustomTextFormField(
                      obscureText: false,
                      obscuringCharacter: "*",
                      prefixIcon: const Icon(
                        Icons.email,
                        color: Colors.black,
                      ),
                      hintText: "Enter Your Email ",
                      hintTextValidation: "Can't be empty'",
                      textEditingController: emailController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextFormField(
                      obscureText: cubit.isPasswordShow,
                      obscuringCharacter: "*",
                      suffixIcon: IconButton(
                        onPressed: () {
                          cubit.changePasswordVisibility();
                        },
                        icon: Icon(
                          cubit.suffix,
                          color: Colors.black,
                        ),
                      ),
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: Colors.black,
                      ),
                      hintText: "Enter Your Password ",
                      hintTextValidation: "Can't be empty'",
                      textEditingController: passwordController,
                    ),
                    const SizedBox(
                      height: 70,
                    ),
                    Center(
                      child: state is ShopLoginLoadingState
                          ? const CircularProgressIndicator(
                              color: Colors.black,
                            )
                          : customElevatedButton(
                              () {
                                if (formKey.currentState!.validate()) {
                                  cubit.userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                                BlocProvider.of<ShopCubit>(context)
                                    .getUserData();
                              },
                              "Login",
                            ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        const Text(
                          "if you don't have an account",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        TextButton(
                          onPressed: () {
                            navigationNameToPage(
                                context, ShopRegisterScreen.routeName);
                          },
                          child: const Text(
                            "Register Now",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
