import 'package:flutter/material.dart';
import 'package:flutter_app_video/model/VideoItem.dart';
import 'package:flutter_app_video/utils/PxUtils.dart';
import 'package:video_player/video_player.dart';

import 'ActionsToolbar.dart';
import 'VideoIntro.dart';

// 小视频播放器
class TinyVideoPlayer extends StatefulWidget {
  final VideoItem tinyVideoListItem;

  TinyVideoPlayer({
    Key key,
    this.tinyVideoListItem,
  }) : super(key: key);

  @override
  _TinyVideoPlayerState createState() => _TinyVideoPlayerState();
}

class _TinyVideoPlayerState extends State<TinyVideoPlayer>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  // 播放器实例
  VideoPlayerController _videoPlayerController;
  // 播放器初始化的Future
  Future<void> _initializeVideoPlayerFuture;
  // 动画实例
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // 播放器控制器
    _videoPlayerController = VideoPlayerController.network(
      widget.tinyVideoListItem?.videoUrl,
    );
    // 动画控制器
    _animationController = AnimationController(
      duration: Duration(milliseconds: 3000),
      vsync: this,
    );

    // 播放器循环播放
    _videoPlayerController.setLooping(true);
    // 播放器初始化
    _initializeVideoPlayerFuture = _videoPlayerController.initialize();
    // 播放器完成初始化
    _initializeVideoPlayerFuture.then((_) {
      setState(() {
        // 开始播放
        _videoPlayerController.play();
        // 动画执行
        _animationController.forward(from: 0.0);
      });
    });

    // 监听动画状态改变
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // 继续执行
        _animationController.forward(from: 0.0);
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("didChangeDependencies");
  }

  @override
  void didUpdateWidget(covariant TinyVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("didUpdateWidget");
  }

  @override
  void deactivate() {
    super.deactivate();
    print("deactivate");
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("--" + state.toString());
    switch (state) {

      //切换前台时,可回调，初始化时，收不到回调
      case AppLifecycleState.resumed:
        break;
      //切换后台时,inactive，pause先后回调
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.detached:
        break;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _videoPlayerController.dispose();
    _animationController.dispose();
    _animationController = null;
    _videoPlayerController = null;
    super.dispose();
  }

  // 播放或暂停
  void _onPlayOrPause() {
    setState(() {
      if (_videoPlayerController.value.isPlaying) {
        _videoPlayerController.pause();
        _animationController.stop();
      } else {
        _videoPlayerController.play();
        _animationController.forward(from: _animationController.value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Stack(
        fit: StackFit.expand,
        children: [
          _videoPlayer(),
          _playIcon(),
          _loading(),
          Positioned(
            right: toRpx(10, context),
            bottom: toRpx(20, context),
            child: ActionsToolbar(
              commentCount: widget.tinyVideoListItem?.commentCount,
              thumbUpCount: widget.tinyVideoListItem?.thumbUpCount,
              shareCount: 0,
              thumbUp: false,
              userAvatar: widget.tinyVideoListItem.user != null
                  ? widget.tinyVideoListItem.user.coverPictureUrl
                  : null,
              animationController: _animationController,
            ),
          ),
          Positioned(
            left: toRpx(20, context),
            right: toRpx(160, context),
            bottom: toRpx(20, context),
            child: VideoIntro(
              nickname: widget.tinyVideoListItem?.user != null
                  ? widget.tinyVideoListItem?.user?.nickname
                  : null,
              intro: widget.tinyVideoListItem?.intro,
            ),
          ),
        ],
      ),
    );
  }

  // 播放器
  Widget _videoPlayer() {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // 初始化完 展示播放器
          return Center(
            child: GestureDetector(
              onTap: _onPlayOrPause,
              child: AspectRatio(
                aspectRatio: _videoPlayerController.value.aspectRatio,
                child: VideoPlayer(_videoPlayerController),
              ),
            ),
          );
        } else {
          // 则展示封面
          return Image.network(
            networkImageToDefault(widget.tinyVideoListItem?.coverPictureUrl),
            fit: BoxFit.cover,
          );
        }
      },
    );
  }

  // 播放按钮
  Widget _playIcon() {
    // 初始化完成 并且暂停了 则展示播放按钮
    if (_videoPlayerController.value.isInitialized &&
        !_videoPlayerController.value.isPlaying) {
      return Center(
        child: GestureDetector(
          onTap: _onPlayOrPause,
          child: Opacity(
            opacity: 0.5,
            child: Image.asset(
              'assets/images/icons/play_plus.png',
              width: toRpx(118, context),
              height: toRpx(118, context),
            ),
          ),
        ),
      );
    }
    // 则展示空组件
    return SizedBox.shrink();
  }

  // 缓冲中
  Widget _loading() {
    if (_videoPlayerController.value.isBuffering) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    // 则展示空组件
    return SizedBox.shrink();
  }
}
