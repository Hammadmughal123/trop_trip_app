import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:troptrip/views/home/country_plan_screen.dart';
import 'package:troptrip/widgets/custom_appbar.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CountriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(appBarTitle: 'Countries'),
      body: ListView(
        children: <Widget>[
          _buildCountryTile(
              'United States', 'New York', 'assets/icons/usflag.svg', context),
          _buildCountryTile(
              'Canada', 'Toronto', 'assets/icons/caflag.svg', context),
          _buildCountryTile(
              'South Korea', 'Seoul', 'assets/icons/skflag.svg', context),
          // Add more tiles...
        ],
      ),
    );
  }

  ListTile _buildCountryTile(
      String country, String capital, String image, BuildContext context) {
    return ListTile(
      leading: Container(
        height: 50.0,
        width: 50.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: ClipOval(
          child: SvgPicture.asset(image),
        ),
      ),
      title: Text(country),
      subtitle: Text(capital),
      trailing: Icon(Icons.chevron_right,
          color: Colors.blue), // Adjust color as needed
      onTap: () {
        Get.to(() => CountryPlanScreen());
      },
    );
  }
}
