import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:gsheets/gsheets.dart' show Spreadsheet, Worksheet;
import 'package:dart_gsheets_api/src/gSheetDriver.dart';
import 'package:dart_gsheets_api/src/cors.dart';

class GSheetRoute {
  final GSheetDriver _gSheetDriver = GSheetDriver.getInstance();

  final String _spreadsheetId;
  final Map<int, int> _worksheets;

  Spreadsheet? _spreadsheet;
  DateTime lastUpdate = DateTime.now();

  GSheetRoute(this._spreadsheetId, this._worksheets);

  bool _shouldRefresh() =>
      _spreadsheet == null || lastUpdate.difference(DateTime.now()).inHours > 0;

  Future<void> _refresh() async {
    _spreadsheet = await _gSheetDriver.getSpreadsheet(_spreadsheetId);
  }

  Worksheet _worksheet(id) => _spreadsheet!.worksheetById(id)!;

  Router _mountRouter(int worksheetId, int firstRow) {
    final router = Router();

    // This will error out since it tries to map to itself.
    router.get('/column/0',
        (req) => Response.notFound('Not Found', headers: Cors.headers));

    router.get('/column/<column|[0-9]+>', (req, String column) async {
      try {
        if (_shouldRefresh()) await _refresh();
        var data = await _worksheet(worksheetId)
            .values
            .map
            .column(int.parse(column) + 1, fromRow: firstRow);
        return Response.ok(jsonEncode(data), headers: Cors.headers);
      } catch (e) {
        print('Error: $e');
        return Response.internalServerError(headers: Cors.headers);
      }
    });

    router.get('/row/<row|-?[0-9]+>', (req, String row) async {
      try {
        if (_shouldRefresh()) await _refresh();
        var data = (await _worksheet(worksheetId)
            .values
            .row(int.parse(row) + firstRow - 1));
        return Response.ok(jsonEncode(data), headers: Cors.headers);
      } catch (e) {
        print('Error: $e');
        return Response.internalServerError(headers: Cors.headers);
      }
    });

    return router;
  }

  Router get router {
    final router = Router();
    router.get('/refresh', (req) async {
      try {
        await _refresh();
        return Response.ok('Refreshed sheet', headers: Cors.headers);
      } catch (e) {
        print('Error: $e');
        return Response.internalServerError(headers: Cors.headers);
      }
    });

    _worksheets.forEach((worksheetId, firstRow) =>
        router.mount('/$worksheetId/', _mountRouter(worksheetId, firstRow)));

    return router;
  }
}
