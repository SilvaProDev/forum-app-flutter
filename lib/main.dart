import 'package:flutter/material.dart';
import 'package:forum_app/views/home_page.dart';
import 'package:forum_app/views/login/login_page.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
   final box = GetStorage();
    final token = box.read('token');
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: token == null ? LoginPage(): HompePage(), //Si le token est null retourne sur la page de connexion sinon retourne la page d'accueil
    );
  }
}
