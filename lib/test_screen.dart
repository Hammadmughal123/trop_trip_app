//   Stream<List<DocumentSnapshot<Map<String, dynamic>>>>? messagesStream;

  // void setupMessagesStream(String userId) {
  //   messagesStream = FirebaseFirestore.instance
  //       .collection('chats')
  //       .doc(userId)
  //       .collection('messages')
  //       .snapshots()
  //       .map((snapshot) => snapshot.docs);
  // }

 
  // void sendMessage() {
  //   if (messageTextController.value.text.isNotEmpty) {
  //     String newMessage = messageTextController.value.text;

  //     // Add the new message to the local list
  //     messages.add(newMessage);
  //     messageTextController.value.clear();
  //     update();

  //     saveMessageToFirebase(newMessage);
  //   }
  // }

  // void saveMessageToFirebase(String message) async {
  //   User? user = FirebaseAuth.instance.currentUser;

  //   if (user != null) {
  //     await FirebaseFirestore.instance
  //         .collection('chats')
  //         .doc(user.uid)
  //         .collection('messages')
          
  //         .add({
  //       'senderId': user.uid,
  //       'message': message,
  //       'timestamp': FieldValue.serverTimestamp(),
  //     });
  //   }
  // }

























  // import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:troptrip/controllers/chat_controller.dart';

// // ignore: must_be_immutable
// class SingleChatScreen extends StatelessWidget {
//   String user;

//   SingleChatScreen({super.key, required this.user});
//   final ChatController controller = Get.put<ChatController>(ChatController());
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Shan Habibi'),
//         //subtitle: Text('Active now'),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () => Get.back(),
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.more_vert),
//             onPressed: () {

//             },
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: Obx(() => ListView.builder(
//                   itemCount: controller.messages.length,
//                   itemBuilder: (context, index) {
//                     return Align(
//                       alignment: Alignment.centerRight,
//                       child: Container(
//                         padding: const EdgeInsets.all(8),
//                         margin:
//                             const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
//                         decoration: BoxDecoration(
//                           color: Colors.blue, // Your theme color
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         child: Text(controller.messages[index]),
//                       ),
//                     );
//                   },
//                 )),
//           ),
//           Container(
//             padding: const EdgeInsets.all(8),
//             child: Row(
//               children: [
//                 IconButton(
//                   icon: const Icon(Icons.add),
//                   onPressed: () {
                    
//                   },
//                 ),
//                 Expanded(
//                   child: TextField(
//                     controller: controller.messageTextController.value,
//                     decoration: InputDecoration(
//                       hintText: 'Send message',
//                       filled: true,
//                       fillColor: Colors.grey[200],
//                       border: OutlineInputBorder(
//                         borderSide: BorderSide.none,
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.send),
//                   onPressed: () {
//                     controller.sendMessage();
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }












//  StreamBuilder(
//               stream: FirebaseFirestore.instance
//                   .collection("chatrooms")
//                   .snapshots(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.active) {
//                   if (snapshot.hasData) {
//                     QuerySnapshot chatRoomSnapshot =
//                         snapshot.data as QuerySnapshot;
            
//                     return ListView.builder(
//                       itemCount: chatRoomSnapshot.docs.length,
//                       itemBuilder: (context, index) {
//                         ChatRoomModel chatRoomModel = ChatRoomModel.fromMap(
//                             chatRoomSnapshot.docs[index].data()
//                                 as Map<String, dynamic>);
            
//                         Map<String, dynamic> participants =
//                             chatRoomModel.participants!;
            
//                         List<String> participantKeys = participants.keys.toList();
//                         participantKeys.remove(widget.userModel!.uid);
            
//                         return FutureBuilder(
//                           future:
//                               FirebaseHelper.getUserModelById(participantKeys[0]),
//                           builder: (context, userData) {
//                             if (userData.connectionState ==
//                                 ConnectionState.done) {
//                               if (userData.data != null) {
//                                 UserModel targetUser = userData.data as UserModel;
            
//                                 return Padding(
//                                   padding: const EdgeInsets.all(4.0),
//                                   child: Card(
//                                     elevation: 10,
//                                     child: ListTile(
//                                       onTap: () {
//                                         Navigator.push(
//                                           context,
//                                           MaterialPageRoute(builder: (context) {
//                                             return SingleChatScreen(
//                                               chatroom: chatRoomModel,
//                                               firebaseUser: widget.firebaseUser!,
//                                               userModel: widget.userModel!,
//                                               targetUser: targetUser,
//                                             );
//                                           }),
//                                         );
//                                       },
//                                       leading: CircleAvatar(
//                                         backgroundImage: NetworkImage(
//                                             targetUser.profilepic.toString()),
//                                       ),
//                                       title: Text(targetUser.fullname.toString()),
//                                       subtitle:
//                                           (chatRoomModel.lastMessage.toString() !=
//                                                   "")
//                                               ? Text(chatRoomModel.lastMessage
//                                                   .toString())
//                                               : Text(
//                                                   "Say hi to your new friend!",
//                                                   style: TextStyle(
//                                                     color: Theme.of(context)
//                                                         .colorScheme
//                                                         .secondary,
//                                                   ),
//                                                 ),
//                                     ),
//                                   ),
//                                 );
//                               } else {
//                                 return Container();
//                               }
//                             } else {
//                               return Container();
//                             }
//                           },
//                         );
//                       },
//                     );
//                   } else if (snapshot.hasError) {
//                     return Center(
//                       child: Text(snapshot.error.toString()),
//                     );
//                   } else {
//                     return const Center(
//                       child: Text("No Chats"),
//                     );
//                   }
//                 } else {
//                   return const Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 }
//               },
//             ),