import 'dart:async' show Timer;

import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/core/internal/global.dart';
import 'package:video_player/video_player.dart';

class MovieDisplayPlayer extends StatefulWidget {
  final String streamUrl;

  MovieDisplayPlayer(this.streamUrl);

  @override
  _MovieDisplayPlayerState createState() => _MovieDisplayPlayerState();
}

class _MovieDisplayPlayerState extends State<MovieDisplayPlayer> {
  VideoPlayerController _controller;
  bool _runScheduleTimer = false;
  Timer _periodTimer;
  Timer _periodTimerTimeout;
  Size _playerSize;

  void startPeriodTimeoutTimer(Timer innerTimer) {
    _periodTimerTimeout?.cancel();
    _periodTimerTimeout = new Timer(Duration(seconds: 30), () {
      if (_runScheduleTimer) {
        try {
          innerTimer?.cancel();
          _periodTimer?.cancel();
          print('stopped period timer');
        } catch (e) {
          print('cancel period timer has exception: $e');
        }
        _runScheduleTimer = false;
      }
    });
  }

  void startProgressTimer() {
    print('start progress timer');
    _periodTimer?.cancel();
    _periodTimer = Timer.periodic(Duration(milliseconds: 1000), (Timer timer) {
      print('video value playing: ${_controller.value.isPlaying}');
      if (_controller.value.isPlaying) {
        _periodTimerTimeout?.cancel();
        print('video value duration: ${_controller.value.duration}');
        print('video value position: ${_controller.value.position}');
        print('video value buffered: ${_controller.value.buffered}');
      } else {
        if (_periodTimerTimeout == null ||
            _periodTimerTimeout.isActive == false) {
          // set a timer to stop period check after 10s
          startPeriodTimeoutTimer(timer);
        }
      }
    });
  }

  @override
  void initState() {
    _playerSize = Size(
      Global.device.width,
      (Global.device.width * Global.device.ratio + 32.0),
    );
    super.initState();
    _controller = VideoPlayerController.network(widget.streamUrl);
    _controller.addListener(() {
      print('triggered player control listener');
      if (_controller.value.isPlaying && !_runScheduleTimer) {
        _runScheduleTimer = true;
        startProgressTimer();
      }
      setState(() {});
    });
    _controller.setLooping(false);
    _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      constraints: BoxConstraints.tight(_playerSize),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          VideoPlayer(_controller),
          ClosedCaption(text: _controller.value.caption.text),
          _PlayPauseOverlay(controller: _controller),
          VideoProgressIndicator(_controller, allowScrubbing: true),
        ],
      ),
    );
  }

//  String _durationToTime(Duration duration) {
//    String twoDigits(int n) => n.toString().padLeft(2, "0");
//    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
//    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
//    String time =
//        "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
//    return (time.startsWith('00:00:')) ? time.substring(3) : time;
//  }
}

class _PlayPauseOverlay extends StatelessWidget {
  const _PlayPauseOverlay({Key key, this.controller}) : super(key: key);

  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: Duration(milliseconds: 50),
          reverseDuration: Duration(milliseconds: 200),
          child: controller.value.isPlaying
              ? SizedBox.shrink()
              : Container(
                  color: Colors.black26,
                  child: Center(
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 100.0,
                    ),
                  ),
                ),
        ),
        GestureDetector(
          onTap: () {
            controller.value.isPlaying ? controller.pause() : controller.play();
          },
        ),
      ],
    );
  }
}
