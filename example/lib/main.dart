import 'package:flutter/material.dart';
import 'package:flutter_edgar_sec/flutter_edgar_sec.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final TextEditingController _textEditingController = TextEditingController(
    text: 'AAPL'
  );
  bool _isLoading = false;
  List<FinancialStatement> _financialStatements = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edgar SEC'),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _textEditingController,
              ),
              MaterialButton(
                color: Colors.green,
                  onPressed: _getFinancialStatements,
                child: const Text('Get Financial Statements'),
              ),
              const SizedBox(height: 20,),
              if(_isLoading)
                const CircularProgressIndicator(),

              Expanded(
                child: ListView.builder(
                    itemCount: _financialStatements.length,
                    itemBuilder: (context, index){
                      return Container(
                          margin: EdgeInsets.all(10),
                          child: Text(_financialStatements[index].toString()),
                      );
                },
                ),
              )
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<void> _getFinancialStatements() async{
    _isLoading = true;
    _financialStatements.clear();
    setState(() {});

    _financialStatements = await EdgarSecService.getFinancialStatementsForSymbol(_textEditingController.text);

    _isLoading = false;
    setState(() {});
  }
}
