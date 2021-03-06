import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf/shelf.dart' show Pipeline, logRequests;
import 'routes.dart';
import 'package:dotenv/dotenv.dart' show load, isEveryDefined, env;

void main() async {
  load();
  if (isEveryDefined(['HOST', 'PORT', 'GSHEET_CREDENTIALS'])) {
    final HOST = env['HOST'];
    final PORT = int.parse(env['PORT']!);

    final handler =
        Pipeline()
        //.addMiddleware(logRequests()) //
        .addHandler(Routes.handler);

    final server = await io.serve(handler, HOST, PORT);

    print('Server running on $HOST:${server.port}');
  } else {
    print('Error: Missing environment variables!');
  }
}
