import 'package:flutter/material.dart';
import 'dart:math';

class JotterScreen extends StatelessWidget {
  const JotterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final double containerWidth = MediaQuery.of(context).size.width - 50;
    // const double containerHeight = 450;
    const double containerWidth = 400;
    const double containerHeight = 400;

    return const Scaffold(
      body: Center(
        child: JotterContainer(
          width: containerWidth,
          height: containerHeight,
          child: Text('Home Indeed'),
        ),
      ),
    );
  }
}

class JotterContainer extends StatelessWidget {
  final double width;
  final double height;
  final Widget? child;

  const JotterContainer({
    super.key,
    required this.width,
    required this.height,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ClipRect(
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: width,
              height: height,
              child: CustomPaint(
                painter: JotterContainerPainter(),
              ),
            ),
            child ?? const SizedBox(),
          ],
        ),
      ),
    );
  }
}

class JotterContainerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // const double notchDiameter = 4;
    // final int noOfNotches = size.width ~/ 16;
    // final double notchSpacing =
    //     (size.width - (noOfNotches * notchDiameter)) / (noOfNotches - 1);

    final paint = Paint()
      ..color = Colors.pink[200] as Color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final path = Path();

    Offset currentPoint = const Offset(0, 0);
    Offset nextPoint = const Offset(0, 0);

    // origin
    path.moveTo(currentPoint.dx, currentPoint.dy);

    // line
    nextPoint = nextPoint.translate(50, 0);
    path.lineTo(nextPoint.dx, nextPoint.dy);

    canvas.drawPath(path, paint);

    // Draw the arc
    path
      ..moveTo(50, 0)
      ..arcTo(
        Rect.fromCircle(
          center: Offset(70, 0),
          radius: 20,
        ),
        pi,
        -pi,
        false,
      );
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
