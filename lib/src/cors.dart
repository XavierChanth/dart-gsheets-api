import 'dart:async';
import 'package:shelf/shelf.dart' show Request, Response, createMiddleware;

class Cors {
  static Map<String, String> get headers => {
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Methods': 'GET, OPTIONS',
        'Access-Control-Allow-Headers': '*',
        'content-type': 'application/json'
      };

  // static Response _options(Request req) =>
  //     Response.ok(null, headers: headers);

  // static Response _cors(Response res) => res.change(headers: headers);

  // static final _corsMiddleware =
  //     createMiddleware(requestHandler: _options, responseHandler: _cors);

  // static FutureOr<Response> Function(Request) Function(
  //     FutureOr<Response> Function(Request)) get middleware => _corsMiddleware;
}
