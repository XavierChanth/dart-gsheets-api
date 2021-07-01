import 'package:shelf/shelf.dart' show Handler;
import 'package:shelf_router/shelf_router.dart' show Router;
import 'package:dart_gsheets_api/src/gSheetRoute.dart';

class Routes {
  static Handler get handler {
    final router = Router();

    // TODO YOUR ROUTES GO HERE
    router.mount(
        '/ErrorForm/',
        GSheetRoute('14wq8Poj_-um8VrDkIAe7opoaO44X79T6vw0e3mX1unk', {0: 2})
            .router);

    return router;
  }
}
