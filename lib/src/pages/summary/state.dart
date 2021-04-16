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
          return CustomScrollView(

            slivers: <Widget>[
              SliverAppBar(
                primary: true,
                expandedHeight: screenSize.height * 0.65,
                backgroundColor: Colors.black,
                leading: Image.asset('assets/images/netflix_icon.png'),
                titleSpacing: 20.0,
                title: Title(
                  color: Colors.black,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      renderTitle('Series', 'Séries'),
                      renderTitle('Films', 'Films'),
                      renderTitle('Ma-liste', 'Ma liste'),
                    ],
                  ),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  background: Container(
                    child: Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        ContentHeader(featuredContent: show),
                      ],
                    ),
                  ),
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
