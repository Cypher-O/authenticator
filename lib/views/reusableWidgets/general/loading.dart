import 'package:authenticator/utilities/imports/generalImport.dart';

class loading extends StatefulWidget {
  final Color color;
  final double strokeWidth;
  final double size;

  const loading({
    super.key,
    this.color = Colors.white,
    this.strokeWidth = 5.5,
    this.size = 45,
  });

  @override
  loadingState createState() => loadingState();
}

class loadingState extends State<loading> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.rotate(
            angle: _controller.value * 2.5 * pi,
            child: CircularProgressIndicator(
              strokeWidth: widget.strokeWidth,
              valueColor: AlwaysStoppedAnimation<Color>(widget.color),
              backgroundColor: AppColors.blue(),
            ),
          );
        },
      ),
    );
  }
}


// Widget loading({Color? color}) {
//   return S(
//     h: 45,
//     w: 45,
//     child: CircularProgressIndicator(
//         strokeWidth: 5.5,
//         valueColor: AlwaysStoppedAnimation<Color>(color ?? AppColors.white()),
//         backgroundColor: AppColors.green()),
//   );
// }
