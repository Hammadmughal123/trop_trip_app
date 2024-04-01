import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:troptrip/models/chatroom_model.dart';
import 'package:troptrip/models/message_model.dart';
import 'package:troptrip/models/user_model.dart';
import 'package:uuid/uuid.dart';

class ChatController extends GetxController {
  var uuid = Uuid();
  User? user = FirebaseAuth.instance.currentUser;
  @override
  void onInit() {
    super.onInit();
  }

  RxInt tabIndex = 0.obs; // To keep track of the selected tab
  final messageTextController = TextEditingController();

  // A list to hold messages
  var messages = <String>[].obs;

  void sendMessage(UserModel userModel, ChatRoomModel chatRoom) async {
    String msg = messageTextController.text.trim();
    messageTextController.clear();

    if (msg != "") {
      // Send Message
      MessageModel newMessage = MessageModel(
          messageid: uuid.v1(),
          sender: userModel.uid,
          createdon: DateTime.now(),
          text: msg,
          seen: false);
      messages.add(newMessage.text!);
      FirebaseFirestore.instance
          .collection("chatrooms")
          .doc(chatRoom.chatroomid)
          .collection("messages")
          .doc(newMessage.messageid)
          .set(newMessage.toMap());

      chatRoom.lastMessage = msg;
      FirebaseFirestore.instance
          .collection("chatrooms")
          .doc(chatRoom.chatroomid)
          .set(chatRoom.toMap());
  update();
      log("Message Sent!");
    }
  }
}
