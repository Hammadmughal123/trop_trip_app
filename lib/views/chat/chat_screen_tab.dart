
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:troptrip/views/chat/chat_screen.dart';
import 'package:troptrip/views/chat/notifications.dart';
import '../../controllers/chat_controller.dart';
import '../../models/user_model.dart';
import '../../themes/app_theme.dart';
import '../../widgets/my_text.dart';

class ChatScreenTabs extends StatefulWidget {
     final UserModel? userModel;
  final User? firebaseUser;
  const ChatScreenTabs({super.key, this.userModel, this.firebaseUser});

  @override
  State<ChatScreenTabs> createState() => _ChatScreenTabsState();
}

class _ChatScreenTabsState extends State<ChatScreenTabs>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: 2, vsync: this); 
  }

  @override
  void dispose() {
    _tabController?.dispose(); // Don't forget to dispose of the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put<ChatController>(ChatController());
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: const CustomChatAppBar(
         // tabController: _tabController,
          appBarTitle: 'kjhk',
        ),
        body: TabBarView(
        //  controller: _tabController,
          children: [
            ChatScreen(
              userModel: widget.userModel,
              firebaseUser: widget.firebaseUser,
            ),
              NotificationsScreen(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Implement FAB action
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class CustomChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String appBarTitle;
  final Widget? leading;
  final Widget? action;
  final TabController? tabController;

  const CustomChatAppBar({
    super.key,
    required this.appBarTitle,
    this.leading,
    this.action,
    this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.0,
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      decoration: BoxDecoration(
        gradient: AppTheme.appGradient(),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TabBar(
        controller: tabController,
        isScrollable: false,
        indicatorColor: Colors.transparent, // Implement with TickerProvider
        tabs: const [
          MyText(
            text: 'Chats',
            size: 18.0,
            color: Colors.white,
          ),
          MyText(
            text: 'Notifications',
            size: 18.0,
            color: Colors.white,
          ),
        ],
        //onTap: controller.changeTab,
      ),
    );
  }

  @override
  Size get preferredSize {
    // Provide your custom height here
    return const Size.fromHeight(120.0);
  }
}
