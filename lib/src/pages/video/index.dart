part of netflix;

class Video extends StatefulWidget {
  final String video;
  Video({Key key, this.video}) : super(key: key);

  @override
  VideoState createState() => VideoState();
}
