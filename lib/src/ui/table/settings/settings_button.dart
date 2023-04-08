import 'package:flutter/material.dart';
import 'package:flutter_edgar_sec/src/model/enums/financial_statment_period.dart';
import 'package:flutter_edgar_sec/src/model/enums/financial_type.dart';
import 'package:flutter_edgar_sec/src/ui/table/settings/settings_widget.dart';

/// A custom widget that displays a settings button that opens a bottom sheet
class SettingsButton extends StatefulWidget {
  /// The current financial statement period.
  final FinancialStatementPeriod financialStatementPeriod;

  /// The current financial type: income, balance sheet or cash flow
  final FinancialType financialType;

  /// The callback to be called when the financial statement period is changed.
  final ValueChanged<FinancialStatementPeriod> onFinancialStatementPeriodChanged;

  /// The callback to be called when the financial type is changed.
  final ValueChanged<FinancialType> onFinancialTypeChanged;

  const SettingsButton({
    required this.financialStatementPeriod,
    required this.financialType,
    required this.onFinancialStatementPeriodChanged,
    required this.onFinancialTypeChanged,
    super.key,
  });

  @override
  State<SettingsButton> createState() => _SettingsButtonState();
}

class _SettingsButtonState extends State<SettingsButton> {
  @override
  Widget build(BuildContext context) => IconButton(
        icon: const Icon(Icons.settings),
        onPressed: () => _showSettingsBottomSheet(context),
      );

  void _showSettingsBottomSheet(BuildContext context) {
    showModalBottomSheet<Widget>(
      context: context,
      builder: (context) => SettingsWidget(
        financialStatementPeriod: widget.financialStatementPeriod,
        financialType: widget.financialType,
        onFinancialStatementPeriodChanged: widget.onFinancialStatementPeriodChanged,
        onFinancialTypeChanged: widget.onFinancialTypeChanged,
      ),
    );
  }
}
