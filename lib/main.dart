import 'package:flutter/material.dart';
import 'dart:math' show pi;

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(brightness: Brightness.dark, useMaterial3: true),
      darkTheme: ThemeData(brightness: Brightness.dark, useMaterial3: true),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  int milliseconds = 800;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: milliseconds),
    );

    _animation = Tween<double>(
      begin: 0.0,
      end: 2 * pi,
    ).animate(_controller);
    _controller.repeat();
  }

  void changeDuration(int milliSeconds) {
    _controller.duration = Duration(milliseconds: milliSeconds);
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /* 
  0.0 = 0 degrees
  0.5 = 180 degrees
  1.0 = 360 degrees
  */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: AnimatedBuilder(
              animation: _animation,
              builder: (animatedContext, child) {
                return Transform(
                  alignment: Alignment.center,
                  // origin: const Offset(50,50),
                  transform: Matrix4.identity()
                    ..rotateZ(
                      _animation.value,
                    ),
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Slider(
            value: milliseconds.toDouble(),
            min: 1.0,
            max: 1000.0,
            onChanged: (double value) {
              milliseconds = value.toInt();
              setState(() {});
            },
            onChangeEnd: (double value) {
              setState(() {
                changeDuration(milliseconds);
              });
            },
          )
        ],
      ),
    );
  }
}
