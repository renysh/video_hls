import 'package:flutter/material.dart';
import 'package:flutter_playout/player_observer.dart';
import 'package:flutter_playout/player_state.dart';
import 'package:flutter_playout/video.dart';
import 'package:preload_page_view/preload_page_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: HomePreload(),
    );
  }
}

List<VideoModel> videos = [
  VideoModel(
    url: 'https://test-streams.mux.dev/x36xhzz/x36xhzz.m3u8',
    title: 'Video 1',
    subtitle: 'Subtitulo 1',
  ),
  VideoModel(
    url:
        'https://bitdash-a.akamaihd.net/content/MI201109210084_1/m3u8s/f08e80da-bf1d-4e3d-8899-f0f6155f6efa.m3u8',
    title: 'Video 2',
    subtitle: 'Subtitulo 2',
  ),
  VideoModel(
    url: 'https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8',
    title: 'Video 3',
    subtitle: 'Subtitulo 3',
  ),
  VideoModel(
    url: 'https://mnmedias.api.telequebec.tv/m3u8/29880.m3u8',
    title: 'Video 4',
    subtitle: 'Subtitulo 4',
  )
];

class HomePagePageView extends StatefulWidget {
  HomePagePageView({Key key}) : super(key: key);

  @override
  _HomePagePageViewState createState() => _HomePagePageViewState();
}

class _HomePagePageViewState extends State<HomePagePageView> {
  final controller = PageController(
    initialPage: 0,
  );

  final TextStyle textStyle = TextStyle(
    color: Colors.blue,
    fontWeight: FontWeight.w800,
    fontFamily: 'Roboto',
    letterSpacing: 0.5,
    fontSize: 30,
    height: 2,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: PageView(
          scrollDirection: Axis.vertical,
          onPageChanged: (int index) {
            print(index);
          },
          controller: controller,
          children: <Widget>[
            VideoWidget(
              model: videos[0],
            ),
            VideoWidget(
              model: videos[1],
            ),
            VideoWidget(
              model: videos[2],
            ),
            VideoWidget(
              model: videos[3],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    this.controller.dispose();
    super.dispose();
  }
}

class HomePreload extends StatefulWidget {
  HomePreload({Key key}) : super(key: key);

  @override
  _HomePreloadState createState() => _HomePreloadState();
}

class _HomePreloadState extends State<HomePreload> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PreloadPageView.builder(
        itemCount: videos.length,
        preloadPagesCount: videos.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int position) => VideoWidget(
          model: videos[position],
        ),
        controller: PreloadPageController(),
        onPageChanged: (int position) {
          print('page changed. current: $position');
        },
      ),
    );
  }
}

class VideoWidget extends StatefulWidget {
  final VideoModel model;

  const VideoWidget({Key key, @required this.model}) : super(key: key);

  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> with PlayerObserver {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 16 / 9,
          child: Video(
            title: this.widget.model.title,
            subtitle: this.widget.model.subtitle,
            autoPlay: true,
            showControls: true,
            isLiveStream: false,
            position: 0,
            desiredState: PlayerState.STOPPED,
            url: this.widget.model.url,
            onViewCreated: _onViewCreated,
          ),
        ),
      ],
    );
  }

  void _onViewCreated(int viewId) {
    listenForVideoPlayerEvents(viewId);
  }

  @override
  void onPlay() {
    // TODO: implement onPlay
    super.onPlay();
  }

  @override
  void onPause() {
    // TODO: implement onPause
    super.onPause();
  }

  @override
  void onComplete() {
    // TODO: implement onComplete
    super.onComplete();
  }

  @override
  void onTime(int position) {
    // TODO: implement onTime
    super.onTime(position);
  }

  @override
  void onSeek(int position, double offset) {
    // TODO: implement onSeek
    super.onSeek(position, offset);
  }

  @override
  void onDuration(int duration) {
    // TODO: implement onDuration
    super.onDuration(duration);
  }

  @override
  void onError(String error) {
    // TODO: implement onError
    super.onError(error);
  }
}

class VideoModel {
  final String url;
  final String title;
  final String subtitle;

  VideoModel({this.url, this.title, this.subtitle});
}
