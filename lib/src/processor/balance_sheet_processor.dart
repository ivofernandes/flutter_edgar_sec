import 'package:flutter_edgar_sec/src/model/enums/financial_statment_period.dart';
import 'package:flutter_edgar_sec/src/model/financials/balance_sheet.dart';
import 'package:flutter_edgar_sec/src/model/r3_financial_statement.dart';
import 'package:flutter_edgar_sec/src/processor/utils/base_processor.dart';
import 'package:flutter_edgar_sec/src/utils/app_logger.dart';

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

  // "AccountsReceivableNetCurrent"
  // "label": "Accounts Receivable, after Allowance for Credit Loss, Current",
  // "description": "Amount, after allowance for credit loss, of right to consideration from customer for product sold and service rendered in normal course of business, classified as current.",

  // "NontradeReceivablesCurrent"
  // "label": "Nontrade Receivables, Current",
  // "description": "The sum of amounts currently receivable other than from customers. For classified balance sheets, represents the current amount receivable, that is amounts expected to be collected within one year or the normal operating cycle, if longer.",

  // "InventoryNet"
  // "label": "Inventory, Net",
  // "description": "Amount after valuation and LIFO reserves of inventory expected to be sold, or consumed within one year or operating cycle, if longer.",

  // "DeferredTaxAssetsNetCurrent"
  // "label": "Deferred Tax Assets, Net of Valuation Allowance, Current",
  // "description": "Amount after allocation of valuation allowances of deferred tax asset attributable to deductible temporary differences and carryforwards classified as current.",

  // "RestrictedCashAndCashEquivalentsAtCarryingValue"
  // "label": "Restricted Cash and Cash Equivalents, Current",
  // "description": "Amount of cash and cash equivalents restricted as to withdrawal or usage, classified as current. Cash includes, but is not limited to, currency on hand, demand deposits with banks or financial institutions, and other accounts with general characteristics of demand deposits. Cash equivalents include, but are not limited to, short-term, highly liquid investments that are both readily convertible to known amounts of cash and so near their maturity that they present insignificant risk of changes in value because of changes in interest rates.",

  // "OtherAssetsCurrent"
  // "label": "Other Assets, Current",
  // "description": "Amount of current assets classified as other.",

  // "AssetsCurrent"
  // "label": "Assets, Current",
  // "description": "Sum of the carrying amounts as of the balance sheet date of all assets that are expected to be realized in cash, sold, or consumed within one year (or the normal operating cycle, if longer). Assets are probable future economic benefits obtained or controlled by an entity as a result of past transactions or events.",

  //Add these two fields to get the "Gross Property, Plant & Equipment" field
  // PropertyPlantAndEquipmentGross
  // "label": "Property, Plant and Equipment, Gross",
  // "description": "Amount before accumulated depreciation, depletion and amortization of physical assets used in the normal conduct of business and not intended for resale. Examples include, but are not limited to, land, buildings, machinery and equipment, office equipment, and furniture and fixtures.",
  // +
  // "OperatingLeaseRightOfUseAsset"
  // "label": "Operating Lease, Right-of-Use Asset",
  // "description": "Amount of lessee's right to use underlying asset under operating lease.",

  // "AccumulatedDepreciationDepletionAndAmortizationPropertyPlantAndEquipment"
  // "label": "Accumulated Depreciation, Depletion and Amortization, Property, Plant, and Equipment",
  // "description": "Amount of accumulated depreciation, depletion and amortization for physical assets used in the normal conduct of business to produce goods and services.",

  // "PropertyPlantAndEquipmentNet"
  // "label": "Property, Plant and Equipment, Net",
  // "description": "Amount after accumulated depreciation, depletion and amortization of physical assets used in the normal conduct of business to produce goods and services and not intended for resale. Examples include, but are not limited to, land, buildings, machinery and equipment, office equipment, and furniture and fixtures.",

  // Long Term Investments
  // "AvailableForSaleSecuritiesNoncurrent"
  // "label": "Available-for-sale Securities, Noncurrent",
  // "description": "Investments in debt and equity securities which are categorized neither as held-to-maturity nor trading and which are intended to be sold or mature more than one year from the balance sheet date or operating cycle, if longer. Such securities are reported at fair value; unrealized gains (losses) related to Available-for-sale Securities are excluded from earnings and reported in a separate component of shareholders' equity (other comprehensive income), unless the Available-for-sale security is designated as a hedge or is determined to have had an other than temporary decline in fair value below its amortized cost basis. All or a portion of the unrealized holding gain (loss) of an Available-for-sale security that is designated as being hedged in a fair value hedge is recognized in earnings during the period of the hedge, as are other than temporary declines in fair value below the cost basis for investments in equity securities and debt securities that an entity intends to sell or it is more likely than not that it will be required to sell before the recovery of its amortized cost basis. Other than temporary declines in fair value below the cost basis for debt securities categorized as Available-for-sale that an entity does not intend to sell and for which it is not more likely than not that the entity will be required to sell before the recovery of its amortized cost basis are bifurcated into credit losses and losses related to all other factors. Other than temporary declines in fair value below cost basis related to credit losses are recognized in earnings, and losses related to all other factors are recognized in other comprehensive income.",
  // +
  // "MarketableSecuritiesNoncurrent"
  // "label": "Marketable Securities, Noncurrent",
  // "description": "Amount of investment in marketable security, classified as noncurrent.",

  // "Goodwill":
  // "label": "Goodwill",
  // "description": "Amount after accumulated impairment loss of an asset representing future economic benefits arising from other assets acquired in a business combination that are not individually identified and separately recognized.",

  // "IntangibleAssetsNetExcludingGoodwill"
  // "label": "Intangible Assets, Net (Excluding Goodwill)",
  // "description": "Sum of the carrying amounts of all intangible assets, excluding goodwill, as of the balance sheet date, net of accumulated amortization and impairment charges.",

  // "OtherAssetsNoncurrent"
  // "label": "Other Assets, Noncurrent",
  // "description": "Amount of noncurrent assets classified as other.",

  // Current Liabilities

  // "AccountsPayableCurrent"
  // "label": "Accounts Payable, Current",
  // "description": "Carrying value as of the balance sheet date of liabilities incurred (and for which invoices have typically been received) and payable to vendors for goods and services received that are used in an entity's business. Used to reflect the current portion of the liabilities (due within one year or within the normal operating cycle if longer).",

  // "AccruedLiabilitiesCurrent"
  // "label": "Accrued Liabilities, Current",
  // "description": "Carrying value as of the balance sheet date of obligations incurred and payable, pertaining to costs that are statutory in nature, are incurred on contractual obligations, or accumulate over time and for which invoices have not yet been received or will not be rendered. Examples include taxes, interest, rent and utilities. Used to reflect the current portion of the liabilities (due within one year or within the normal operating cycle if longer).",

  // "CommercialPaper"
  // "label": "Commercial Paper",
  // "description": "Carrying value as of the balance sheet date of short-term borrowings using unsecured obligations issued by banks, corporations and other borrowers to investors. The maturities of these money market securities generally do not exceed 270 days.",

  // "LongTermDebtCurrent"
  // "label": "Long-term Debt, Current Maturities",
  // "description": "Amount, after unamortized (discount) premium and debt issuance costs, of long-term debt, classified as current. Includes, but not limited to, notes payable, bonds payable, debentures, mortgage loans and commercial paper. Excludes capital lease obligations.",

  // "OtherLiabilitiesCurrent"
  // "label": "Other Liabilities, Current",
  // "description": "Amount of liabilities classified as other, due within one year or the normal operating cycle, if longer.",

  // "ContractWithCustomerLiabilityCurrent"
  // "label": "Contract with Customer, Liability, Current",
  // "description": "Amount of obligation to transfer good or service to customer for which consideration has been received or is receivable, classified as current.",
  // "DeferredRevenueCurrent"
  // "label": "Deferred Revenue, Current",
  // "description": "Amount of deferred income and obligation to transfer product and service to customer for which consideration has been received or is receivable, classified as current.",

  // Cash % Short term Investments
  static const Set<String> shortTermInvestments = {
    // SEC EDGAR's field names               // Seeking Alpha's Names
    'AvailableForSaleSecuritiesCurrent', // Short Term Investments - from 2008 to 2018
    'MarketableSecuritiesCurrent', // Short Term Investments - from 2018 to ...
  };

  static const Set<String> longTermInvestments = {
    // SEC EDGAR's field names               // Seeking Alpha's Names
    'AvailableForSaleSecuritiesNoncurrent', // Long Term Investments - from 2008 to 2018
    'MarketableSecuritiesNoncurrent', // Long Term Investments - from 2018 to ...
  };

  static const Set<String> unearnedRevenueCurrent = {
    // SEC EDGAR's field names               // Seeking Alpha's Names
    'ContractWithCustomerLiabilityCurrent', // unearnedRevenueCurrent - part 1
    'DeferredRevenueCurrent', // unearnedRevenueCurrent - part 2
  };

  static const Set<String> supportedFields = {
    // SEC EDGAR's field names               // Seeking Alpha's Names
    //Total Cash & ST Investments
    'CashAndCashEquivalentsAtCarryingValue', // Cash And Equivalents
    ...shortTermInvestments, // Short Term Investments
    //Receivables
    'AccountsReceivableNetCurrent', // Accounts Receivable
    'NontradeReceivablesCurrent', // Other Receivables
    //Current Assets
    'InventoryNet', // Inventory
    'DeferredTaxAssetsNetCurrent', // Deferred Tax Assets Current
    'RestrictedCashAndCashEquivalentsAtCarryingValue', // Restricted Cash
    'OtherAssetsCurrent', // Other Current Assets
    'AssetsCurrent', // Total Current Assets
    //Long Term Assets
    'PropertyPlantAndEquipmentGross', // Gross Property, Plant & Equipment
    'OperatingLeaseRightOfUseAsset', // Gross Property, Plant & Equipment
    'AccumulatedDepreciationDepletionAndAmortizationPropertyPlantAndEquipment', // Acc Depreciation
    'PropertyPlantAndEquipmentNet', // Net Property, Plant & Equipment
    ...longTermInvestments, // Long Term Investments
    'Goodwill', // Goodwill
    'IntangibleAssetsNetExcludingGoodwill', // Other Intangibles excluding Goodwill
    'OtherAssetsNoncurrent', // Other Long Term Assets

    'LiabilitiesAndStockholdersEquity', // Total Assets

    //Current Liabilities
    'AccountsPayableCurrent', // Accounts Payable
    'AccruedLiabilitiesCurrent', // Accrued Expenses
    'CommercialPaper', // Short term Borrowings
    'LongTermDebtCurrent', // Current Portion of LT Debt
    'StockholdersEquity',
    ...unearnedRevenueCurrent, // Unearned Revenue Current
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

      for (final period in periods) {
        final endDateString = period['end'];
        final value = period['val'] as num;
        final financialStatement = index[endDateString]!;
        final balanceSheet = financialStatement.balanceSheet;

        if (financialStatement.period == FinancialStatementPeriod.annual && field == 'AccruedLiabilitiesCurrent') {
          AppLogger().debug('period -> ${financialStatement.period} ${financialStatement.year}   ->>> $value');
        }

        _mapValue(field, value.toDouble(), balanceSheet);
      }
    }
  }

  static void _mapValue(String field, double value, BalanceSheet balanceSheet) {
    if (shortTermInvestments.contains(field)) {
      // AppLogger().debug('setting the field '+ field + ' with value '+value.toString());
      balanceSheet.shortTermInvestments = value;
      return;
    }

    if (longTermInvestments.contains(field)) {
      balanceSheet.longTermInvestments = value;
      return;
    }

    if (unearnedRevenueCurrent.contains(field)) {
      balanceSheet.unearnedRevenueCurrent = value;
      return;
    }

    // AppLogger().debug('Field --->>> '+ field + ' with value '+value.toString());

    switch (field) {
      case 'OtherAssetsCurrent':
        balanceSheet.otherCurrentAssets = value;
        break;
      case 'CashAndCashEquivalentsAtCarryingValue':
        balanceSheet.cashAndCashEquivalents = value;
        break;
      case 'AccountsReceivableNetCurrent':
        balanceSheet.accountsReceivable = value;
        break;
      case 'NontradeReceivablesCurrent':
        balanceSheet.otherReceivables = value;
        break;
      case 'InventoryNet':
        balanceSheet.inventory = value;
        break;
      case 'DeferredTaxAssetsNetCurrent':
        balanceSheet.deferredTaxAssets = value;
        break;
      case 'RestrictedCashAndCashEquivalentsAtCarryingValue':
        balanceSheet.restrictedCash = value;
        break;
      case 'AssetsCurrent':
        balanceSheet.currentAssets = value;
        break;
      case 'PropertyPlantAndEquipmentGross':
        balanceSheet.grossPropertyPlantEquipment = balanceSheet.grossPropertyPlantEquipment + value;
        break;
      case 'OperatingLeaseRightOfUseAsset':
        balanceSheet.grossPropertyPlantEquipment = balanceSheet.grossPropertyPlantEquipment + value;
        break;
      case 'AccumulatedDepreciationDepletionAndAmortizationPropertyPlantAndEquipment':
        balanceSheet.accumulatedDepreciation = value;
        break;
      case 'PropertyPlantAndEquipmentNet':
        balanceSheet.netPropertyPlantEquipment = value;
        break;
      case 'Goodwill':
        balanceSheet.goodwill = value;
        break;
      case 'IntangibleAssetsNetExcludingGoodwill':
        balanceSheet.otherIntangibles = value;
        break;
      case 'OtherAssetsNoncurrent':
        balanceSheet.otherLongTermAssets = value;
        break;
      case 'LiabilitiesAndStockholdersEquity':
        balanceSheet.totalAssets = value;
        break;
      case 'AccountsPayableCurrent':
        balanceSheet.accountsPayable = value;
        break;
      case 'AccruedLiabilitiesCurrent':
        balanceSheet.accruedExpenses = value;
        break;
      case 'CommercialPaper':
        balanceSheet.shortTermBorrowings = value;
        break;
      case 'LongTermDebtCurrent':
        balanceSheet.currentPortionLtDebt = value;
        break;
      case 'StockholdersEquity':
        balanceSheet.equity = value;
        break;
    }
  }
}
