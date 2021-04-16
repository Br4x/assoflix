part of netflix;

class SummaryState extends State<Summary> {
  void goTo(String type) {
    Application.router.navigateTo(
      context,
      '${Routes.filter}',
      transition: TransitionType.nativeModal,
      transitionDuration: const Duration(milliseconds: 200),
      routeSettings: RouteSettings(
        arguments: {'type': type},
      ),
    );
  }


  void playSound() async {
    AudioPlayer audioPlayer = AudioPlayer();
    await audioPlayer.play("assoflix.mp3", isLocal: true);
  }

  void goToDetail(Result item, int match) {
    Application.router.navigateTo(
      context,
      '${Routes.detail}',
      transition: TransitionType.inFromRight,
      transitionDuration: const Duration(milliseconds: 200),
      routeSettings: RouteSettings(
        arguments: {'match': match, 'show': item},
      ),
    );
  }

  List<Widget> renderMainGenres() {
    List<Widget> genres = List.from(tvShow['details']['genres'].map((g) {
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
    }).toList());
    return genres;
  }

  Widget renderTitle(String tag, String text) {
    return Hero(
      tag: tag,
      child: FlatButton(
        onPressed: () => goTo(tag),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontSize: 14.0,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final Result show = Result.fromJson(tvShow);
    bloc.fetchAllMovies();
    return StreamBuilder(
      stream: bloc.allMovies,
      builder: (context, AsyncSnapshot<List<ItemModel>> snapshot) {
        if (snapshot.hasData) {
          //playSound();
          return CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: Row(
                  children: [
                    Padding(child: Image.asset('assets/images/assoflix-logo.png', height: 40),padding: EdgeInsets.only(left: 20.0, top: 5,bottom: 5)),
                    SizedBox(width: 12.0),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _AppBarButton(
                            title: 'Séries',
                            onTap: () => print('Séries'),
                          ),
                          _AppBarButton(
                            title: 'Films',
                            onTap: () => print('TV Shows'),
                          ),
                          _AppBarButton(
                            title: 'Ma liste',
                            onTap: () => print('Movies'),
                          )
                        ],
                      ),
                    ),
                    Spacer(),

                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: ContentHeader(featuredContent: show),
              ),

              SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, index) => ContentList(
                        title: snapshot.data[index].title,
                        contentList: snapshot.data[index].results,
                        onTap: goToDetail,
                        isOriginals: true,
                      ),
                  childCount: snapshot.data.length,
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => ShowsList(
                    items: snapshot.data[index].results,
                    onTap: goToDetail,
                    title: snapshot.data[index].title,
                  ),
                  childCount: snapshot.data.length,
                ),
              )
            ],
          );
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        return Center(
            child: CircularProgressIndicator(
          valueColor:
              AlwaysStoppedAnimation<Color>(Color.fromRGBO(219, 0, 0, 1.0)),
        ));
      },
    );
  }
}
