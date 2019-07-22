// En esta clase definiremos el crono de cuenta atrás para los asaltos.
// Usaremos Custom Paint y Animations
// Siguiendo el videotutorial https://www.youtube.com/watch?v=tRe8teyf9Nk

import 'package:flutter/material.dart';
import 'dart:math' as math;

class MyCountdownTimer extends StatefulWidget {
  String chrono;

  MyCountdownTimer(this.chrono);

  String getChrono() {
    return this.chrono;
  }

  @override
  _MyCountdownTimerState createState() => _MyCountdownTimerState();
}

class _MyCountdownTimerState extends State<MyCountdownTimer>
    with TickerProviderStateMixin {
  AnimationController controller;

  String get timerString {
    Duration duration = controller.duration * controller.value;
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
    // padLeft(2, '0') sirve para que aunque el número de segundos sea de una sola cifra se le añadira un cero antes.  5 -> 05
  }

  @override
  void initState() {
    super.initState();
    widget.chrono = timerString;
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 120), // 2 minutos.
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Column(
      children: <Widget>[
        LimitedBox(
          maxWidth: MediaQuery.of(context).size.width / 3,
          maxHeight: MediaQuery.of(context).size.height / 3,
          child: Align(
            alignment: FractionalOffset.center,
            child: AspectRatio(
              aspectRatio: 1.0,
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: AnimatedBuilder(
                      animation: controller,
                      builder: (BuildContext context, Widget child) {
                        return CustomPaint(
                          painter: TimerPainter(
                            animation: controller,
                            backgroundColor: Colors.white,
                            color: Colors.green,
                          ),
                        );
                      },
                    ),
                  ),
                  Align(
                    alignment: FractionalOffset.center,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Crono",
                            style: themeData.textTheme.subhead,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: AnimatedBuilder(
                            animation: controller,
                            builder: (BuildContext context, Widget child) {
                              return Text(
                                timerString,
                                style: themeData.textTheme.display4,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FloatingActionButton(
                backgroundColor: (controller.isAnimating ? Colors.green : Colors.green),
                child: AnimatedBuilder(
                    animation: controller,
                    builder: (BuildContext context, Widget child) {
                      return Icon(controller.isAnimating
                          ? Icons.pause
                          : Icons.play_arrow);
                    }),
                onPressed: () {
                  if (controller.isAnimating) {
                    controller.stop();
                  } else {
                    controller.reverse(
                        from: controller.value == 0.0 ? 1.0 : controller.value);
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// CustomPainter
class TimerPainter extends CustomPainter {
  final Animation<double> animation;
  final Color backgroundColor, color;

  TimerPainter({this.animation, this.backgroundColor, this.color})
      : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color =
          backgroundColor // El operador .. (cascade) sirve para añadir propiedades a este objeto de tipo Paint.
      ..strokeWidth = 5.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2.0,
        paint); // Offset, radius and painter.
    paint.color = color;
    double progress =
        (1.0 - animation.value) * 2 * math.pi; // Convert progress into radius
    canvas.drawArc(Offset.zero & size, math.pi * 1.5, -progress, false, paint);
  }

  @override
  bool shouldRepaint(TimerPainter old) {
    return animation.value != old.animation.value ||
        color != old.color ||
        backgroundColor != old.backgroundColor;
  }
}
