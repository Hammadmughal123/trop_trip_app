import 'package:get/get.dart';

class NotificationController extends GetxController {
  String? selectedBrand;
  String? selectedChip;

  Future<void> changeValue(String? value) async {
    selectedBrand = value;
    update();
  }

  Future<void> changeRadioValue(String? value) async {
    selectedChip = value;
    update();
  }
} 
