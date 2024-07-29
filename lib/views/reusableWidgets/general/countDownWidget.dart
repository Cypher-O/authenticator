import 'package:authenticator/utilities/imports/generalImport.dart';
import 'dart:math' as math;

class CountdownWidget extends StatefulWidget {
  final int duration; // Duration in seconds
  final Function() generateOtp;
  final Function(String) updateOtp;

  const CountdownWidget({
    super.key,
    required this.duration,
    required this.generateOtp,
    required this.updateOtp,
  });

  @override
  CountdownWidgetState createState() => CountdownWidgetState();
}

class CountdownWidgetState extends State<CountdownWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  bool _generatingNewOtp = false;

  // @override
  // void initState() {
  //   super.initState();
  //   _controller = AnimationController(
  //     vsync: this,
  //     duration: Duration(seconds: widget.duration),
  //   );
  //   _controller.addListener(_listener);
  //   _controller.repeat();
  // }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.duration),
    );
    _controller.addListener(_listener);
    _controller.forward();
  }

  void _listener() {
    final double threshold =
        1 - (1 / widget.duration); // 5 seconds before expiry

    if (_controller.value >= threshold && !_generatingNewOtp) {
      _generatingNewOtp = true;
      widget.generateOtp();
    }

    // if (_controller.value >= 0.99) {
    //   _generatingNewOtp = false;
    //   widget.updateOtp(currentOtp);
    //   _controller.reset(); // Reset the controller to start the countdown again
    //   _controller.forward();
    // }
    if (_controller.value >= 0.99) {
      _generatingNewOtp = false;
      widget.updateOtp(generateOtpResponseBucket?.data.first.otp ?? "");
      _controller.reset(); // Reset the controller to start the countdown again
      _controller.forward();
    }

    // if (_controller.isCompleted) {
    //   _generatingNewOtp = false;
    //   widget.updateOtp(currentOtp);
    //   _controller.reset(); // Reset the controller to start the countdown again
    //   _controller.forward();
    // }
  }
  // void _listener() {
  //   if (_controller.value >= 0.83 && !_generatingNewOtp) {  // 5 seconds before expiry (assuming 30-second duration)
  //     _generatingNewOtp = true;
  //     widget.generateOtp();
  //   }
  //   if (_controller.value >= 0.99) {  // Just before the countdown completes
  //     widget.updateOtp(generateOtpResponseBucket?.data.first.otp ?? "");
  //     _generatingNewOtp = false;
  //   }
  // }

  @override
  void dispose() {
    _controller.removeListener(_listener);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: CountdownPainter(
            progress: _controller.value,
            duration: widget.duration,
          ),
          size: const Size(35, 35),
        );
      },
    );
  }
}

class CountdownPainter extends CustomPainter {
  final double progress;
  final int duration;

  CountdownPainter({required this.progress, required this.duration});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..strokeWidth = 4.0
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round;

    double remainingTime = duration * (1 - progress);

    // Color transition: Blue -> Yellow -> Red
    Color color;
    if (remainingTime > duration * 2 / 3) {
      color = AppColors.blue();
    } else if (remainingTime > duration * 1 / 3) {
      color = AppColors.dimYellow;
    } else {
      color = AppColors.red();
    }

    paint.color = color;

    double sweepAngle = -360 * (1 - progress);

    canvas.drawArc(
      Rect.fromCircle(center: size.center(Offset.zero), radius: size.width / 2),
      -90 * (math.pi / 180),
      sweepAngle * (math.pi / 180),
      true,
      paint,
    );
  }

  @override
  bool shouldRepaint(CountdownPainter oldDelegate) {
    return progress != oldDelegate.progress;
  }
}
