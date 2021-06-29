import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'routes/index.dart';

class Routes {
  Handler get handler {
    final router = Router();

    router.mount('/taxonomy', Taxonomy().router);
    router.mount('/dev-errors', DevErrors().router);

    router.all('/<.*>', (req) => Response.notFound('Not Found'));

    return router;
  }
}
