import 'package:flutter_edgar_sec/src/model/financials/balance_sheet.dart';
import 'package:flutter_edgar_sec/src/model/r3_financial_statement.dart';
import 'package:flutter_edgar_sec/src/processor/utils/base_processor.dart';

/// Processes the balance sheet from the json response
/// https://seekingalpha.com/symbol/AAPL/balance-sheet
class BalanceSheetProcessor {

  // stockholdersequityincludingportionattributabletononcontrollinginterestabstract’: [‘Equity:’,
  // “Stockholders’ Equity, Including Portion Attributable to Noncontrolling Interest [Abstract]”],
  // ‘commonstockvalue’: [‘Common stock’,
  // ‘Common Stock, Value, Issued’],
  // ‘additionalpaidincapital’: [‘Capital in excess of par value’,
  // ‘Additional Paid in Capital’],
  // ‘retainedearningsaccumulateddeficit’: [‘Retained earnings’,
  // ‘Retained Earnings (Accumulated Deficit)’],
  // ‘stockholdersequity’: [“Total Walmart shareholders’ equity”,
  // “Stockholders’ Equity Attributable to Parent”],
  // ‘minorityinterest’: [‘Nonredeemable noncontrolling interest’,
  // “Stockholders’ Equity Attributable to Noncontrolling Interest”],
  // ‘liabilitiesandstockholdersequity’: [‘Total liabilities and equity’,
  // ‘Liabilities and Equity’],
  // ‘comprehensiveincomenotetextblock’: [‘Accumulated Other Comprehensive Income (Loss)’,
  // ‘Comprehensive Income (Loss) Note [Text Block]’],
  // ‘incomestatementabstract’: [‘Income Statement [Abstract]’],
  // ‘revenuesabstract’: [‘Revenues:’, ‘Revenues [Abstract]’],
  // ‘salesrevenuenet’: [‘Net sales’, ‘Revenue, Net’],

  // CommonStockSharesIssued
  // description: "Total number of common shares of an entity that have been sold or granted to shareholders (includes common shares that were issued, repurchased and remain in the treasury). These shares represent capital invested by the firm's shareholders and owners, and may be all or only a portion of the number of shares authorized. Shares issued include shares outstanding and shares held in the treasury."
  // label:"Common Stock, Shares, Issued"

  // CommonStockSharesOutstanding
  // description: "Number of shares of common stock outstanding. Common stock represent the ownership interest in a corporation."
  // label:"Common Stock, Shares, Outstanding"

  // CommonStockValue
  // description: "Aggregate par or stated value of issued nonredeemable common stock (or common stock redeemable solely at the option of the issuer). This item includes treasury stock repurchased by the entity. Note: elements for number of nonredeemable common shares, par value and other disclosure concepts are in another section within stockholders' equity."
  // label: "Common Stock, Value, Issued"

  // AvailableForSaleSecuritiesCurrent"
  // "label": "Available-for-sale Securities, Current",
  // "description": "Amount of investment in debt and equity securities categorized neither as trading securities nor held-to-maturity securities and intended be sold or mature one year or operating cycle, if longer.",

  // This is Seeking Alpha's Short Term Investments
  // "MarketableSecuritiesCurrent":
  // "label": "Marketable Securities, Current",
  // "description": "Amount of investment in marketable security, classified as current.",

  // Cash % Short term Investments
  // static const Set<String> cashAndShortTermInvestments = {
  //   // SEC EDGAR's field names               // Seeking Alpha's Names
  //   'CashAndCashEquivalentsAtCarryingValue', // Cash And Equivalents
  //   // 'AvailableForSaleSecuritiesCurrent',     // Short Term Investments - Incomplete
  //   'MarketableSecuritiesCurrent',           // Short Term Investments
  // };

  static const Set<String> supportedFields = {
    // SEC EDGAR's field names               // Seeking Alpha's Names
    'CashAndCashEquivalentsAtCarryingValue', // Cash And Equivalents
    'MarketableSecuritiesCurrent',           // Short Term Investments


    'AssetsCurrent'                          // Total Current Assets
  };

  static void process(
    Map<String, dynamic> facts,
    Map<String, FinancialStatement> index,
    String typeOfForm,
  ) {
    for (final field in supportedFields) {
      // Filter the quarters, i.e. rows that are 10-Q
      final periods = BaseProcessor.getRows(
        facts,
        field,
        index,
        typeOfForm: typeOfForm,
      );



      //TODO - NF - should we change "quarter" for "period"? because period can
      //TODO - represent a quarter or annual
      for (final period in periods) {
        final endDateString = period['end'];
        final value = period['val'] as num;
        final financialStatement = index[endDateString]!;
        final balanceSheet = financialStatement.balanceSheet;

        //print('index: '+ financialStatement.period.toString());

        _mapValue(field, value.toDouble(), balanceSheet);
      }
    }
  }

  static void _mapValue(String field, double value, BalanceSheet balanceSheet) {

    //print('field: '+field);

    // if (cashAndShortTermInvestments.contains(field)) {
    //   balanceSheet.cashAndCashEquivalents = value;
    //   return;
    // }

    switch (field) {
      case 'CashAndCashEquivalentsAtCarryingValue':
        print('setting CashAndCashEquivalentsAtCarryingValue with '+'perid '+value.toString());
        balanceSheet.cashAndCashEquivalents = value;
        break;
      case 'MarketableSecuritiesCurrent':
        print('setting MarketableSecuritiesCurrent with '+value.toString());
        balanceSheet.shortTermInvestments = value;
        break;
      case 'AssetsCurrent':
        balanceSheet.currentAssets = value;
        break;
    }
  }
}
