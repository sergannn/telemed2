import 'dart:async';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'base_tool.dart';

class TimerTool extends BaseTool {
  @override
  String get name => 'TimerTool';

  @override
  Map<String, dynamic> execute(Map<String, dynamic> parameters) {
    final durationString = parameters['duration'] as String;

    // Parse duration string (e.g., "1h", "1m", "30s", "1h5m30s")
    Duration duration = parseDuration(durationString);

    // Создаем toolSummary
    final String toolSummary = '<tool_summary>I have provided a timer interface for the user to count down from: $durationString</tool_summary>';

    // Возвращаем Map с toolWidget и toolSummary
    return {
      'toolWidget': TimerToolWidget(initialDuration: duration),
      'toolSummary': toolSummary,
    };
  }

  Duration parseDuration(String durationString) {
    int hours = 0;
    int minutes = 0;
    int seconds = 0;

    RegExp hoursRegex = RegExp(r'(\d+)h');
    RegExp minutesRegex = RegExp(r'(\d+)m');
    RegExp secondsRegex = RegExp(r'(\d+)s');

    Match? hoursMatch = hoursRegex.firstMatch(durationString);
    Match? minutesMatch = minutesRegex.firstMatch(durationString);
    Match? secondsMatch = secondsRegex.firstMatch(durationString);

    if (hoursMatch != null) {
      hours = int.parse(hoursMatch.group(1)!);
    }

    if (minutesMatch != null) {
      minutes = int.parse(minutesMatch.group(1)!);
    }

    if (secondsMatch != null) {
      seconds = int.parse(secondsMatch.group(1)!);
    }

    return Duration(hours: hours, minutes: minutes, seconds: seconds);
  }
}

class TimerToolWidget extends StatefulWidget {
  final Duration initialDuration;

  const TimerToolWidget({Key? key, required this.initialDuration}) : super(key: key);

  @override
  _TimerToolWidgetState createState() => _TimerToolWidgetState();
}

class _TimerToolWidgetState extends State<TimerToolWidget> with AutomaticKeepAliveClientMixin {
  late Timer _timer;
  late Duration _remainingDuration;
  bool _isRunning = false;
  bool _isPaused = false;
  bool _isFinished = false;
  final _player = AudioPlayer();
  int _hours = 0;
  int _minutes = 0;
  int _seconds = 0;

  @override
  void initState() {
    super.initState();
    _hours = widget.initialDuration.inHours;
    _minutes = widget.initialDuration.inMinutes.remainder(60);
    _seconds = widget.initialDuration.inSeconds.remainder(60);
    _remainingDuration = Duration(hours: _hours, minutes: _minutes, seconds: _seconds);
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    _timer.cancel();
    _player.dispose();
    super.dispose();
  }

  void _startTimer() {
    setState(() {
      _isRunning = true;
      _isPaused = false;
      _isFinished = false;
    });

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingDuration.inSeconds > 0) {
          _remainingDuration -= Duration(seconds: 1);
        } else {
          _timer.cancel();
          _isRunning = false;
          _isFinished = true;
          _playSound();
        }
      });
    });
  }

  void _pauseTimer() {
    _timer.cancel();
    setState(() {
      _isRunning = false;
      _isPaused = true;
    });
  }

  void _resumeTimer() {
    _startTimer();
  }

  void _stopTimer() {
    _timer.cancel();
    setState(() {
      _isRunning = false;
      _isPaused = false;
      _isFinished = true;
      _remainingDuration = Duration(hours: _hours, minutes: _minutes, seconds: _seconds);
    });
  }

  Future<void> _playSound() async {
    await _player.play(AssetSource('timer_sound.mp3'));
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitHours = twoDigits(duration.inHours);
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitHours:$twoDigitMinutes:$twoDigitSeconds";
  }

  void _updateRemainingDuration() {
    setState(() {
      _remainingDuration = Duration(hours: _hours, minutes: _minutes, seconds: _seconds);
    });
  }

  Widget _buildCompactTimeSelector({
    required int value,
    required ValueChanged<int> onChanged,
  }) {
    return Column(
      children: [
        IconButton(
          icon: Icon(Icons.arrow_drop_up),
          onPressed: () {
            onChanged(value + 1);
          },
        ),
        Text(
          value.toString().padLeft(2, '0'),
          style: TextStyle(fontSize: 20.0),
        ),
        IconButton(
          icon: Icon(Icons.arrow_drop_down),
          onPressed: () {
            if (value > 0) {
              onChanged(value - 1);
            }
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required when using AutomaticKeepAliveClientMixin
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4.0,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _formatDuration(_remainingDuration),
              style: TextStyle(fontSize: 48.0),
            ),
            SizedBox(height: 16.0),
            CircularProgressIndicator(
              value: _remainingDuration.inSeconds / Duration(hours: _hours, minutes: _minutes, seconds: _seconds).inSeconds,
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_isRunning)
                  IconButton(
                    onPressed: _pauseTimer,
                    icon: Icon(Icons.pause),
                  )
                else if (_isPaused)
                  IconButton(
                    onPressed: _resumeTimer,
                    icon: Icon(Icons.play_arrow),
                  )
                else if (!_isRunning && !_isPaused)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: _startTimer,
                        icon: Icon(Icons.play_arrow),
                      ),
                      SizedBox(width: 8.0),
                      Text('Start'),
                    ],
                  ),
                SizedBox(width: 16.0),
                if (_isRunning || _isPaused)
                  IconButton(
                    onPressed: _stopTimer,
                    icon: Icon(Icons.stop),
                  ),
              ],
            ),
            SizedBox(height: 16.0),
            if (!_isRunning && !_isPaused)
              Column(
                children: [
                  Text('Set timer'),
                  SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildCompactTimeSelector(
                        value: _hours,
                        onChanged: (value) {
                          setState(() {
                            _hours = value;
                            _updateRemainingDuration();
                          });
                        },
                      ),
                      Text(':', style: TextStyle(fontSize: 20.0)),
                      _buildCompactTimeSelector(
                        value: _minutes,
                        onChanged: (value) {
                          setState(() {
                            _minutes = value;
                            _updateRemainingDuration();
                          });
                        },
                      ),
                      Text(':', style: TextStyle(fontSize: 20.0)),
                      _buildCompactTimeSelector(
                        value: _seconds,
                        onChanged: (value) {
                          setState(() {
                            _seconds = value;
                            _updateRemainingDuration();
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}