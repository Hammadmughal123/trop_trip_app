import 'package:flutter/material.dart';
import 'package:troptrip/themes/app_theme.dart';
import 'package:troptrip/widgets/my_text.dart';

class MapWidgets extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onTap;
  const MapWidgets(
      {super.key, required this.text, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85.0,
      width: 50.0,
      decoration: BoxDecoration(
        //border: Border.all(color: Colors.red, width: 5.0)
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: onTap,
              child: Card(
                elevation: 10.0,
                shape: const CircleBorder(),
                color: Colors.transparent,
                child: Container(
                  height: 40.0,
                  width: 40.0,
                  decoration: const BoxDecoration(
                    color: AppTheme.whiteColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    size: 25.0,
                    color: AppTheme.primaryColor,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            MyText(
              text: text,
              color: AppTheme.primaryColor,
              weight: FontWeight.bold,
              size: 10.0,
              maxlines: 2,
              align: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
