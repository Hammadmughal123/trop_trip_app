import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:troptrip/controllers/notification_controller.dart';
import 'package:troptrip/widgets/my_text.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  String? selectedBrand;
  final NotificationController controller =
      Get.put<NotificationController>(NotificationController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationController>(builder: (ctrl) {
      return Scaffold(
        body: Center(
          child: Column(
            children: [
              DropdownButtonHideUnderline(
                  child: DropdownButton(
                      value: controller.selectedBrand,
                      hint: Text('Select brand'),
                      dropdownColor: Colors.blueAccent,
                      isExpanded: true,
                      items: ['1', '2', '3']
                          .map(
                            (e) => DropdownMenuItem(
                              child: Text(e),
                              value: e,
                            ),
                          )
                          .toList(),
                      onChanged: (String? value) {
                        ctrl.changeValue(value);
                      })),
              Radio(
                  value: '0',
                  groupValue: ctrl.selectedChip,
                  onChanged: (value) {
                    ctrl.changeRadioValue(value.toString());
                  }),
              Radio(
                  value: '1',
                  groupValue: ctrl.selectedChip,
                  onChanged: (value) {
                    ctrl.changeRadioValue(value.toString());
                  }),
                Wrap(
                  children: [
                    Chip(label: Text('')),
                    Chip(label: Text('')),
                    Chip(label: Text(''))

                  ],
                ),
              MyText(text: 'No Notifications'),
            ],
          ),
        ),
      );
    });
  }
}
