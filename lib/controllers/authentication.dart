import 'dart:convert';
import 'package:forum_app/views/home_page.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../constatnts/constants.dart';

class AuthenticationController extends GetxController {
  final isLoading = false.obs;
  String token = '';
  final box = GetStorage();

//Fonction qui permet d enregistrer un user
  Future register({
    required name,
    required userName,
    required email,
    required password,
  }) async {
    try {
      isLoading.value = true;
      var data = {
        'name': name,
        'userName': userName,
        'email': email,
        'password': password,
      };
      print(data);
      var response = await http.post(Uri.parse(url + '/register'),
          headers: {'Accept': 'application/json'}, body: data);
      if (response.statusCode == 201) {
        isLoading.value = false;
         token = json.decode(response.body)['token'];
        box.write('token', token);
        Get.offAll(() => const HompePage());
        print(json.decode(response.body));
      } else {
        isLoading.value = false;
        return response.body;
      }
    } catch (e) {
      isLoading.value = false;
      print(e.toString());
    }
  }

  Future login({
    required email,
    required password,
  }) async {
    try {
      isLoading.value = true;
      //Definir les données pour la requête
      var data = {
        'email': email,
        'password': password,
      };
      //Envoyer la requête au serveur
      var response = await http.post(Uri.parse(url + '/login'),
          headers: {'Accept': 'application/json'}, body: data);
      //Verification de la reponse
      if (response.statusCode == 200) {
        isLoading.value = false;
        token = json.decode(response.body)['token'];
        box.write('token', token);
        Get.offAll(() => const HompePage());
        print(json.decode(response.body));
      } else {
        isLoading.value = false;
        return response.body;
      }
    } catch (e) {
      isLoading.value = false;
      print(e.toString());
    }
  }
}
