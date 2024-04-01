import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:troptrip/views/chat/single_chat_screen.dart';

import '../../models/chatroom_model.dart';
import '../../models/firebase_helper.dart';
import '../../models/user_model.dart';

class ChatScreen extends StatefulWidget {
  final UserModel? userModel;
  final User? firebaseUser;

  const ChatScreen({Key? key, this.userModel, this.firebaseUser})
      : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("chatrooms")
                .where("participants.${widget.userModel!.uid}", isEqualTo: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  QuerySnapshot chatRoomSnapshot =
                      snapshot.data as QuerySnapshot;
                  return Expanded(
                    child: ListView.builder(
                      itemCount: chatRoomSnapshot.docs.length,
                      itemBuilder: (context, index) {
                        ChatRoomModel chatRoomModel = ChatRoomModel.fromMap(
                          chatRoomSnapshot.docs[index].data()
                              as Map<String, dynamic>,
                        );

                        Map<String, dynamic> participants =
                            chatRoomModel.participants!;
                        List<String> participantKeys =
                            participants.keys.toList();
                        participantKeys.remove(widget.userModel!.uid);

                        return FutureBuilder(
                          future: FirebaseHelper.getUserModelById(
                              participantKeys[0]),
                          builder: (context, userData) {
                            if (userData.connectionState ==
                                ConnectionState.done) {
                              if (userData.hasData) {
                                UserModel targetUser =
                                    userData.data as UserModel;

                                return Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Card(
                                    elevation: 10,
                                    child: ListTile(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) {
                                            return SingleChatScreen(
                                              chatroom: chatRoomModel,
                                              firebaseUser:
                                                  widget.firebaseUser!,
                                              userModel: widget.userModel!,
                                              targetUser: targetUser,
                                            );
                                          }),
                                        );
                                      },
                                      leading: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                          targetUser.profilepic.toString(),
                                        ),
                                      ),
                                      title:
                                          Text(targetUser.fullname.toString()),
                                      subtitle: (chatRoomModel.lastMessage
                                                  .toString() !=
                                              "")
                                          ? Text(chatRoomModel.lastMessage
                                              .toString())
                                          : Text(
                                              "Say hi to your new friend!",
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary,
                                              ),
                                            ),
                                    ),
                                  ),
                                );
                              } else {
                                // Handle the case where user data is null
                                return Container();
                              }
                            } else {
                              // Handle other connection states
                              return CircularProgressIndicator();
                            }
                          },
                        );
                      },
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else {
                  return const Center(
                    child: Text("No Chats"),
                  );
                }
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
