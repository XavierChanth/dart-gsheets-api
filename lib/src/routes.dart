import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'gSheetRoute.dart';

class Routes {
  Handler get handler {
    final router = Router();

    // router.mount('/taxonomy', GSheetRoute(_spreadsheetId, _firstDataRow, _worksheets));

    // router.mount('/dev-errors', GSheetRoute(_spreadsheetId, _firstDataRow, _worksheets));

    // Example
    // router.mount('/example', GSheetRoute(_spreadsheetId, _firstDataRow, _worksheets));
    // String _spreadsheetId: id of the spreadsheet
    // int _firstDataRow: row of the first data (after the header)
    // List<String> _worksheets: ids of all the worksheets to include in the api

    return router;
  }
}
