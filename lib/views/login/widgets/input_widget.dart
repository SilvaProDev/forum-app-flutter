import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginInputWidget extends StatelessWidget {
  const LoginInputWidget({
    super.key, required this.hintext,  this.controller, required this.obscurText,
  });

  final String hintext;
  final TextEditingController? controller;
  final bool obscurText;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.grey[300], borderRadius: BorderRadius.circular(10)),
      child: TextField(
        obscureText: obscurText,
        controller: controller,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintext,
            hintStyle: GoogleFonts.poppins(fontSize: 15),
            contentPadding: EdgeInsets.symmetric(horizontal: 10)),
      ),
    );
  }
}
