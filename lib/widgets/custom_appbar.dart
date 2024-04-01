import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:troptrip/themes/app_theme.dart';
import 'package:troptrip/widgets/my_text.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String appBarTitle;
  final Widget? leading;
  final Widget? action;
  
  const CustomAppBar({
    super.key,
    required this.appBarTitle,
   this.leading, this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      decoration: BoxDecoration(
        gradient: AppTheme.appGradient(),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0, top: 20.0, bottom: 20.0),
        child: Row(
          children: [
           leading == null ? const SizedBox() : leading!,
            Expanded(
              child: MyText(
                text: appBarTitle,
                size: 20,
                align: TextAlign.center,
                weight: FontWeight.bold,
                color: AppTheme.whiteColor,
              ),
            ),
            action == null ? const SizedBox() : action!,
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize {
    // Provide your custom height here
    return Size.fromHeight(60.0);
  }
}
