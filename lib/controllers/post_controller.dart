import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../constatnts/constants.dart';
import '../models/comment_model.dart';
import '../models/post_model.dart';

class PostController extends GetxController {
  Rx<List<PostModel>> posts = Rx<List<PostModel>>([]);
  Rx<List<CommentModel>> comments = Rx<List<CommentModel>>([]);
  final isLoading = false.obs;
  final box = GetStorage();
  var res = '';
  // String token = box.read("token");

  Future getAllPost() async {
    try {
      isLoading.value = true;
      var response = await http.get(
        Uri.parse('${url}/feeds'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}'
        },
      );
      if (response.statusCode == 200) {
        isLoading.value = false;
        final contents = (json.decode(response.body))['feed'];
        for (var content in contents) {
          posts.value.add(PostModel.fromJson(content));
        }
        //   print(json.decode(response.body));
      }
    } catch (e) {
      isLoading.value = false;
      print(e.toString());
    }
  }

  Future createPost({required content}) async {
    try {
      var data = {
        'content': content,
      };
      var response = await http.post(Uri.parse(url + '/feed/store'),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ${box.read('token')}'
          },
          body: data);
      if (response.statusCode == 201) {
        //print(json.decode(response.body));
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future getComments(id) async {
    try {
      //comments.value.clear();
      isLoading.value = true;

      var response = await http.get(
        Uri.parse('${url}/feed/comments/$id'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}'
        },
      );
      if (response.statusCode == 200) {
        isLoading.value = false;
        var content = json.decode(response.body)['comment'];
        for (var item in content) {
          comments.value.add(CommentModel.fromJson(item));
        }
      } else {
        isLoading.value = false;
        // print(json.decode(response.body));
      }
    } catch (e) {
      print(e.toString());
    }
  }

//la fonction qui permet d enregistrer un commentaire sur un post
  Future createComment(id, body) async {
    try {
      isLoading.value = true; //on lance le loading
      var data = {'body': body};
      //Envoie du requete au serveur
      var request = await http.post(Uri.parse('${url}/feed/comment/${id}'),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ${box.read('token')}'
          },
          body: data);
      if (request.statusCode == 201) {
        //on arrete le loading si la reponse est 201 c'est ç dire bon
        isLoading.value = false;
      } else {
        isLoading.value = false;
        print(json.decode(request.body));
      }
    } catch (e) {
      print(e);
    }
  }

  Future likeAndDislike(id) async {
    try {
      isLoading.value = true;
      var request = await http.post(
        Uri.parse('${url}/feed/like/$id'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}'
        },
      );
      if (request.statusCode == 200 ||
          json.decode(request.body)['message'] == 'Liked') {
        isLoading.value = false;
        print(json.decode(request.body));
        res = 'Liked';
      } else if (request.statusCode == 200 ||
          json.decode(request.body)['message'] == 'UnLiked') {
        isLoading.value = false;
        print(json.decode(request.body));
        res = 'UnLiked';
      } else {
        isLoading.value = false;
        print(json.decode(request.body));
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
