[![pub package](https://img.shields.io/pub/v/flutter_edgar_sec.svg?label=flutter_edgar_sec&color=blue)](https://pub.dev/packages/flutter_edgar_sec)
[![downloads](https://img.shields.io/pub/downloads/flutter_edgar_sec?logo=dart)](https://pub.dev/packages/flutter_edgar_sec/score)
[![likes](https://img.shields.io/pub/likes/flutter_edgar_sec?logo=dart)](https://pub.dev/packages/flutter_edgar_sec/score)
[![pub points](https://img.shields.io/pub/points/flutter_edgar_sec?logo=dart)](https://pub.dev/packages/flutter_edgar_sec/score)


# flutter_edgar_sec
Package to get data from https://www.sec.gov/edgar/

![Flutter edgar sec table example screenshot](https://raw.githubusercontent.com/ivofernandes/flutter_edgar_sec/main/docs/simulator_screenshot.png?raw=true)
![Flutter edgar sec char example screenshot](https://raw.githubusercontent.com/ivofernandes/flutter_edgar_sec/main/docs/simulator_screenshot_2.png?raw=true)


## Installation

Add this to your package's pubspec.yaml file:

```yaml
dependencies:
  flutter_edgar_sec: ^0.0.1
```

## Usage

After adding the dependency, you can use the package in your code by just adding an EdgarTableUI:

```dart
import 'package:flutter_edgar_sec/flutter_edgar_sec.dart';

EdgarTableUI(
  symbol: 'AAPL',
)


You can also try the CompanyChartUI:
    
import 'package:flutter_edgar_sec/flutter_edgar_sec.dart';
CompanyChartUI(
  symbol: 'AAPL',
),
```

### Using just to get the data
You can also use the package just to get the data:

```dart
import 'package:flutter_edgar_sec/flutter_edgar_sec.dart';
final CompanyResults results = await EdgarSecService.getFinancialStatementsForSymbol('AAPL');

```

## Like us on pub.dev
Package url:
https://pub.dev/packages/flutter_edgar_sec

# Contributing
If you want to contribute to this project, please fork it and submit a pull request:
https://github.com/ivofernandes/flutter_edgar_sec