part of netflix;

class HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));
    controller = TabController(length: 5, initialIndex: 0, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: TabBar(
        labelStyle: TextStyle(fontSize: 10.0),
        indicatorWeight: 0.1,
        controller: controller,
        tabs: <Widget>[
          Tab(text: 'Accueil', icon: Icon(Icons.home)),
          Tab(text: 'Rechercher', icon: Icon(Icons.search)),
          Tab(text: 'Prochainement', icon: Icon(Icons.ondemand_video)),
          Tab(text: 'Téléchargements', icon: Icon(Icons.file_download)),
          Tab(text: 'Menu', icon: Icon(Icons.menu)),
        ],
      ),
      body: TabBarView(
        controller: controller,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          Summary(),
          Summary(),
          Summary(),
          Summary(),
          Summary(),
        ],
      ),
    );
  }
}
