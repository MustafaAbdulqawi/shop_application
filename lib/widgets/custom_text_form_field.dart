import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.hintText,
    required this.hintTextValidation,
    required this.textEditingController,
    this.suffixIcon,
    required this.prefixIcon,
   required this.obscureText,
    this.onTap,
    this.obscuringCharacter,
     this.onSubmitted,
  });
  final String hintText;
  final String hintTextValidation;
  final TextEditingController textEditingController;
  final Widget? suffixIcon;
  final Widget prefixIcon;
  final void Function()? onTap;
  final bool obscureText;
  final String? obscuringCharacter;
 final  void Function(String)? onSubmitted;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Colors.black,
      onChanged: onSubmitted,
      obscureText: obscureText,
      obscuringCharacter: obscuringCharacter!,
      onTap: onTap,
      controller: textEditingController,
      style: const TextStyle(
        color: Colors.black,
      ),
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        suffixIconColor: Colors.black,
        prefixIconColor: Colors.black,
        prefixIcon: prefixIcon,
        hintText: hintText,
        filled: true,
        fillColor: Colors.grey.shade300,
        contentPadding:const EdgeInsets.symmetric(
            horizontal: 16.0 * 1.5, vertical: 16.0),
        border:const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return hintTextValidation;
        }
        return null;
      },
    );
  }
}
