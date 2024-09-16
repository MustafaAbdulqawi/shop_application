import 'package:flutter/material.dart';

class SettingsTextFormField extends StatelessWidget {
  const SettingsTextFormField({super.key, required this.controller, required this.hintText, this.onChanged});
  final TextEditingController controller ;
  final String hintText ;
 final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      controller: controller,
      decoration:  InputDecoration(
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
      keyboardType: TextInputType.text,
    );
  }
}
