import 'package:flutter/material.dart';
import 'package:flutter_edgar_sec/flutter_edgar_sec.dart';
import 'package:flutter_edgar_sec/src/model/financials/income_statement.dart';

/// Class to get the rows of the income statement table
class IncomeStatementRows {
  static List<DataRow> getRows(List<IncomeStatement> incomeStatements) {
    final List<DataRow> rows = [];

    rows.add(revenueRow(incomeStatements));

    return rows;
  }

  static DataRow revenueRow(List<IncomeStatement> incomeStatements) {
    final List<DataCell> cells = [
      const DataCell(
        Text('Revenue'),
      ),
      ...incomeStatements
          .map(
            (e) => DataCell(
              Text(e.revenues.millions.toString()),
            ),
          )
          .toList()
    ];

    return DataRow(cells: cells);
  }
}
