import 'package:dzen_tech_spinner/resouces/resources.dart';
import 'package:dzen_tech_spinner/screens/control_page.dart';
import 'package:flutter/material.dart';

class DeviceCard extends StatelessWidget {
  final String title;

  final String subtitle;

  DeviceCard(this.title, this.subtitle);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => ControlPage(title)),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        constraints: const BoxConstraints(
          minHeight: 80,
          minWidth: double.maxFinite,
        ),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.white),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(title, style: AppTextStyles.defaultText),
            Text(subtitle, style: AppTextStyles.defaultText),
          ],
        ),
      ),
    );
  }
}
