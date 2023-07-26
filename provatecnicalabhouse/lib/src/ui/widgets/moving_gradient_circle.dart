import 'dart:math';
import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provatecnicalabhouse/src/config/app_colors.dart';
import 'package:provatecnicalabhouse/src/utils/context_helper.dart';

class MovingGradientCircle extends StatefulWidget {

  Color color;
  double size;
  double velocityCap;

  MovingGradientCircle({Key? key, required this.color, required this.size, required this.velocityCap}) : super(key: key);

  @override
  _MovingGradientCircleState createState() => _MovingGradientCircleState();
}

class _MovingGradientCircleState extends State<MovingGradientCircle> {
  double _acceleration = 0;
  double xAcc = 0;
  double yAcc = 0;
  double xVel = 0;
  double yVel = 0;
  double x = 0;
  double y = 0;

  @override
  void initState() {
    super.initState();

    x = Random().nextDouble() * MediaQuery.of(ContextHelper.navigatorKey.currentContext!).size.width;
    y = Random().nextDouble() * MediaQuery.of(ContextHelper.navigatorKey.currentContext!).size.height;

    _renderingLoop();
  }

  _renderingLoop() async {
    while (true) {
      await Future.delayed(Duration(milliseconds: 24));

      setState(() {

        xVel += xAcc;
        yVel += yAcc;

        if(xVel > widget.velocityCap){
          xVel = widget.velocityCap;
        }
        if(xVel < -widget.velocityCap){
          xVel = -widget.velocityCap;
        }
        if(yVel > widget.velocityCap){
          yVel = widget.velocityCap;
        }
        if(yVel < -widget.velocityCap){
          yVel = -widget.velocityCap;
        }

        x += xVel;
        y += yVel;

        xAcc = ((Random().nextDouble() - 0.5));
        yAcc = ((Random().nextDouble() - 0.5));

        if(x > MediaQuery.of(context).size.width){
          xAcc = xAcc.abs() * (-1);
        }

        if(x < 0){
          xAcc = xAcc.abs();
        }

        if(y > MediaQuery.of(context).size.height){
          yAcc = yAcc.abs() * (-1);
        }

        if(y < 0){
          yAcc = yAcc.abs();
        }

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(x, y),
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              widget.color.withOpacity(0.6),
              widget.color.withOpacity(0),
            ],
          ),
        ),
      ),
    );
  }
}
