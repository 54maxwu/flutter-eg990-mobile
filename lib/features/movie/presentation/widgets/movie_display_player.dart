import 'dart:async' show Timer;

import 'package:flutter/material.dart';
import 'package:flutter_ty_mobile/core/internal/global.dart';
import 'package:flutter_ty_mobile/core/internal/themes.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart' as VLC;

class MovieDisplayPlayer extends StatefulWidget {
  final String streamUrl;

  MovieDisplayPlayer(this.streamUrl);

  @override
  _MovieDisplayPlayerState createState() => _MovieDisplayPlayerState();
}

class _MovieDisplayPlayerState extends State<MovieDisplayPlayer> {
  VLC.VlcPlayerController _videoViewController;

  Size _playerSize;
  bool _runScheduleTimer = false;

  bool _isPlaying = false;
  bool _sliderChange = false;
  double _sliderValue = 0.0;
  double _duration = 0.0;

  bool _visibleTool = true;
  Timer _toolVisibleTimeout;

  void playOrPauseVideo() {
    VLC.PlayingState state = _videoViewController.playingState;
    if (_sliderChange) _sliderChange = false;
    if (state == VLC.PlayingState.PLAYING) {
      _toolVisibleTimeout?.cancel();
      _videoViewController.pause();
      setState(() {
        _isPlaying = false;
      });
    } else {
      if (_sliderValue.floor() == _videoViewController.duration.inSeconds) {
        // reset play state if current progress is at the end
        _sliderValue = 0.0;
        _videoViewController.setTime(0);
      }
      startProgressTimer();
      _videoViewController.play();
      setState(() {
        _isPlaying = true;
      });
      startToolVisibilityTimer(5);
    }
  }

  void startToolVisibilityTimer(int seconds) {
    _toolVisibleTimeout?.cancel();
    _toolVisibleTimeout = new Timer(Duration(seconds: seconds), () {
      if (this.mounted) {
        setState(() => _visibleTool = false);
      }
    });
  }

  void startProgressTimer() {
    if (_runScheduleTimer) return;
    print('start progress timer');
    Timer.periodic(Duration(milliseconds: 500), (Timer timer) {
      VLC.PlayingState state = _videoViewController.playingState;
//      print('player state: $state, slider changed: $_sliderChange');
//      print('video duration: ${_videoViewController.duration}');
//      print('video position: ${_videoViewController.position}');
      if (this.mounted && !_sliderChange) {
        if (state == VLC.PlayingState.PLAYING &&
            _sliderValue < _videoViewController.duration.inSeconds) {
          // position max = duration - 1, so slider value need to add 1
          setState(() {
            if (_videoViewController.duration.inSeconds > 0 &&
                _duration != _videoViewController.duration.inSeconds.toDouble())
              _duration = _videoViewController.duration.inSeconds.toDouble();
            _sliderValue =
                _videoViewController.position.inSeconds.toDouble() + 1;
          });
        } else if (state == VLC.PlayingState.STOPPED) {
          _toolVisibleTimeout?.cancel();
          setState(() {
            if (_sliderValue <= _videoViewController.duration.inSeconds) {
              // position max = duration - 1, so slider value need to add 1
              _sliderValue =
                  _videoViewController.position.inSeconds.toDouble() + 1;
            }
            _isPlaying = false;
            _visibleTool = true;
          });
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
    _videoViewController = new VLC.VlcPlayerController(
      onInit: () {
        _duration = 0.0;
//        _videoViewController.play();
//        startToolVisibilityTimer(3);
      },
    );
    _videoViewController.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _toolVisibleTimeout?.cancel();
    _videoViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      constraints: BoxConstraints.tight(_playerSize),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 16.0),
            child: VLC.VlcPlayer(
              controller: _videoViewController,
              aspectRatio: Global.device.ratioHor,
              url: widget.streamUrl,
              placeholder: Center(child: CircularProgressIndicator()),
            ),
          ),
          ConstrainedBox(
            constraints: BoxConstraints.tight(_playerSize),
            child: GestureDetector(
              onTap: () {
                setState(() => _visibleTool = true);
                startToolVisibilityTimer(5);
              },
            ),
          ),
          Visibility(
//            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            visible: _visibleTool,
            child: ConstrainedBox(
              constraints: BoxConstraints.tight(_playerSize),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 48.0),
                      child: FlatButton(
                        child: _isPlaying
                            ? Icon(
                                Icons.pause,
                                color: Themes.defaultAccentColor,
                                size: _playerSize.width / 6,
                              )
                            : Icon(
                                Icons.play_arrow,
                                color: Themes.defaultAccentColor,
                                size: _playerSize.width / 6,
                              ),
                        onPressed: () => playOrPauseVideo(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 48.0,
                    child: Stack(
                      alignment: Alignment.topLeft,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 4.0),
                              child: FlatButton(
                                child: _isPlaying
                                    ? Icon(Icons.pause)
                                    : Icon(Icons.play_arrow),
                                onPressed: () => playOrPauseVideo(),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text(
                                '${_durationToTime(Duration(seconds: _sliderValue.round()))}/'
                                '${_durationToTime(Duration(seconds: _duration.floor()))}',
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          top: 18.0,
                          child: SizedBox(
                            width: _playerSize.width,
                            child: Slider(
                              inactiveColor: Colors.white38,
                              activeColor: Colors.white,
                              value: (_sliderValue <= _duration)
                                  ? _sliderValue
                                  : _duration,
                              min: 0.0,
                              max: _videoViewController.duration == null ||
                                      _videoViewController.duration.inSeconds <=
                                          1.0
                                  ? _duration
                                  : _videoViewController.duration.inSeconds
                                      .toDouble(),
                              onChanged: (progress) {
                                print('slider progress: $progress');
                                var target = progress.round();
                                //convert to Milliseconds since VLC requires MS to set time
                                _videoViewController.setTime(target * 1000);
                                print('slider target: $target');
                                setState(() {
                                  _sliderValue = target.toDouble();
                                });
                                print('slider value: $_sliderValue');
                              },
                              onChangeStart: (_) {
                                _sliderChange = true;
                                _toolVisibleTimeout?.cancel();
                              },
                              onChangeEnd: (_) {
                                startToolVisibilityTimer(3);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _durationToTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    String time =
        "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
    return (time.startsWith('00:00:')) ? time.substring(3) : time;
  }
}
