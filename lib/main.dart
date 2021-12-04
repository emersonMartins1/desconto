import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Desconto',
      home: MyHomePage('Desconto'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage(this.title, {Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final initValueController = TextEditingController();
  final discountController = TextEditingController();

  bool isPercentual = false;
  double result = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Divider(),
            Text(
              result.toString(),
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            const Divider(),
            buildTextField('Valor inicial', initValueController),
            const Divider(),
            buildTextField('Desconto', discountController),
            const Divider(),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  isPercentual = !isPercentual;
                });
              },
              child: Text(
                isPercentual ? 'Desconto Percentual' : 'Desconto Decimal',
                style: const TextStyle(fontSize: 20),
              ),
              style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(8)),
            ),
            const Divider(),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  result = calcularDesconto(
                    double.parse(initValueController.text),
                    double.parse(discountController.text),
                    isPercentual,
                  );
                });
              },
              child: const Text(
                'Calcular',
                style: TextStyle(fontSize: 20),
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildTextField(
    String label, TextEditingController textEditingController) {
  return TextField(
    controller: textEditingController,
    decoration: InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.blue),
      border: const OutlineInputBorder(),
    ),
    style: const TextStyle(
      color: Colors.blue,
      fontSize: 25,
    ),
    keyboardType: const TextInputType.numberWithOptions(decimal: true),
  );
}

double calcularDesconto(double initValue, double discount, bool isPercentual) {
  if (discount <= 0) {
    throw ArgumentError('O desconto deve ser maior que zero!');
  }

  if (initValue <= 0) {
    throw ArgumentError('O valor inicial deve ser maior que zero!');
  }

  if (isPercentual) return initValue - (initValue * discount / 100);

  return initValue - discount;
}
