import 'package:dotenv/dotenv.dart' show env;
import 'package:gsheets/gsheets.dart' show GSheets, Spreadsheet;

class GSheetDriver {
  static final GSheetDriver _singleton = GSheetDriver._internal();
  GSheetDriver._internal();

  factory GSheetDriver.getInstance() {
    return _singleton;
  }

  final GSheets _gSheets = GSheets(env['GSHEET_CREDENTIALS']);

  Future<Spreadsheet> getSpreadsheet(String spreadsheetId) async =>
      await _gSheets.spreadsheet(spreadsheetId);
}
