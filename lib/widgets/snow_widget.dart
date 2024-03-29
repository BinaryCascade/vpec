// Snow by https://github.com/windwp/
// Repo: https://github.com/windwp/flutter-snow-effect
// Modified by ShyroTeam

import 'dart:math';

import 'package:flutter/material.dart';

class SnowWidget extends StatefulWidget {
  final int? totalSnow;
  final double? speed;
  final bool? isRunning;
  final Color? snowColor;

  const SnowWidget({
    Key? key,
    this.totalSnow,
    this.speed,
    this.isRunning,
    this.snowColor,
  }) : super(key: key);

  @override
  State<SnowWidget> createState() => _SnowWidgetState();
}

class _SnowWidgetState extends State<SnowWidget>
    with SingleTickerProviderStateMixin {
  late Random _rnd;
  AnimationController? controller;
  Animation? animation;
  List<Snow>? _snows;
  double angle = 0;
  double W = 0;
  double H = 0;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() {
    _rnd = Random();
    if (controller == null) {
      controller = AnimationController(
        lowerBound: 0,
        upperBound: 1,
        vsync: this,
        duration: const Duration(milliseconds: 20000),
      );
      controller!.addListener(() {
        if (mounted) {
          setState(() {
            update();
          });
        }
      });
    }
    if (!widget.isRunning!) {
      controller!.stop();
    } else {
      controller!.repeat();
    }
  }

  @override
  dispose() {
    controller!.dispose();
    super.dispose();
  }

  void _createSnow() {
    _snows = [];
    for (var i = 0; i < widget.totalSnow!; i++) {
      _snows!.add(Snow(
        x: _rnd.nextDouble() * W,
        y: _rnd.nextDouble() * H,
        r: _rnd.nextDouble() * 4 + 1,
        d: _rnd.nextDouble() * widget.speed!,
      ));
    }
  }

  void update() {
    angle += 0.01;
    if (_snows == null || widget.totalSnow != _snows!.length) {
      _createSnow();
    }
    for (var i = 0; i < widget.totalSnow!; i++) {
      var snow = _snows![i];
      //We will add 1 to the cos function to prevent negative values which will lead flakes to move upwards
      //Every particle has its own density which can be used to make the downward movement different for each flake
      //Lets make it more random by adding in the radius
      snow.y =
          snow.y! + (cos(angle + snow.d!) + 1 + snow.r! / 2) * widget.speed!;
      snow.x = snow.x! + sin(angle) * 2 * widget.speed!;
      if (snow.x! > W + 5 || snow.x! < -5 || snow.y! > H) {
        if (i % 3 > 0) {
          //66.67% of the flakes
          _snows![i] =
              Snow(x: _rnd.nextDouble() * W, y: -10, r: snow.r, d: snow.d);
        } else {
          //If the flake is exiting from the right
          if (sin(angle) > 0) {
            //Enter from the left
            _snows![i] =
                Snow(x: -5, y: _rnd.nextDouble() * H, r: snow.r, d: snow.d);
          } else {
            //Enter from the right
            _snows![i] =
                Snow(x: W + 5, y: _rnd.nextDouble() * H, r: snow.r, d: snow.d);
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isRunning! && !controller!.isAnimating) {
      controller!.repeat();
    } else if (!widget.isRunning! && controller!.isAnimating) {
      controller!.stop();
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        if (_snows == null) {
          W = constraints.maxWidth;
          H = constraints.maxHeight;
        }

        return CustomPaint(
          willChange: widget.isRunning!,
          painter: SnowPainter(
            // progress: controller.value,
            isRunning: widget.isRunning,
            snows: _snows,
            snowColor: widget.snowColor,
          ),
          size: Size.infinite,
        );
      },
    );
  }
}

class Snow {
  double? x;
  double? y;
  double? r; //radius
  double? d; //density
  Snow({this.x, this.y, this.r, this.d});
}

class SnowPainter extends CustomPainter {
  List<Snow>? snows;
  bool? isRunning;
  Color? snowColor;

  SnowPainter({this.isRunning, this.snows, this.snowColor});

  @override
  void paint(Canvas canvas, Size size) {
    if (snows == null || !isRunning!) return;
    //draw circle
    final Paint paint = Paint()
      ..color = snowColor!
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 10.0;
    for (var i = 0; i < snows!.length; i++) {
      var snow = snows![i];
      canvas.drawCircle(Offset(snow.x!, snow.y!), snow.r!, paint);
    }
  }

  @override
  bool shouldRepaint(SnowPainter oldDelegate) => isRunning!;
}
