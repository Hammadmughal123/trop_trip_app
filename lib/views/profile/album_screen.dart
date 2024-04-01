import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:troptrip/controllers/profile_controller.dart';
import 'package:troptrip/themes/app_theme.dart';
import 'package:troptrip/widgets/custom_appbar.dart';

class AlbumScreen extends StatefulWidget {
  final String albumName;
  final List<String> albumList;
  const AlbumScreen(
      {super.key, required this.albumName, required this.albumList});

  @override
  State<AlbumScreen> createState() => _AlbumScreenState();
}

class _AlbumScreenState extends State<AlbumScreen> {
  final profileCtrl = Get.put<ProfileController>(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appBarTitle: widget.albumName,
        action: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.add,
            color: AppTheme.whiteColor,
          ),
        ),
      ),
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: Padding(
          padding: EdgeInsets.all(15.0,),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 0.7,
            ),
            itemCount: widget.albumList.length,
            itemBuilder: (context, index) {
              return Image.asset(
                widget.albumList[index],
                fit: BoxFit.fill,
              ); // Replace with the actual image paths
            },
          ),
        ),
      ),
    );
  }
}
