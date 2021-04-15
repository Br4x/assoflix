part of netflix;

class ContentHeader extends StatelessWidget {
  final dynamic featuredContent;

  const ContentHeader({
    Key key,
    @required this.featuredContent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: _ContentHeaderMobile(featuredContent: featuredContent),
      desktop: _ContentHeaderDesktop(featuredContent: featuredContent),
    );
  }
}

class _ContentHeaderMobile extends StatelessWidget {
  final dynamic featuredContent;

  const _ContentHeaderMobile({
    Key key,
    @required this.featuredContent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final Size screenSize = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 500.0,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Image.network(featuredContent.image, fit: BoxFit.cover),
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                    stops: [0.1, 0.6, 1.0],
                    colors: [
                      Colors.black54,
                      Colors.transparent,
                      Colors.black
                    ],
                  ),
                ),
                child: Container(
                  height: 40.0,
                  width: screenSize.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: Container(
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 3.0,
                                color:
                                Color.fromRGBO(185, 3, 12, 1.0),
                              ),
                            ),
                          ),
                          child: Text(
                            featuredContent.name.replaceAll(' ', '\n'),
                            maxLines: 3,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              height: 0.65,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 30.0,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:  List.from(featuredContent.genres.map((g) {
                      return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                      g,
                      style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 12.0,
                      ),
                      ),
                      );
                      }).toList())
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            FlatButton(
                              textColor: Colors.white,
                              child: Column(
                                children: <Widget>[
                                  Icon(Icons.add),
                                  Text(
                                    'Ma liste',
                                    style: TextStyle(
                                        fontSize: 10.0,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ],
                              ),
                              onPressed: () => print('ma liste'),
                            ),
                            RaisedButton(
                              textColor: Colors.black,
                              color: Colors.white,
                              child: Row(
                                children: <Widget>[
                                  Icon(Icons.play_arrow),
                                  Text(
                                    'Lecture',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              onPressed: () {
                                print("lecture desktop");
                                SystemChrome.setPreferredOrientations([
                                  DeviceOrientation.landscapeRight,
                                  DeviceOrientation.landscapeLeft,
                                ]).then((e) {
                                  Application.router.navigateTo(
                                    context,
                                    Routes.video,
                                    routeSettings: RouteSettings(
                                      arguments: {'title': featuredContent.name},
                                    ),
                                    transition: TransitionType.inFromBottom,
                                    transitionDuration: const Duration(milliseconds: 200),
                                  );
                                });
                              },
                            ),
                            FlatButton(
                              textColor: Colors.white,
                              child: Column(
                                children: <Widget>[
                                  Icon(Icons.info_outline),
                                  Text(
                                    'Infos',
                                    style: TextStyle(
                                        fontSize: 10.0,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ],
                              ),
                              onPressed: () =>
                                Application.router.navigateTo(
                                context,
                                '${Routes.detail}',
                                transition: TransitionType.inFromRight,
                                transitionDuration: const Duration(milliseconds: 200),
                                routeSettings: RouteSettings(
                                  arguments: {'match': 99, 'show': featuredContent},
                                )
                              )
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 500.0,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black, Colors.transparent],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
        ),
        Positioned(
          bottom: 110.0,
          child: SizedBox(
            width: 250.0,
            child: Text(
              featuredContent.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 26.0,
                fontWeight: FontWeight.w800,
                shadows: [
                  Shadow(
                    color: Colors.black,
                    offset: Offset(2.0, 4.0),
                    blurRadius: 6.0,
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 40.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              VerticalIconButton(
                icon: Icons.add,
                title: 'List',
                onTap: () => print('Ma liste'),
              ),
              FlatButton.icon(
                padding: !Responsive.isDesktop(context)
                    ? const EdgeInsets.fromLTRB(15.0, 5.0, 20.0, 5.0)
                    : const EdgeInsets.fromLTRB(25.0, 10.0, 30.0, 10.0),
                onPressed: () =>
                    SystemChrome.setPreferredOrientations([
                      DeviceOrientation.landscapeRight,
                      DeviceOrientation.landscapeLeft,
                    ]).then((e) {
                      Application.router.navigateTo(
                        context,
                        Routes.video,
                        routeSettings: RouteSettings(
                          arguments: {'title': featuredContent.name},
                        ),
                        transition: TransitionType.inFromBottom,
                        transitionDuration: const Duration(milliseconds: 200),
                      );
                    }),
                color: Colors.white,
                icon: const Icon(Icons.play_arrow, size: 30.0),
                label: const Text(
                  'Lecture',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              VerticalIconButton(
                icon: Icons.info_outline,
                title: 'Infos',
                onTap: () =>   Application.router.navigateTo(
                    context,
                    '${Routes.detail}',
                    transition: TransitionType.inFromRight,
                    transitionDuration: const Duration(milliseconds: 200),
                    routeSettings: RouteSettings(
                      arguments: {'match': 99, 'show': featuredContent},
                    )
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ContentHeaderDesktop extends StatefulWidget {
  final dynamic featuredContent;

  const _ContentHeaderDesktop({
    Key key,
    @required this.featuredContent,
  }) : super(key: key);

  @override
  __ContentHeaderDesktopState createState() => __ContentHeaderDesktopState();
}

class __ContentHeaderDesktopState extends State<_ContentHeaderDesktop> {
  VideoPlayerController _videoController;
  bool _isMuted = true;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.asset('assets/video/promo.mp4')
    //VideoPlayerController.network(widget.featuredContent.videoUrl)
      ..initialize().then((_) => setState(() {}))
      ..setVolume(1)
      ..play();
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _videoController.value.isPlaying
          ? _videoController.pause()
          : _videoController.play(),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          AspectRatio(
            aspectRatio: _videoController.value.isInitialized
                ? _videoController.value.aspectRatio
                : 2.344,
            child: _videoController.value.isInitialized
                ? VideoPlayer(_videoController)
                : Image.network(
              widget.featuredContent.image,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: -1.0,
            child: AspectRatio(
              aspectRatio: _videoController.value.isInitialized
                  ? _videoController.value.aspectRatio
                  : 2.344,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black, Colors.transparent],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 60.0,
            right: 60.0,
            bottom: 150.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 250.0,
                  child:  Text(
                      widget.featuredContent.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 26.0,
                        fontWeight: FontWeight.w800,
                        shadows: [
                          Shadow(
                            color: Colors.black,
                            offset: Offset(2.0, 4.0),
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                  )
                ),
                const SizedBox(height: 15.0),
                Text(
                  widget.featuredContent.description,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                    shadows: [
                      Shadow(
                        color: Colors.black,
                        offset: Offset(2.0, 4.0),
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                Row(
                  children: [
                    FlatButton.icon(
                      padding: !Responsive.isDesktop(context)
                          ? const EdgeInsets.fromLTRB(15.0, 5.0, 20.0, 5.0)
                          : const EdgeInsets.fromLTRB(25.0, 10.0, 30.0, 10.0),
                      onPressed: () =>
                          SystemChrome.setPreferredOrientations([
                            DeviceOrientation.landscapeRight,
                            DeviceOrientation.landscapeLeft,
                          ]).then((e) {
                            Application.router.navigateTo(
                              context,
                              Routes.video,
                              routeSettings: RouteSettings(
                                arguments: {'title': widget.featuredContent.name},
                              ),
                              transition: TransitionType.inFromBottom,
                              transitionDuration: const Duration(milliseconds: 200),
                            );
                          }),
                      color: Colors.white,
                      icon: const Icon(Icons.play_arrow, size: 30.0),
                      label: const Text(
                        'Lecture',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    FlatButton.icon(
                      padding:
                      const EdgeInsets.fromLTRB(25.0, 10.0, 30.0, 10.0),
                      onPressed: ()  {
                        Application.router.navigateTo(
                            context,
                            '${Routes.detail}',
                            transition: TransitionType.inFromRight,
                            transitionDuration: const Duration(milliseconds: 200),
                        routeSettings: RouteSettings(
                        arguments: {'match': 99, 'show': widget.featuredContent},
                        )
                        );},
                      color: Colors.white,
                      icon: const Icon(Icons.info_outline, size: 30.0),
                      label: const Text(
                        'Infos',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20.0),
                    if (_videoController.value.isInitialized)
                      IconButton(
                        icon: Icon(
                          _isMuted ? Icons.volume_off : Icons.volume_up,
                        ),
                        color: Colors.white,
                        iconSize: 30.0,
                        onPressed: () => setState(() {
                          _isMuted
                              ? _videoController.setVolume(100)
                              : _videoController.setVolume(0);
                          _isMuted = _videoController.value.volume == 0;
                        }),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}