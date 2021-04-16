part of netflix;

var rootHandler = Handler(
  handlerFunc: (context, params) {
    return Home();
  },
);
var summaryRouteHandler = Handler(
  handlerFunc: (context, params) {
    return Summary();
  },
);
var detailRouteHandler = Handler(
  handlerFunc: (context, params) {
    final dynamic object = context.settings.arguments;
    return TvShow(match: object['match'], item: object['show']);
  },
);
var trailerRouteHandler = Handler(
  handlerFunc: (context, params) {
    final dynamic object = context.settings.arguments;
    return Video(video: object['video']);
  },
);
var filterRouteHandler = Handler(
  handlerFunc: (context, params) {
    final dynamic object = context.settings.arguments;
    return Filter(
      type: object['type'],
    );
  },
);
