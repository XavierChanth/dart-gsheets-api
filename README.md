# Dart GSheets Api

Dynamically generates api routes for google sheets.

## Creating a Route

The routes API automatically generates routes to get the rows and columns of a spreadsheet. See how to create one below.

```dart
//GSheetRoute
GSheetRoute(String spreadsheetId, List<String> worksheetIds, {int? firstRow})
```

> `String spreadsheetId`: ID of the spreadsheet (can be found in the URL)  
> `List<String> worksheetIds`: IDs of the worksheets to include (found in the URL as gid=`worksheetId`)  
> `int? firstRow`: The first row containing data (defaults to row 1)

## Mounting your Route

To mount your route, simply place it in the body of routes.dart:

```dart
//routes.dart
router.mount('/example/', GSheetRoute(...).router);
```

Note: The route must start and end with a slash, as `/example/` does.

## Exposed Endpoints

In this case `/example` stands for the route you chose when you mounted it.

`GET /example/refresh`

The server automatically caches the spreadsheet data for one hour.  
This endpoint manually updates the cache.

`GET /example/<worksheetId>/column/<columnId>`

Returns a JSON object in the format of `{'rowIndex': 'cellValue'}`  
Note: Both the key and value are a string.

`GET /example/<worksheetId>/row/<rowId>`

Returns a JSON list, containing each cell value in order.  
Note: all values in the list are strings.
