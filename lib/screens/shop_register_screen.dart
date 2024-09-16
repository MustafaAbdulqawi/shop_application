import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_application/register_cubit/register_cubit.dart';
import 'package:shop_application/screens/shop_layout.dart';
import 'package:shop_application/widgets/widgets.dart';

import '../network/end_points.dart';
import '../network/local/cache_helper.dart';
import '../widgets/custom_text_form_field.dart';

class ShopRegisterScreen extends StatelessWidget {
  const ShopRegisterScreen({super.key});

  static const String routeName = '/shop_register_screen';

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<RegisterCubit>(context);
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) async {
        if (state is ShopRegisterSuccessState) {
          if (state.registerModel.status == true) {
            await CacheHelper.saveData(
              key: EndPoints.token,
              value: state.registerModel.data!.token,
            ).then((value) => {
                  token = state.registerModel.data!.token,
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.registerModel.message ?? ""),
                    ),
                  ),
                  navigationAndRemove(context, ShopLayout.routeName),
                });
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.registerModel.message ?? ""),
              ),
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
                      "REGISTER",
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
                      " Register now to browse our hot offers ",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    CustomTextFormField(
                      hintText: "Name",
                      obscuringCharacter: "*",
                      hintTextValidation: "can't be empty",
                      textEditingController: nameController,
                      prefixIcon: const Icon(
                        Icons.person,
                        color: Colors.black,
                      ),
                      obscureText: false,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextFormField(
                      hintText: "Phone",
                      obscuringCharacter: "*",
                      hintTextValidation: "can't be empty",
                      textEditingController: phoneController,
                      prefixIcon: const Icon(
                        Icons.phone,
                        color: Colors.black,
                      ),
                      obscureText: false,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextFormField(
                      hintText: "Email",
                      obscuringCharacter: "*",
                      hintTextValidation: "can't be empty",
                      textEditingController: emailController,
                      prefixIcon: const Icon(
                        Icons.email,
                        color: Colors.black,
                      ),
                      obscureText: false,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextFormField(
                      hintText: "Password",
                      obscuringCharacter: "*",
                      hintTextValidation: "can't be empty",
                      textEditingController: passwordController,
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: Colors.black,
                      ),
                      obscureText: false,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    state is ShopRegisterLoadingState
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.black,
                            ),
                          )
                        : Center(
                            child: customElevatedButton(
                              () {
                                if (formKey.currentState!.validate()) {
                                  cubit.userRegister(
                                    name: nameController.text,
                                    phone: phoneController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                  if (state is ShopRegisterSuccessState) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            state.registerModel.message ?? ""),
                                      ),
                                    );
                                  }
                                }
                              },
                              "Register",
                            ),
                          ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        const Text(
                          "Already have an account?",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(
                              color: Colors.blue,
                            ),
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
