import 'package:dzen_tech_spinner/resouces/colors.dart';
import 'package:dzen_tech_spinner/resouces/resources.dart';
import 'package:dzen_tech_spinner/widgets/device_card.dart';
import 'package:flutter/material.dart';

class DevicesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        colorScheme:
            Theme.of(context).colorScheme.copyWith(secondary: Colors.white),
      ),
      child: Scaffold(
        backgroundColor: AppColors.grey,
        appBar: AppBar(
          centerTitle: false,
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.darkGrey,
          elevation: 0,
          titleSpacing: 0,
          title: SizedBox(
            height: 50,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextButton(
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(Colors.white10),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Image.asset('assets/back.png'),
                ),
                Expanded(
                  flex: 2,
                  child: IntrinsicHeight(
                    child: Container(
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        border: Border(
                          left: BorderSide(color: AppColors.grey),
                          right: BorderSide(color: AppColors.grey),
                        ),
                      ),
                      child: Text(
                        'Devices',
                        style: AppTextStyles.defaultText,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: TextButton(
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(Colors.white10),
                    ),
                    onPressed: () {},
                    child: Text(
                      'SCAN',
                      style: AppTextStyles.defaultText,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: ListView.builder(
          padding: const EdgeInsets.only(bottom: 20),
          itemCount: 10,
          itemBuilder: (context, index) {
            print(Theme.of(context).colorScheme.primary);
            return DeviceCard('-UNNAMED-', 'device description');
          },
        ),
      ),
    );
  }
}
