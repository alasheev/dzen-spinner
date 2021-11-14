import 'package:dzen_tech_spinner/resouces/colors.dart';
import 'package:dzen_tech_spinner/resouces/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'devices_page.dart';

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _flutterReactiveBle = FlutterReactiveBle();

  late SharedPreferences _prefs;

  String? _lastDevice;

  @override
  void initState() {
    _initPrefs();

    /*
    поток, получающий статус блютуз.
    если блютуз выключен, то появляется всплывающее окно
    которое говорит включить блютуз и блокирует приложение
    */
    _flutterReactiveBle.statusStream.listen((status) {
      if (status == BleStatus.poweredOff) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return _bluetoothDialog();
          },
        );
      }
    });
    super.initState();
  }

  _initPrefs() async {
    // инициализация хранилища
    _prefs = await SharedPreferences.getInstance();

    /*
    получение последнего использовавшегося устройства
    если нет, то null 
    */
    setState(() {
      _lastDevice = _prefs.getString('lastDevice');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkGrey,
      appBar: AppBar(
        backgroundColor: AppColors.darkGrey,
        elevation: 0,
      ),
      body: Theme(
        data: Theme.of(context).copyWith(
          colorScheme: Theme.of(context)
              .colorScheme
              .copyWith(primary: Colors.white, secondary: Colors.white),
        ),
        child: Container(
          width: double.maxFinite,
          padding: const EdgeInsets.only(
            bottom: 50,
            left: 20,
            right: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/splash.png'),
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
                /*
                если последнее устройство == null,
                то кнопка CONNECT неактивна
                */
                onPressed: _lastDevice != null ? () {} : null,
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(
                    const Size(double.maxFinite, 0),
                  ),
                  backgroundColor: MaterialStateProperty.all(
                      _lastDevice != null ? AppColors.green : AppColors.grey),
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

  Widget _bluetoothDialog() {
    BleStatus? currentStatus;
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      backgroundColor: AppColors.darkGrey,
      content: WillPopScope(
        child: StreamBuilder<BleStatus>(
          stream: _flutterReactiveBle.statusStream,
          builder: (context, AsyncSnapshot<BleStatus> snapshot) {
            currentStatus = snapshot.data;

            /*
            как только юзер включит блютуз,
            окно пропадёт
            */
            if (snapshot.data == BleStatus.ready) {
              Navigator.of(context).pop();
            }
            if (snapshot.data == BleStatus.poweredOff) {
              return Container(
                height: 200,
                width: 200,
                alignment: Alignment.center,
                child: Text(
                  'Please turn Bluetooth ON to use app',
                  style: AppTextStyles.defaultText,
                ),
              );
            }
            return Container(
              height: 200,
              width: 200,
              alignment: Alignment.center,
              child: const CircularProgressIndicator(
                color: AppColors.purple,
              ),
            );
          },
        ),
        onWillPop: () {
          return Future.value(
              (currentStatus != BleStatus.poweredOff) ? true : false);
        },
      ),
    );
  }
}
