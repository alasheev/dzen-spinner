import 'dart:math';

import 'package:dzen_tech_spinner/resouces/colors.dart';
import 'package:dzen_tech_spinner/resouces/resources.dart';
import 'package:flutter/material.dart';

class ControlPage extends StatefulWidget {
  final String deviceName;

  ControlPage(this.deviceName);

  @override
  State<ControlPage> createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
  bool _stopPlatform = false;
  int _speed = 28;
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        colorScheme:
            Theme.of(context).colorScheme.copyWith(primary: Colors.white),
      ),
      child: Scaffold(
        backgroundColor: AppColors.grey,
        appBar: AppBar(
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
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Image.asset('assets/back.png'),
                ),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          color: AppColors.grey,
                        ),
                      ),
                    ),
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'DISCONNECT',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.defaultText,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Padding(
          padding:
              const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 80),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _stopPlatform = !_stopPlatform;
                  });
                },
                child: Row(
                  children: [
                    _checkBox(),
                    const SizedBox(width: 15),
                    Text(
                      'Stop platform when disconnected',
                      style: AppTextStyles.defaultText,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              _statusBox(),
              const SizedBox(height: 20),
              Text('Speed', style: AppTextStyles.defaultText),
              _slider(context),
              const Expanded(child: SizedBox.shrink()),
              SizedBox(
                height: 70,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(
                            const Size(double.maxFinite, 0),
                          ),
                          backgroundColor:
                              MaterialStateProperty.all(AppColors.green),
                          padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(vertical: 20),
                          ),
                        ),
                        child: Text(
                          'START',
                          style: AppTextStyles.buttonText,
                        ),
                      ),
                    ),
                    const SizedBox(width: 30),
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(
                            const Size(double.maxFinite, 0),
                          ),
                          backgroundColor:
                              MaterialStateProperty.all(AppColors.red),
                          padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(vertical: 20),
                          ),
                        ),
                        child: Text(
                          'STOP',
                          style: AppTextStyles.buttonText,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  SliderTheme _slider(BuildContext context) {
    return SliderTheme(
      data: Theme.of(context).sliderTheme.copyWith(
            trackHeight: 10.0,
            thumbShape: const SliderThumbShape(
              disabledThumbRadius: 10,
              elevation: 3,
              enabledThumbRadius: 15,
              pressedElevation: 3,
            ),
            // trackShape: CustomTrackShape(),
          ),
      child: Slider(
        value: _speed.toDouble(),
        onChanged: (value) {
          setState(() {
            _speed = value.toInt();
          });
        },
        min: 1,
        max: 100,
        activeColor: Colors.white,
        inactiveColor: Colors.white,
        thumbColor: AppColors.green,
      ),
    );
  }

  Widget _checkBox() {
    return Container(
      width: 35,
      height: 35,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      child: _stopPlatform
          ? const Center(
              child: Icon(
                Icons.check,
                color: Colors.black,
                size: 32,
              ),
            )
          : const SizedBox.shrink(),
    );
  }

  Widget _statusBox() {
    return Container(
      height: 250,
      width: double.maxFinite,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.black,
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Connected device: -UNNAMED-',
            style: AppTextStyles.defaultText,
          ),
          const SizedBox(height: 20),
          Text(
            'Platform is running',
            style: AppTextStyles.defaultText,
          ),
          const SizedBox(height: 20),
          Text(
            'Speed: $_speed%',
            style: AppTextStyles.defaultText,
          ),
        ],
      ),
    );
  }
}

class SliderThumbShape extends SliderComponentShape {
  const SliderThumbShape({
    required this.enabledThumbRadius,
    required this.disabledThumbRadius,
    required this.elevation,
    required this.pressedElevation,
  });
  final double enabledThumbRadius;

  /// [enabledThumbRadius]
  final double disabledThumbRadius;
  double get _disabledThumbRadius => disabledThumbRadius;

  ///
  final double elevation;
  final double pressedElevation;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(
        isEnabled == true ? enabledThumbRadius : _disabledThumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;
    final Tween<double> radiusTween = Tween<double>(
      begin: _disabledThumbRadius,
      end: enabledThumbRadius,
    );

    final double radius = radiusTween.evaluate(enableAnimation);

    final Tween<double> elevationTween = Tween<double>(
      begin: elevation,
      end: pressedElevation,
    );

    final double evaluatedElevation =
        elevationTween.evaluate(activationAnimation);

    {
      final Path path = Path()
        ..addArc(
            Rect.fromCenter(
                center: center, width: 1 * radius, height: 1 * radius),
            0,
            pi * 2);

      Paint paint = Paint()..color = Colors.white;
      paint.strokeWidth = 8;
      paint.style = PaintingStyle.stroke;
      canvas.drawCircle(
        center,
        radius,
        paint,
      );
      {
        Paint paint = Paint()..color = AppColors.green;
        paint.style = PaintingStyle.fill;
        canvas.drawCircle(
          center,
          radius,
          paint,
        );
      }
    }
  }
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight!;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
