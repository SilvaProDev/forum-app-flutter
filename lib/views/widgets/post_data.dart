import 'package:flutter/material.dart';
import 'package:forum_app/controllers/post_controller.dart';
import 'package:forum_app/views/widgets/post_detail.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/post_model.dart';

class PostData extends StatefulWidget {
  const PostData({
    super.key,
    required this.post,
  });
  final PostModel post;

  @override
  State<PostData> createState() => _PostDataState();
}

class _PostDataState extends State<PostData> {
  final PostController _postController = Get.put(PostController());
  @override
  Widget build(BuildContext context) {
    Color likePost = widget.post.liked! ? Colors.blue : Colors.black;
    print(widget.post.liked);
    return Container(
      padding: EdgeInsets.all(10),
      width: double.infinity,
      height: 300,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.post.user!.name!, style: GoogleFonts.poppins()),
          Text(widget.post.user!.email!,
              style: GoogleFonts.poppins(fontSize: 10)),
          SizedBox(
            height: 10,
          ),
          SingleChildScrollView(
            child: Text(
              widget.post.content!,
              style: GoogleFonts.poppins(),
            ),
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () async {
                    await _postController.likeAndDislike(widget.post.id);
                    setState(() {
                    _postController.getAllPost();
                      likePost;
                    });
                  },
                  icon: Icon(
                    Icons.thumb_up,
                    color: likePost,
                  )),
              SizedBox(
                width: 10,
              ),
              IconButton(
                  onPressed: () {
                    Get.to(() => PostDetail(
                          post: widget.post,
                        ));
                  },
                  icon: Icon(Icons.message)),
            ],
          ),
        ],
      ),
    );
  }
}
