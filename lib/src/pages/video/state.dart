part of netflix;

class VideoState extends State<Video> {
  YoutubePlayerController vcontroller;
  bool controlVisible;
  Timer timer;

  @override
  void initState() {
    controlVisible = true;
    vcontroller = YoutubePlayerController(
      initialVideoId:
      YoutubePlayerController.convertUrlToId(widget.video),
      params: YoutubePlayerParams(
        autoPlay: true,
        startAt: Duration(seconds: 0),
        showControls: false,
        showFullscreenButton: false,
      ),
    );
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.transparent,
    ));
    super.initState();
    autoHide();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    //vcontroller?.dispose();
    timer?.cancel();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  void handlerGesture() {
    setState(() {
      controlVisible = !controlVisible;
    });
    autoHide();
  }

  void autoHide() {
    if (controlVisible) {
      timer = Timer(
          Duration(seconds: 5), () => setState(() => controlVisible = false));
    } else {
      timer?.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    final aspectRatio = 0.75;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          YoutubePlayerIFrame(
            controller: vcontroller,
            aspectRatio: kIsWeb ? 2.344 : 1.7,
          ),

        ],
      ),
    );
  }
}
