# Dart GSheets Api

Dynamically generates api routes for google sheets.

## Creating a Route

The routes API automatically generates routes to get the rows and columns of a spreadsheet. See how to create one below.

```dart
//GSheetRoute
GSheetRoute(String spreadsheetId, Map<int, int> worksheets)
```

> `String spreadsheetId`: ID of the spreadsheet (can be found in the URL)  
> `Map<int, int> worksheets`: ID of the worksheet mapped to first row of data

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

## Sheet Format

The first column of the sheet must contain an index in ascending order to map the rows to.
The first row containing data must start at 1 to map rows correctly.

![image](https://user-images.githubusercontent.com/33691921/123737165-7b35eb00-d870-11eb-9b5a-80933ba5e7ba.png)

## Example
```dart
router.mount(
  '/example/',
  GSheetRoute('mySpreadsheetId', {0:2}).router
);
```
`'/example/'`  
> The route for this spreadsheet.

`'mySpreadsheetId'`  
> The id of the spreadsheet can be found in the url

`{0:2}`  
> 0 is the worksheet id  
The worksheet id is found in the url as `?gid=<worksheetId>`

> 2 is the first row of data  
Access data rows using positive numbers.  
i.e /row/1 becomes the first row of data when calling the api.  
Access non-data rows using positive numbers.  
i.e /row/0 is the row immediately before the first row of data  
(you can use negative numbers as well.)
