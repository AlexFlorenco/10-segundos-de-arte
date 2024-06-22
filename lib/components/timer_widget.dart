import 'package:flutter/material.dart';
import 'dart:async';

class TimerWidget extends StatefulWidget {
  const TimerWidget({
    required this.duration,
    super.key,
    this.size,
    this.delay,
    this.onTimerEnd,
  });

  final int duration;
  final double? size;
  final int? delay;
  final Function? onTimerEnd;

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  late int _duration;
  Timer? _timer;

  @override
  void initState() {
    _duration = widget.duration;
    super.initState();
    startTimer();
  }

  void startTimer() async {
    await Future.delayed(Duration(seconds: widget.delay ?? 0));
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_duration > 0) {
          _duration--;
        } else {
          _timer!.cancel();
          if (widget.onTimerEnd != null) {
            widget.onTimerEnd!();
          }
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '$_duration',
        style: TextStyle(fontSize: widget.size ?? 48),
      ),
    );
  }
}
