import 'package:flutter/material.dart';
import 'package:flutter_edgar_sec/flutter_edgar_sec.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData.dark(),
        home: const MyHomePage(),
      );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _textEditingController = TextEditingController(text: 'AAPL');

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Edgar SEC'),
          actions: [
            IconButton(
              icon: const Icon(Icons.bar_chart),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute<Widget>(
                  builder: (BuildContext context) => ChartPage(
                    symbol: _textEditingController.text,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: Center(
          child: Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _textEditingController,
                  onSubmitted: (String value) {
                    setState(() {});
                  },
                ),
                MaterialButton(
                  color: Colors.green,
                  onPressed: () => setState(() {}),
                  child: const Text('Get Financial Statements'),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: EdgarTableUI(
                    symbol: _textEditingController.text,
                    key: UniqueKey(),
                  ),
                ),
              ],
            ),
          ),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      );
}

class ChartPage extends StatelessWidget {
  final String symbol;

  const ChartPage({
    required this.symbol,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(symbol),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              margin: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CompanyChartUI(
                    symbol: symbol,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
