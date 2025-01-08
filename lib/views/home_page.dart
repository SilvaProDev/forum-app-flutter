import 'package:flutter/material.dart';
import 'package:forum_app/controllers/post_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import 'widgets/post_data.dart';
import 'widgets/post_field.dart';

class HompePage extends StatefulWidget {
  const HompePage({super.key});

  @override
  State<HompePage> createState() => _HompePageState();
}

class _HompePageState extends State<HompePage> {
  final PostController _postController = Get.put(PostController());
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    _postController.getAllPost();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final box = GetStorage();
    // final token = box.read('token');
    return Scaffold(
      
      appBar: AppBar(
        title: Text(
          "Forum App",
          style: GoogleFonts.poppins(fontSize: 15, color: Colors.white),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PostField(
                hintText: 'Do you want to add new task ?',
                controller: _textController,
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: () async {
                  await _postController.createPost(
                    content: _textController.text.trim(),
                  );
                  _textController.clear();
                  _postController.getAllPost();
                },
                child: Obx((){
                  return _postController.isLoading.value
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Text(
                          "Post",
                          style: TextStyle(color: Colors.white),
                        );
                }),
                style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Colors.black,
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 10)),
              ),
              const SizedBox(
                height: 20,
              ),
              Text("Posts"),
              const SizedBox(
                height: 30,
              ),
              Obx(() {
                return _postController.isLoading.value
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _postController.posts.value.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: PostData(
                                post: _postController.posts.value[index]),
                          );
                        });
              }
              
              ),
          
            ],
          ),
        ),
      ),
    );
  }
}
