import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<SignUp>
    with SingleTickerProviderStateMixin {
  bool lightOn = false;
  late AnimationController _animationController;
  late Animation _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700));
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.bounceInOut));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              if (lightOn)
                AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      return Opacity(
                        opacity: _animation.value,
                        child: CustomPaint(
                          size: Size(size.height / 2.2, size.height / 2.2),
                          painter: LightPainter(),
                        ),
                      );
                    }),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextField(
                    style: theme.textTheme.bodyMedium,
                    textCapitalization: TextCapitalization.words,
                    decoration: const InputDecoration(hintText: 'Username'),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    style: theme.textTheme.bodyMedium,
                    decoration: const InputDecoration(hintText: 'Password'),
                    obscureText: !lightOn,
                  ),
                  const SizedBox(height: 30),
                  Text(
                    'Sign In',
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  )
                ],
              ),
              LightSwitch(
                onDragEnd: () {
                  setState(() {
                    lightOn = !lightOn;
                  });
                  lightOn
                      ? _animationController.forward()
                      : _animationController.reset();
                },
              )
            ],
          )),
    );
  }
}

class LightSwitch extends StatefulWidget {
  final void Function() onDragEnd;
  const LightSwitch({
    Key? key,
    required this.onDragEnd,
  }) : super(key: key);

  @override
  State<LightSwitch> createState() => _LightSwitchState();
}

class _LightSwitchState extends State<LightSwitch> {
  double switchHeight = 80;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: (details) {
        setState(() {
          final trueHeight = details.localPosition.dy - 15;
          switchHeight = trueHeight > 130 ? 130 : trueHeight;
        });
      },
      onVerticalDragEnd: (details) {
        setState(() {
          switchHeight = 80;
          widget.onDragEnd.call();
        });
      },
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            margin: const EdgeInsets.only(top: 15),
            width: 2,
            height: switchHeight,
            color: Colors.white,
          ),
          Container(
            width: 15,
            height: 15,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}

class LightPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final painter = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: [0.1, 0.6, 1.0],
        colors: [Colors.white30, Colors.white10, Colors.transparent],
      ).createShader(
        Rect.fromPoints(
            Offset(size.width / 2, 0), Offset(size.width / 2, size.height)),
      );
    var path = Path();

    path.moveTo(size.width / 2 - 40, 15);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width / 2 + 40, 15);
    path.close();

    canvas.drawPath(path, painter);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
