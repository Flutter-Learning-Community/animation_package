import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/material.dart';

import 'fadethorugh.dart';

class TestingFadeScale extends StatefulWidget {
  @override
  _TestingFadeScaleState createState() => _TestingFadeScaleState();
}

class _TestingFadeScaleState extends State<TestingFadeScale>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(
        value: 50.0,
        duration: const Duration(milliseconds: 2000),
        reverseDuration: const Duration(milliseconds: 500),
        vsync: this)
      ..addStatusListener((status) {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool get _isAnimationRunningForwardsOrComplete {
    switch (_controller.status) {
      case AnimationStatus.forward:
      case AnimationStatus.completed:
        return true;
      case AnimationStatus.reverse:
      case AnimationStatus.dismissed:
        return false;
    }
    //return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Testing FadeScale Transition'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
                left: 150, top: 50, bottom: 20, right: 160),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  onPressed: () {
                    if (_isAnimationRunningForwardsOrComplete) {
                      _controller.reverse();
                    } else {
                      _controller.forward();
                    }
                  },
                  color: Colors.blue,
                  child: Text(_isAnimationRunningForwardsOrComplete
                      ? 'Hide Box'
                      : 'Show Box'),
                ),
              ],
            ),
          ),
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return FadeScaleTransition(animation: _controller, child: child);
            },
            child: Container(
              height: 200,
              width: 200,
              color: Colors.blue,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 200, top: 50, bottom: 20, right: 160),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TestingFadeThrough()),
              );
            },
            color: Colors.blue,
            child: Text("fadethorugh"),
          )
        ],
      ),
    );
  }
}
