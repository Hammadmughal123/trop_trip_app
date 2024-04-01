import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:troptrip/models/chatroom_model.dart';
import 'package:uuid/uuid.dart';

import '../models/user_model.dart';

class CustomSearchController extends GetxController {
  

var uuid = Uuid();
  final seCtrl = TextEditingController();
  List results = [];
  List resultList = [];
  @override
  void onInit() {
    getDataFromFirebase();
    seCtrl.addListener(() {
      giveDataToSearchbar();
    });
    super.onInit();
  }

  Future<void> getDataFromFirebase() async {
    final firestore = FirebaseFirestore.instance;

    var data = await firestore.collection('users').get();
    results = data.docs;
    update();
    giveDataToSearchbar();
  }

  Future<void> giveDataToSearchbar() async {
    List searchList = [];

    if (seCtrl.text != '') {
      for (var clientSnapshot in results) {
        var name = clientSnapshot['username'].toString().toLowerCase();
        name = clientSnapshot['email'].toString().toLowerCase();
        if (name.contains(seCtrl.text)) {
          searchList.add(clientSnapshot);
        }

        resultList = searchList;
        update();
      }
    } else {
      searchList.add(List.from(results));
    }
  }
   Future<ChatRoomModel?> getChatroomModel(UserModel targetUser,UserModel userModel) async {
    ChatRoomModel? chatRoom;

    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection("chatrooms")
        .where("participants.${userModel.uid}", isEqualTo: true)
        .get();

    if (snapshot.docs.length > 0) {
      var docData = snapshot.docs[0].data();
      ChatRoomModel existingChatroom =
          ChatRoomModel.fromMap(docData as Map<String, dynamic>);

      chatRoom = existingChatroom;
    }
     
      
      ChatRoomModel newChatroom = ChatRoomModel(
        chatroomid: uuid.v1(),
        lastMessage: "",
        participants: {
          userModel.uid.toString(): true,
          targetUser.uid.toString(): true,
        },
      );

      await FirebaseFirestore.instance
          .collection("chatrooms")
          .doc(newChatroom.chatroomid)
          .set(newChatroom.toMap());

      chatRoom = newChatroom;

      log(".....New Chatroom Created!");


    return chatRoom;
  }

  @override
  void dispose() {
    seCtrl.dispose();
    super.dispose();
  }
}
