import 'package:flutter/material.dart';
import 'package:forum_app/controllers/post_controller.dart';
import 'package:forum_app/models/post_model.dart';
import 'package:forum_app/views/login/widgets/input_widget.dart';
import 'package:forum_app/views/widgets/post_data.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PostDetail extends StatefulWidget {
  PostDetail({super.key, required this.post});

  final PostModel post;
  @override
  State<PostDetail> createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  final TextEditingController _commentController = TextEditingController();
  final PostController _postController = Get.put(PostController());

  @override
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _postController.getComments(widget.post.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        elevation: 0,
        title: Text(widget.post.user!.name!,
            style: GoogleFonts.poppins(color: Colors.white, fontSize: 25)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              PostData(post: widget.post),
              const SizedBox(
                height: 15,
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                height: 200,
                child: Obx(() {
                  return _postController.isLoading.value
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          itemCount: _postController.comments.value.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return ListTile(
                                title: Text(_postController
                                    .comments.value[index].user!.name!),
                                subtitle: Text(
                                  _postController.comments.value[index].body,
                                ));
                          });
                }),
              ),
              const SizedBox(
                height: 20,
              ),
              LoginInputWidget(
                obscurText: false,
                hintext: "write comment",
                controller: _commentController,
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      elevation: 0,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5)),
                  onPressed: () async {
                    await _postController.createComment(
                        widget.post.id, _commentController.text.trim());
                    _commentController.clear();
                    _postController.getComments(widget.post.id);
                  },
                  child: Text(
                    "Comment",
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
