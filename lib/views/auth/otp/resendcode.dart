import 'dart:async';

import 'package:flutter/material.dart';

import '../../../static/static_values.dart';

class ResendCodeWidget extends StatefulWidget {
  final Function onResend;

  ResendCodeWidget({required this.onResend});

  @override
  _ResendCodeWidgetState createState() => _ResendCodeWidgetState();
}

class _ResendCodeWidgetState extends State<ResendCodeWidget> {
  int _countdown = 300;
  Timer? _timer;

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _countdown--;
      });
      if (_countdown == 0) {
        stopTimer();
        widget.onResend();
      }
    });
  }

  void stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  void dispose() {
    stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_timer == null) {
          startTimer();
        }
      },
      child: Text(
        "Resend New Code (${_countdown ~/ 60}:${(_countdown % 60).toString().padLeft(2, '0')})",
        style:
        // TextStyle(
        //   fontSize: 18,
        //   fontWeight: FontWeight.bold,
        //   color: _timer == null ? Colors.green : Colors.grey,
        // ),
        StaticValues.customFonts(_timer == null ? Colors.green : Colors.grey,15,FontWeight.w800),
        textAlign: TextAlign.center,
      ),
    );
  }
}
