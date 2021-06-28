import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:gsheets/gsheets.dart' show Spreadsheet, Worksheet;
import 'package:dart_gsheets_api/src/gSheetDriver.dart';

class Taxonomy {
  final GSheetDriver _gSheetDriver = GSheetDriver.getInstance();
  Spreadsheet? _spreadsheet;

  Taxonomy() {
    getSheet();
  }

  Future<void> getSheet() async {
    _spreadsheet = await _gSheetDriver.getSpreadsheet('');
  }

  Router get router {
    final router = Router();

    router.get('/refresh', (req) {
      getSheet();
      return Response.ok('Refreshing sheet');
    });

    //Add API Routes HERE

    router.all('/<.*>', (req) => Response.notFound('Not Found'));

    return router;
  }
}
