import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import 'dart:convert';

List<FakeTitleBodyData> withdrawalListViewFromJson(String str) => List<FakeTitleBodyData>.from(json.decode(str).map((x) => FakeTitleBodyData.fromJson(x)));

String withdrawalListViewToJson(List<FakeTitleBodyData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FakeTitleBodyData {
  final int userId;
  final int id;
  final String title;
  final String body;

  FakeTitleBodyData({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory FakeTitleBodyData.fromJson(Map<String, dynamic> json) => FakeTitleBodyData(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        body: json["body"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "body": body,
      };
}

//// =========================================

class FakeTitleBodyDataSource extends DataGridSource {
  FakeTitleBodyDataSource({required List<FakeTitleBodyData> fakeTitleBodyData}) {
    _fakeTitleBodyData = fakeTitleBodyData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'userId', value: e.userId),
              DataGridCell<int>(columnName: 'id', value: e.id),
              DataGridCell<String>(columnName: 'title', value: e.title),
              DataGridCell<String>(columnName: 'body', value: e.body),
            ]))
        .toList();
  }

  List<DataGridRow> _fakeTitleBodyData = [];

  @override
  List<DataGridRow> get rows => _fakeTitleBodyData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    List<Widget> cellsWidgets = [];
    for (var cell in row.getCells()) {
      cellsWidgets.add(
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: Text(cell.value.toString()),
        ),
      );
    }
    return DataGridRowAdapter(cells: cellsWidgets);
  }
}
