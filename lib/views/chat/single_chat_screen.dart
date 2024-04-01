
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:troptrip/controllers/chat_controller.dart';
import 'package:troptrip/models/chatroom_model.dart';

import '../../models/user_model.dart';

class SingleChatScreen extends StatefulWidget {
   final UserModel targetUser;
  final ChatRoomModel chatroom;
  final UserModel userModel;
  final User firebaseUser;
   const SingleChatScreen({Key? key, required this.targetUser, required this.chatroom, required this.userModel, required this.firebaseUser, }):super(key: key);

  @override
  State<SingleChatScreen> createState() => _SingleChatScreenState();
}

class _SingleChatScreenState extends State<SingleChatScreen> {
  final ChatController Chatcontroller = Get.put<ChatController>(ChatController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatController>(
      builder: (ctrl) {
        return Scaffold(
          appBar: AppBar(
          //  title: Text(widget.userModel.fullname!),
            //subtitle: Text('Active now'),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Get.back(),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.more_vert),
                onPressed: () {
                  // Implement more options
                },
              ),
            ],
          ),
          body: Column(
            children: [
              Expanded(
                child: Obx(() => ListView.builder(
                      itemCount: ctrl.messages.length,
                      itemBuilder: (context, index) {
                        return Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            padding: EdgeInsets.all(8),
                            margin:
                                EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.blue, // Your theme color
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(ctrl.messages[index]),
                          ),
                        );
                      },
                    )),
              ),
              Container(
                padding: EdgeInsets.all(8),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        // Implement additional actions
                      },
                    ),
                    Expanded(
                      child: TextField(
                        controller: ctrl.messageTextController,
                        decoration: InputDecoration(
                          hintText: 'Send message',
                          filled: true,
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () {
                       ctrl.sendMessage(widget.userModel, widget.chatroom);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}
