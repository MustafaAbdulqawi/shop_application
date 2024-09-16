import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_application/network/local/cache_helper.dart';
import 'package:shop_application/screens/shop_login_screen.dart';
import 'package:shop_application/shop_cubit/shop_cubit.dart';
import 'package:shop_application/widgets/settings_text_form_field.dart';
import 'package:shop_application/widgets/widgets.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var nameController = TextEditingController();
    var emailController = TextEditingController();
    var phoneController = TextEditingController();
    return BlocProvider(
      create: (context) => ShopCubit()..getUserData(),
      child: BlocConsumer<ShopCubit, ShopState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = BlocProvider.of<ShopCubit>(context);
          nameController.text = cubit.shopLoginModel?.data?.name ?? "";
          emailController.text = cubit.shopLoginModel?.data?.email ?? "";
          phoneController.text = cubit.shopLoginModel?.data?.phone ?? "";
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formKey,
              child: cubit.isSuccessFour == "Done"
                  ? Column(
                children: [
                  SettingsTextFormField(
                    controller: nameController,
                    hintText: "Name",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SettingsTextFormField(
                    controller: emailController,
                    hintText: "Email",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SettingsTextFormField(
                    controller: phoneController,
                    hintText: "Phone",
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  cubit.isSuccessFour == "Loading"
                      ? const Center(
                    child: LinearProgressIndicator(
                      color: Colors.black,
                    ),
                  )
                      : Container(),
                  const SizedBox(
                    height: 50,
                  ),
                  customElevatedButton(
                        () async {
                      final data = await CacheHelper.clearData(
                        key: "token",
                      );
                      if (data != true) {
                        navigationAndRemove(
                            context, ShopLoginScreen.routeName);
                        nameController.clear();
                        emailController.clear();
                        phoneController.clear();
                      }
                    },
                    "Logout",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  customElevatedButton(
                        () {
                      if (formKey.currentState!.validate()) {
                        cubit.updateUserData(
                          name: nameController.text,
                          email: emailController.text,
                          phone: phoneController.text,
                        );
                      }
                    },
                    "Update",
                  ),
                ],
              )
                  : cubit.isSuccessFour == "Loading"
                  ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              )
                  : const SizedBox(
                child: Center(
                  child: Text(
                    "No Data",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
