import 'dart:async' show Timer;

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_ty_mobile/core/internal/global.dart';
import 'package:flutter_ty_mobile/core/internal/themes.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart' as VLC;

class TestAreaRoute extends StatefulWidget {
  @override
  _TestAreaRouteState createState() => _TestAreaRouteState();
}

class _TestAreaRouteState extends State<TestAreaRoute> with AfterLayoutMixin {
  VLC.VlcPlayerController _videoViewController;

  Size _playerSize;
  bool _isPlaying = true;
  bool _sliderChange = false;
  double _sliderValue = 0.0;

  bool _visibleTool = true;
  Timer _toolVisibleTimeout;

  void startToolVisibilityTimer(int seconds) {
    _toolVisibleTimeout?.cancel();
    _toolVisibleTimeout = new Timer(Duration(seconds: seconds), () {
      if (this.mounted) {
        setState(() => _visibleTool = false);
      }
    });
  }

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
      _videoViewController.play();
      setState(() {
        _isPlaying = true;
      });
      startToolVisibilityTimer(5);
    }
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
        _videoViewController.play();
        startToolVisibilityTimer(3);
      },
    );
    _videoViewController.addListener(() {
      setState(() {});
    });
    Timer.periodic(Duration(seconds: 1), (Timer timer) {
      VLC.PlayingState state = _videoViewController.playingState;
      if (this.mounted && !_sliderChange) {
        setState(() {
          if (state == VLC.PlayingState.PLAYING &&
              _sliderValue < _videoViewController.duration.inSeconds) {
            // position max = duration - 1, so slider value need to add 1
            _sliderValue =
                _videoViewController.position.inSeconds.toDouble() + 1;
          } else if (state == VLC.PlayingState.STOPPED) {
            if (_sliderValue <= _videoViewController.duration.inSeconds) {
              // position max = duration - 1, so slider value need to add 1
              _sliderValue =
                  _videoViewController.position.inSeconds.toDouble() + 1;
            }
            _toolVisibleTimeout?.cancel();
            _isPlaying = false;
            _visibleTool = true;
          }
        });
      }
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
      constraints: BoxConstraints(
        maxHeight: Global.device.featureContentHeight,
        maxWidth: Global.device.width,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ColoredBox(
            color: Colors.black,
            child: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 16.0),
                  alignment: Alignment.topCenter,
                  child: VLC.VlcPlayer(
                    aspectRatio: Global.device.ratioHor,
//                    url: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4",
                    url: 'https://storage.tytv99.com/movie/s3/5376/list.m3u8',
                    controller: _videoViewController,
                    placeholder: Center(child: CircularProgressIndicator()),
                  ),
                ),
                Container(
                  constraints: BoxConstraints.tight(_playerSize),
                  child: GestureDetector(
                    onTap: () {
                      setState(() => _visibleTool = true);
                      startToolVisibilityTimer(5);
                    },
                  ),
                ),
                Visibility(
//                  maintainSize: true,
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
                            padding: const EdgeInsets.only(top: 64.0),
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
                          height: 64.0,
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: Text(
                                      '${_durationToTime(Duration(seconds: _sliderValue.round()))}/'
                                      '${_durationToTime(Duration(seconds: _videoViewController.duration.inSeconds))}',
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
                                    value: _sliderValue,
                                    min: 0.0,
                                    max: _videoViewController.duration == null
                                        ? 1.0
                                        : _videoViewController
                                            .duration.inSeconds
                                            .toDouble(),
                                    onChanged: (progress) {
                                      print('slider progress: $progress');
                                      var target = progress.round();
                                      //convert to Milliseconds since VLC requires MS to set time
                                      _videoViewController
                                          .setTime(target * 1000);
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
          ),
          Text("position=" +
              (_videoViewController.position.inSeconds + 1).toString() +
              ", duration=" +
              _videoViewController.duration.inSeconds.toString() +
              ", speed=" +
              _videoViewController.playbackSpeed.toString()),
          Text("ratio=" + _videoViewController.aspectRatio.toString()),
          Text("size=" +
              _videoViewController.size.width.toString() +
              "x" +
              _videoViewController.size.height.toString()),
          Text("state=" + _videoViewController.playingState.toString()),
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

  @override
  void afterFirstLayout(BuildContext context) {
    print('after first layout');
  }
}
