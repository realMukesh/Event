/*
import 'package:firebase_chat/customerWidget/loading.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/user_controller.dart';
import '../model/question_model.dart';
import 'chat_bubble.dart';

class HomePage extends GetView<HomeController> {
  HomePage({Key? key}) : super(key: key);
  static const routeName = "/home_page";

  @override
  final controller = Get.put(HomeController());
  final _messageController=TextEditingController();
  final _scrollController=ScrollController();


  @override
  Widget build(BuildContext context) {
    return Container(
        height: context.height,
        width: context.width,
        padding: const EdgeInsets.all(0),
        child: Stack(
          children: <Widget>[
            StreamBuilder(
              stream: controller.messagesRef
                  .limitToLast(5)
                  .onChildAdded,
              builder: (context, snap) {
                if (snap.hasError) return new Text('Error: ${snap.error}');
                if (snap.data == null) {
                  return const Loading();
                }

                print(snap.data?.snapshot.key);
                final json = snap.data?.snapshot.value as Map<dynamic, dynamic>;
                final message = QuestionsModel.fromJson(json);
                controller.productList.add(message);
                return _getMessageList();
              },

            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
                height: 60,
                width: double.infinity,
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: Colors.lightBlue,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        decoration: InputDecoration(
                            hintText: "Write message...",
                            hintStyle: TextStyle(color: Colors.black54),
                            border: InputBorder.none),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        _sendMessage();
                      },
                      child: const Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 18,
                      ),
                      backgroundColor: Colors.blue,
                      elevation: 0,
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
        );
  }
  void _sendMessage() {
    if (*/
/*_canSendMessage()*//*
true) {
      final message = QuestionsModel(_messageController.text, */
/*DateTime.now()*//*
"");
      controller.saveMessage(message);
      _messageController.clear();
      //setState(() {});
    }
  }
  Widget _getMessageList() {
    return FirebaseAnimatedList(
      controller: _scrollController,
      query: controller.getMessageQuery(),
      itemBuilder: (context, snapshot, animation, index) {
        final json = snapshot.value as Map<dynamic, dynamic>;
        final message = QuestionsModel.fromJson(json);
        return ChatBubble(
          text: message.question,
          isCurrentUser: false,
        );
      },
    );
  }

}
*/
