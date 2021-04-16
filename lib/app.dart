library netflix;

// Dart Imports
import 'dart:async';
import 'dart:convert';

// Flutter imports
import 'package:http/http.dart' show Client;
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

// Plugins import...
import 'package:fluro/fluro.dart';
import 'package:video_player/video_player.dart';

// Router
part 'src/helpers/config/constants.dart';
part 'src/helpers/config/application.dart';
part 'src/helpers/config/routes.dart';
part 'src/helpers/config/route_handlers.dart';

// Models
part 'src/models/episode.dart';
part 'src/models/result.dart';
part 'src/models/item_model.dart';

// Blocs
part 'src/blocs/movies_bloc.dart';

// Resources
part 'src/resources/movie_api_provider.dart';
part 'src/resources/repository.dart';

part 'src/utils/theme/color.dart';
part 'src/utils/theme/typography.dart';
part 'src/pages/video/index.dart';
part 'src/pages/video/state.dart';
part 'src/pages/home/index.dart';
part 'src/pages/home/state.dart';
part 'src/pages/summary/index.dart';
part 'src/pages/summary/state.dart';
part 'src/pages/filter/index.dart';
part 'src/pages/filter/state.dart';
part 'src/pages/detail/index.dart';
part 'src/pages/detail/state.dart';
part 'src/pages/summary/content_header.dart';

// Widgets
part 'src/widgets/tvshow-list/index.dart';
part 'src/widgets/player-life-cycle/index.dart';
part 'src/widgets/player-life-cycle/state.dart';
part 'src/widgets/player-controls/index.dart';
part 'src/widgets/player-controls/state.dart';
part 'src/widgets/responsive.dart';
part 'src/widgets/vertical_icon_button.dart';
part 'src/widgets/cubit.dart';
part 'src/widgets/custom_app_bar.dart';
part 'src/widgets/content_list.dart';


class Netflix extends StatelessWidget {
  Netflix({Key key}) : super(key: key) {
    final router = FluroRouter();
    Routes.configureRoutes(router);
    Application.router = router;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Netflix',
      theme: ThemeData(
        fontFamily: 'GoogleSans',
        primaryColor: Colors.black,
      ),
      onGenerateRoute: Application.router.generator,
      home: Home(),
    );
  }
}
