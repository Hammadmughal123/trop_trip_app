


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:troptrip/themes/app_theme.dart';
import 'package:troptrip/utils/extensions.dart';
import 'package:troptrip/views/chat/single_chat_screen.dart';
import '../../controllers/search_controller.dart';
import '../../models/chatroom_model.dart';
import '../../models/user_model.dart';

class SearchFriend extends StatefulWidget {
  final UserModel userModel;
  final User firebaseUser;

  const SearchFriend(
      {super.key, required this.userModel, required this.firebaseUser});
  @override
  State<SearchFriend> createState() => _SearchFriendState();
}

class _SearchFriendState extends State<SearchFriend> {
  final CustomSearchController controller = Get.put(CustomSearchController());

  Map<String, dynamic>? userMap;
  ChatRoomModel? chatroomModel;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomSearchController>(builder: (ctrl) {
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(right: 20, left: 20, top: 20),
          child: Column(
            children: [
              20.h,
              SizedBox(
                height: 55,
                child: Card(
                  elevation: 3,
                  child: TextFormField(
                    controller: controller.seCtrl,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(top: 17, left: 10),
                      hintText: 'Search',
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                ),
              ),

              
              Expanded(
                child: ListView.builder(
                  itemCount: ctrl.resultList.length,
                  itemBuilder: (context, index) {
                    if (ctrl.resultList.isNotEmpty) {
                      userMap =
                          ctrl.resultList[0].data() as Map<String, dynamic>;
                    }

                    var userData = ctrl.resultList[index];
                    return Card(
                      elevation: 5,
                      child: ListTile(
                        tileColor: AppTheme.primaryColor,
                        trailing: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.white,
                        ),
                        onTap: () async {
                          UserModel searchedUser = UserModel.fromMap(userMap!);
                          chatroomModel = await ctrl.getChatroomModel(
                              searchedUser, widget.userModel);
                          Get.to(() => SingleChatScreen(
                                targetUser: searchedUser,
                                userModel: widget.userModel,
                                firebaseUser: widget.firebaseUser,
                                chatroom: chatroomModel!,
                              ));
                        },
                        leading: const CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/images/person1.jpg'),
                        ),
                        title: Text(
                          userData['username'],
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        subtitle: Text(userData['email'],
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 13)),
                        // Add other UI elements as needed
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
