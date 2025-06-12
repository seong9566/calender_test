import 'package:flutter/material.dart';

class AuthInputField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isPassword;

  const AuthInputField({
    super.key,
    required this.hintText,
    required this.controller,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        keyboardType: TextInputType.name, // 이메일/텍스트에 따라 변경 가능
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(fontSize: 16, color: Color(0xff61758A)),
          filled: true,
          fillColor: const Color(0xffF0F2F5),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 20,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
