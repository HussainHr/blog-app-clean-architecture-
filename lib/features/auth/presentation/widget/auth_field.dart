import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  final String hinText;
  final bool obSecureText;
  final TextEditingController controller;
  const AuthField({Key? key, required this.hinText, this.obSecureText = false, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obSecureText,
      decoration: InputDecoration(
        hintText: hinText,
      ),
      validator: (value){
        if(value!.isEmpty){
          return "$hinText is missing";
        }
        return null;
      },
    );
  }
}
