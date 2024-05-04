import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 100,bottom: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ScaleButton2(),
              ScaleButton1(),


            ],
          ),
        ),
      ),
    );
  }
}

//Customized Button
class ScaleButton1 extends StatefulWidget {
  @override
  _ScaleButton1State createState() => _ScaleButton1State();
}

class _ScaleButton1State extends State<ScaleButton1>
    with TickerProviderStateMixin {
  late AnimationController _controller1;
  late AnimationController _controller2;
  late AnimationController _controllerRotate;

  late Tween<double> _offsetTween1,
      _offsetTween2,
      _offsetTween3,
      _offsetTween4,
      _scaleTween,
      _iconOpacity,
      _rotateTween;
  late Animation _offsetAnimation1,
      _offsetAnimation2,
      _offsetAnimation3,
      _offsetAnimation4,
      _scaleAnimation,
      _iconOpacityAnimation,
      _rotateAnimation;

  late Tween<double> _borderRadiusTween;
  late Animation _borderRadiusAnimation;

  @override
  void initState() {
    //Controller for first Transform translate
    _controller1 =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    _borderRadiusTween = Tween(begin: 0, end: 5);
    _borderRadiusAnimation = _borderRadiusTween.animate(_controller1);
    _offsetTween1 = Tween(begin: 0, end: -5)..animate(_controller1);
    _offsetAnimation1 = _offsetTween1.animate(_controller1)
      ..addListener(() {
        setState(() {});
      });
    _offsetTween2 = Tween(begin: 30, end: 35)..animate(_controller1);
    _offsetAnimation2 = _offsetTween2.animate(_controller1)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controllerRotate.forward();
        } else {
          _controllerRotate.reverse();
        }
      });
    //Controller to Rotate
    _controllerRotate =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    _rotateTween = Tween(begin: 0, end: 45);
    _rotateAnimation = _rotateTween.animate(_controllerRotate)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller2.forward();
        } else {
          _controller2.reverse();
        }
      });
    //Second Controller for Trasnform translate
    _controller2 =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    _offsetTween3 = Tween(begin: 0, end: -20)..animate(_controller2);
    _offsetAnimation3 = _offsetTween3.animate(_controller2)
      ..addListener(() {
        setState(() {});
      });
    _offsetTween4 = Tween(begin: 0, end: 20)..animate(_controller2);
    _offsetAnimation4 = _offsetTween4.animate(_controller2)
      ..addListener(() {
        setState(() {});
      });
    _scaleTween = Tween(begin: 1, end: 1.5)..animate(_controller2);
    _scaleAnimation = _scaleTween.animate(_controller2)
      ..addListener(() {
        setState(() {});
      });
    _iconOpacity = Tween(begin: 0, end: 1);
    _iconOpacityAnimation = _iconOpacity.animate(_controller2)
      ..addListener(() {
        setState(() {});
      });

    super.initState();
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controllerRotate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double degrees2Radians = pi / 180.0;
    return Transform.rotate(
      angle: degrees2Radians * _rotateAnimation.value,
      child: SizedBox(
        height: 60,
        width: 60,
        child: Stack(children: [
          Transform.translate(
            offset: Offset(_offsetAnimation3.value, _offsetAnimation3.value),
            child: Transform.translate(
              offset: Offset(_offsetAnimation1.value, _offsetAnimation1.value),
              child: Transform.scale(
                scale: _scaleAnimation.value,
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(5),
                      topRight: Radius.circular(_borderRadiusAnimation.value),
                      bottomRight:
                          Radius.circular(_borderRadiusAnimation.value),
                      bottomLeft: Radius.circular(_borderRadiusAnimation.value),
                    ),
                  ),
                  child: Transform.rotate(
                    angle: degrees2Radians * 315,
                    child: Icon(
                      Icons.chat_bubble_outline,
                      color: _controller1.isCompleted? Colors.orange:Colors.white,
                      size: 16,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(_offsetAnimation4.value, _offsetAnimation3.value),
            child: Transform.translate(
              offset: Offset(_offsetAnimation2.value, _offsetAnimation1.value),
              child: Transform.scale(
                scale: _scaleAnimation.value,
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(_borderRadiusAnimation.value),
                      topRight: const Radius.circular(5),
                      bottomRight:
                          Radius.circular(_borderRadiusAnimation.value),
                      bottomLeft: Radius.circular(_borderRadiusAnimation.value),
                    ),
                  ),
                  child: Transform.rotate(
                    angle: degrees2Radians * 315,
                    child: Icon(
                      Icons.voice_chat,
                      color: _controller1.isCompleted? Colors.orange:Colors.white,
                      size: 16,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Transform.translate(
          //   offset: Offset(_offsetAnimation4.value, _offsetAnimation4.value),
          //   child: Transform.translate(
          //     offset: Offset(_offsetAnimation2.value, _offsetAnimation2.value),
          //     child: Transform.scale(
          //       scale: _scaleAnimation.value,
          //       child: Container(
          //         height: 30,
          //         width: 30,
          //         decoration: BoxDecoration(
          //           borderRadius: BorderRadius.only(
          //             topLeft: Radius.circular(_borderRadiusAnimation.value),
          //             topRight: Radius.circular(_borderRadiusAnimation.value),
          //             bottomRight: Radius.circular(5),
          //             bottomLeft: Radius.circular(_borderRadiusAnimation.value),
          //           ),
          //           color: Colors.deepPurple,
          //         ),
          //         child: Transform.rotate(
          //           angle: degrees2Radians * 315,
          //           child: Icon(
          //             Icons.settings,
          //             color: Color.fromRGBO(
          //                 250, 250, 250, _iconOpacityAnimation.value),
          //             size: 16,
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          Transform.translate(
            offset: Offset(_offsetAnimation3.value, _offsetAnimation4.value),
            child: Transform.translate(
              offset: Offset(_offsetAnimation1.value, _offsetAnimation2.value),
              child: Transform.scale(
                scale: _scaleAnimation.value,
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(_borderRadiusAnimation.value),
                      topRight: Radius.circular(_borderRadiusAnimation.value),
                      bottomRight:
                          Radius.circular(_borderRadiusAnimation.value),
                      bottomLeft: const Radius.circular(5),
                    ),
                  ),
                  child: Icon(
                    Icons.attach_file,
                    color: _controller1.isCompleted? Colors.orange:Colors.white,
                    size: 16,
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                if(_controller1.isCompleted){
                  _controller1.reverse();
                } else {
                  _controller1.forward();
                }

              },
              child: const Icon(Icons.add, color: Colors.indigo, size: 40),
            ),
          ),
        ]),
      ),
    );
  }
}




//Customized Button
class ScaleButton2 extends StatefulWidget {
  @override
  _ScaleButton2State createState() => _ScaleButton2State();
}

class _ScaleButton2State extends State<ScaleButton2>
    with TickerProviderStateMixin {
  late AnimationController _controller1;
  late AnimationController _controller2;
  late AnimationController _controllerRotate;

  late Tween<double> _offsetTween1,
      _offsetTween2,
      _offsetTween3,
      _offsetTween4,
      _scaleTween,
      _iconOpacity,
      _rotateTween;
  late Animation _offsetAnimation1,
      _offsetAnimation2,
      _offsetAnimation3,
      _offsetAnimation4,
      _scaleAnimation,
      _iconOpacityAnimation,
      _rotateAnimation;

  late Tween<double> _borderRadiusTween;
  late Animation _borderRadiusAnimation;

  @override
  void initState() {
    //Controller for first Transform translate
    _controller1 =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    _borderRadiusTween = Tween(begin: 0, end: 5);
    _borderRadiusAnimation = _borderRadiusTween.animate(_controller1);
    _offsetTween1 = Tween(begin: 0, end: -5)..animate(_controller1);
    _offsetAnimation1 = _offsetTween1.animate(_controller1)
      ..addListener(() {
        setState(() {});
      });
    _offsetTween2 = Tween(begin: 30, end: 35)..animate(_controller1);
    _offsetAnimation2 = _offsetTween2.animate(_controller1)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controllerRotate.forward();
        } else {
          _controllerRotate.reverse();
        }
      });
    //Controller to Rotate
    _controllerRotate =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    _rotateTween = Tween(begin: 0, end: 45);
    _rotateAnimation = _rotateTween.animate(_controllerRotate)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller2.forward();
        } else {
          _controller2.reverse();
        }
      });
    //Second Controller for Trasnform translate
    _controller2 =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    _offsetTween3 = Tween(begin: 0, end: -20)..animate(_controller2);
    _offsetAnimation3 = _offsetTween3.animate(_controller2)
      ..addListener(() {
        setState(() {});
      });
    _offsetTween4 = Tween(begin: 0, end: 20)..animate(_controller2);
    _offsetAnimation4 = _offsetTween4.animate(_controller2)
      ..addListener(() {
        setState(() {});
      });
    _scaleTween = Tween(begin: 1, end: 1.5)..animate(_controller2);
    _scaleAnimation = _scaleTween.animate(_controller2)
      ..addListener(() {
        setState(() {});
      });
    _iconOpacity = Tween(begin: 0, end: 1);
    _iconOpacityAnimation = _iconOpacity.animate(_controller2)
      ..addListener(() {
        setState(() {});
      });

    super.initState();
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controllerRotate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double degrees2Radians = pi / 180.0;
    return Transform.rotate(
      angle: degrees2Radians * _rotateAnimation.value,
      child: SizedBox(
        height: 60,
        width: 60,
        child: Stack(children: [
          Transform.translate(
            offset: Offset(_offsetAnimation3.value, _offsetAnimation3.value),
            child: Transform.translate(
              offset: Offset(_offsetAnimation1.value, _offsetAnimation1.value),
              child: Transform.scale(
                scale: _scaleAnimation.value,
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(5),
                      topRight: Radius.circular(_borderRadiusAnimation.value),
                      bottomRight:
                      Radius.circular(_borderRadiusAnimation.value),
                      bottomLeft: Radius.circular(_borderRadiusAnimation.value),
                    ),
                    color: Colors.deepPurple,
                  ),
                  child: Transform.rotate(
                    angle: degrees2Radians * 315,
                    child: Icon(
                      Icons.chat_bubble_outline,
                      color: Color.fromRGBO(
                          250, 250, 250, _iconOpacityAnimation.value),
                      size: 16,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(_offsetAnimation4.value, _offsetAnimation3.value),
            child: Transform.translate(
              offset: Offset(_offsetAnimation2.value, _offsetAnimation1.value),
              child: Transform.scale(
                scale: _scaleAnimation.value,
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(_borderRadiusAnimation.value),
                      topRight: const Radius.circular(5),
                      bottomRight:
                      Radius.circular(_borderRadiusAnimation.value),
                      bottomLeft: Radius.circular(_borderRadiusAnimation.value),
                    ),
                    color: Colors.deepPurple,
                  ),
                  child: Transform.rotate(
                    angle: degrees2Radians * 315,
                    child: Icon(
                      Icons.voice_chat,
                      color: Color.fromRGBO(
                          250, 250, 250, _iconOpacityAnimation.value),
                      size: 16,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(_offsetAnimation4.value, _offsetAnimation4.value),
            child: Transform.translate(
              offset: Offset(_offsetAnimation2.value, _offsetAnimation2.value),
              child: Transform.scale(
                scale: _scaleAnimation.value,
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(_borderRadiusAnimation.value),
                      topRight: Radius.circular(_borderRadiusAnimation.value),
                      bottomRight: const Radius.circular(5),
                      bottomLeft: Radius.circular(_borderRadiusAnimation.value),
                    ),
                    color: Colors.deepPurple,
                  ),
                  child: Transform.rotate(
                    angle: degrees2Radians * 315,
                    child: Icon(
                      Icons.settings,
                      color: Color.fromRGBO(
                          250, 250, 250, _iconOpacityAnimation.value),
                      size: 16,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(_offsetAnimation3.value, _offsetAnimation4.value),
            child: Transform.translate(
              offset: Offset(_offsetAnimation1.value, _offsetAnimation2.value),
              child: Transform.scale(
                scale: _scaleAnimation.value,
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(_borderRadiusAnimation.value),
                      topRight: Radius.circular(_borderRadiusAnimation.value),
                      bottomRight:
                      Radius.circular(_borderRadiusAnimation.value),
                      bottomLeft: const Radius.circular(5),
                    ),
                    color: Colors.deepPurple,
                  ),
                  child: Icon(
                    Icons.attach_file,
                    color: Color.fromRGBO(
                        250, 250, 250, _iconOpacityAnimation.value),
                    size: 16,
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                if(_controller1.isCompleted){
                  _controller1.reverse();
                } else {
                  _controller1.forward();
                }

              },
              child: const Icon(Icons.add, color: Colors.white, size: 40),
            ),
          ),
        ]),
      ),
    );
  }
}
