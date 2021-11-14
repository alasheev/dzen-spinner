import 'dart:async';

import 'package:dzen_tech_spinner/resouces/colors.dart';
import 'package:dzen_tech_spinner/resouces/resources.dart';
import 'package:dzen_tech_spinner/widgets/device_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:permission_handler/permission_handler.dart';

class DevicesPage extends StatefulWidget {
  @override
  State<DevicesPage> createState() => _DevicesPageState();
}

class _DevicesPageState extends State<DevicesPage> {
  final _flutterReactiveBle = FlutterReactiveBle();

  Set<DiscoveredDevice> _devices = {};

  late final Stream<DiscoveredDevice> _deviceStream;

  late final StreamSubscription<DiscoveredDevice> _subscription;

  _initialLoadDevices() {
    _subscription = _deviceStream.listen((device) {
      setState(() {
        if (_devices.add(device)) {
          print('new device $device');
        }
      });
    });

    Future.delayed(const Duration(seconds: 3), () {
      _subscription.pause();
    });
  }

  _reloadDevices() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Permission.location.request().then((value) => print('permission $value'));
    });

    _devices.clear();

    _subscription.resume();

    Future.delayed(const Duration(seconds: 3), () {
      _subscription.pause();
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Permission.location.request().then((value) => print('permission $value'));
    });

    _deviceStream = _flutterReactiveBle.scanForDevices(
      withServices: [],
      requireLocationServicesEnabled: false,
    );

    _initialLoadDevices();

    super.initState();
  }

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
            height: 80,
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
                    onPressed: () async {
                      _reloadDevices();
                    },
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
          itemCount: _devices.length,
          itemBuilder: (context, i) {
            return DeviceCard(
                _devices.toList()[i].name == ''
                    ? '-UNNAMED-'
                    : _devices.toList()[i].name,
                _devices.toList()[i].id);
          },
        ),
      ),
    );
  }
}
