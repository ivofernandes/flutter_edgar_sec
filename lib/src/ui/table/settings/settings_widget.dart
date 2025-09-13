import 'package:flutter/material.dart';
import 'package:flutter_edgar_sec/src/model/enums/financial_statment_period.dart';
import 'package:flutter_edgar_sec/src/model/enums/financial_type.dart';

class SettingsWidget extends StatefulWidget {
  final FinancialStatementPeriod financialStatementPeriod;
  final FinancialType financialType;

  final ValueChanged<FinancialStatementPeriod>
      onFinancialStatementPeriodChanged;
  final ValueChanged<FinancialType> onFinancialTypeChanged;

  const SettingsWidget({
    required this.financialStatementPeriod,
    required this.financialType,
    required this.onFinancialStatementPeriodChanged,
    required this.onFinancialTypeChanged,
    super.key,
  });

  @override
  State<SettingsWidget> createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {
  late FinancialStatementPeriod currentFinancialStatementPeriod;
  late FinancialType currentFinancialType;

  @override
  void initState() {
    super.initState();
    currentFinancialStatementPeriod = widget.financialStatementPeriod;
    currentFinancialType = widget.financialType;
  }

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text('Financial Statement Period'),
            trailing: DropdownButton<FinancialStatementPeriod>(
              value: currentFinancialStatementPeriod,
              onChanged: (newPeriod) {
                widget.onFinancialStatementPeriodChanged(newPeriod!);
                currentFinancialStatementPeriod = newPeriod;
                setState(() {});
              },
              items: FinancialStatementPeriod.values
                  .map(
                    (period) => DropdownMenuItem(
                      value: period,
                      child: Text(period.toString().split('.').last),
                    ),
                  )
                  .toList(),
            ),
          ),
          ListTile(
            title: const Text('Financial Type'),
            trailing: DropdownButton<FinancialType>(
              value: currentFinancialType,
              onChanged: (newType) {
                widget.onFinancialTypeChanged(newType!);
                currentFinancialType = newType;
                setState(() {});
              },
              items: FinancialType.values
                  .map((type) => DropdownMenuItem(
                        value: type,
                        child: Text(type.toString().split('.').last),
                      ))
                  .toList(),
            ),
          ),
        ],
      );
}
