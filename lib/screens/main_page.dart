import 'package:dzen_tech_spinner/resouces/colors.dart';
import 'package:dzen_tech_spinner/resouces/resources.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'devices_page.dart';

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool _deviceFound = false;
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        colorScheme: Theme.of(context)
            .colorScheme
            .copyWith(primary: Colors.white, secondary: Colors.white),
      ),
      child: Scaffold(
        backgroundColor: AppColors.darkGrey,
        appBar: AppBar(
          backgroundColor: AppColors.darkGrey,
          elevation: 0,
        ),
        body: Container(
          width: double.maxFinite,
          padding: const EdgeInsets.only(
            bottom: 50,
            left: 20,
            right: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                child: Image.asset('assets/splash.png'),
                onTap: () {
                  setState(() {
                    _deviceFound = !_deviceFound;
                  });
                },
              ),
              const SizedBox(height: 50),
              Text(
                'No device selected',
                style: AppTextStyles.defaultText,
              ),
              const Expanded(child: SizedBox.shrink()),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => DevicesPage()));
                },
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(
                    const Size(double.maxFinite, 0),
                  ),
                  backgroundColor: MaterialStateProperty.all(AppColors.purple),
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(vertical: 20),
                  ),
                ),
                child: Text(
                  'FIND DEVICE',
                  style: AppTextStyles.buttonText,
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: _deviceFound ? () {} : null,
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(
                    const Size(double.maxFinite, 0),
                  ),
                  backgroundColor: MaterialStateProperty.all(
                      _deviceFound ? AppColors.green : AppColors.grey),
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(vertical: 20),
                  ),
                ),
                child: Text(
                  'CONNECT',
                  style: AppTextStyles.buttonText,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
