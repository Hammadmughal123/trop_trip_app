import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:troptrip/utils/constants.dart';


class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              decoration: BoxDecoration(
                color: Colors.lightBlue[50],
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Row(
                children: [
                  Image.asset(
                    AppConstants.kSearchIcon,
                    height: 24.0,
                    width: 24.0,
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  const Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search',
                        hintStyle: TextStyle(color: Colors.blue),
                        border: InputBorder.none,
                      ),
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            onPressed: () {
            
            },
            icon: Image.asset(
              AppConstants.kIconProfile,
              height: 40.0,
              width: 40.0,
            ),
          ),

          IconButton(
            onPressed: () {},
            icon: Image.asset(
              AppConstants.kLocationIcon,
              height: 40.0,
              width: 40.0,
            ),
          )
        ],
      ),
    );
  }
}
