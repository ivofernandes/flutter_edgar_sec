import 'package:flutter/material.dart';
import 'package:flutter_edgar_sec/src/model/enums/financial_statment_period.dart';
import 'package:flutter_edgar_sec/src/model/enums/financial_type.dart';

class SettingsButton extends StatelessWidget {
  final FinancialStatementPeriod financialStatementPeriod;
  final FinancialType financialType;
  final ValueChanged<FinancialStatementPeriod> onFinancialStatementPeriodChanged;
  final ValueChanged<FinancialType> onFinancialTypeChanged;

  const SettingsButton({
    required this.financialStatementPeriod,
    required this.financialType,
    required this.onFinancialStatementPeriodChanged,
    required this.onFinancialTypeChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) => IconButton(
        icon: const Icon(Icons.settings),
        onPressed: () => _showSettingsBottomSheet(context),
      );

  void _showSettingsBottomSheet(BuildContext context) {
    showModalBottomSheet<Widget>(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text('Financial Statement Period'),
            trailing: DropdownButton<FinancialStatementPeriod>(
              value: financialStatementPeriod,
              onChanged: (newPeriod) {
                onFinancialStatementPeriodChanged(newPeriod!);
              },
              items: FinancialStatementPeriod.values
                  .map((period) => DropdownMenuItem(
                        value: period,
                        child: Text(period.toString().split('.').last),
                      ))
                  .toList(),
            ),
          ),
          ListTile(
            title: const Text('Financial Type'),
            trailing: DropdownButton<FinancialType>(
              value: financialType,
              onChanged: (newType) {
                onFinancialTypeChanged(newType!);
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
      ),
    );
  }
}
