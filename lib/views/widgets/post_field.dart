import 'package:flutter/material.dart';

class PostField extends StatelessWidget {
  const PostField({
    super.key, required this.hintText, required this.controller,
  });

  final String hintText;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      child: Container(
        width: double.infinity,
        height: 70,
        decoration: BoxDecoration(
            color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 20)),
        ),
        
      ),
      
    );
  }
}
