import 'dart:async' show Timer;

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/features/home/presentation/widgets/home_display_ad_dialog.dart';
import 'package:video_player/video_player.dart';

import 'home/data/models/ad_model.dart';

class TestAreaRoute extends StatefulWidget {
  @override
  _TestAreaRouteState createState() => _TestAreaRouteState();
}

class _TestAreaRouteState extends State<TestAreaRoute> with AfterLayoutMixin {
  VideoPlayerController _controller;
  bool _runScheduleTimer = false;
  Timer _periodTimer;
  Timer _periodTimerTimeout;

//  Future<ClosedCaptionFile> _loadCaptions() async {
//    final String fileContents = await DefaultAssetBundle.of(context)
//        .loadString('assets/bumble_bee_captions.srt');
//    return SubRipCaptionFile(fileContents);
//  }

  final List<AdModel> ads = [
    AdModel(
        id: 9,
        title: "购宝",
        type: 'image/jpeg',
        pic: 'images/ad/pc/27.jpg',
        url: 'https://www.gamewallet.asia/version.php?fn=gp_a&latest',
        mobileUrl: 'https://www.gamewallet.asia/version.php?fn=gp_a&latest',
        picMobile: 'images/ad/mobile/28.jpg',
        startTime: '2020-06-30 17:27:27',
        endTime: '2021-06-01 00:00:00',
        sort: 1,
        status: true,
        urlBlank: true),
    AdModel(
        id: 6,
        title: "test2",
        type: 'image/jpeg',
        pic: 'images/ad/pc/23.jpg',
        url: '/index/slot',
        mobileUrl: '/index/slot',
        picMobile: 'images/ad/mobile/24.jpg',
        startTime: '2020-06-15 09:23:08',
        endTime: '2021-06-01 00:00:00',
        sort: 4,
        status: true,
        urlBlank: true),
    AdModel(
        id: 8,
        title: "test3",
        type: 'image/jpeg',
        pic: 'images/ad/pc/25.jpg',
        url: '/mission',
        mobileUrl: '/mission',
        picMobile: 'images/ad/mobile/26.jpg',
        startTime: '2020-06-19 16:30:31',
        endTime: '2021-06-01 16:30:33',
        sort: 5,
        status: true,
        urlBlank: true)
  ];

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
    super.initState();
    _controller = VideoPlayerController.network(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
//      closedCaptionFile: _loadCaptions(),
    );
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
//    return Container();
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(padding: const EdgeInsets.only(top: 20.0)),
          const Text('With remote mp4'),
          Container(
            padding: const EdgeInsets.all(20),
            child: AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  VideoPlayer(_controller),
                  ClosedCaption(text: _controller.value.caption.text),
                  _PlayPauseOverlay(controller: _controller),
                  VideoProgressIndicator(_controller, allowScrubbing: true),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    print('after first layout');
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => new HomeDisplayAdDialog(ads: ads, onClose: null),
    );
  }
}

class _PlayPauseOverlay extends StatelessWidget {
  const _PlayPauseOverlay({Key key, this.controller}) : super(key: key);

  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
              controller.value.isPlaying
                  ? controller.pause()
                  : controller.play();
            },
          ),
        ],
      ),
    );
  }
}
