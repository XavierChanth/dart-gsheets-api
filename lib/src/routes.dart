import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'gSheetRoute.dart';

class Routes {
  Handler get handler {
    final router = Router();

    // TODO YOUR ROUTES GO HERE
    router.mount(
        '/test/',
        GSheetRoute('14wq8Poj_-um8VrDkIAe7opoaO44X79T6vw0e3mX1unk', {0: 3})
            .router);

    return router;
  }
}
