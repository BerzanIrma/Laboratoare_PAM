import 'package:flutter/material.dart';

void main() {
  runApp(const DiscountCalculatorApp());
}

class DiscountCalculatorApp extends StatelessWidget {
  const DiscountCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator reducere',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const DiscountCalculatorPage(),
    );
  }
}

class DiscountCalculatorPage extends StatefulWidget {
  const DiscountCalculatorPage({super.key});

  @override
  State<DiscountCalculatorPage> createState() =>
      _DiscountCalculatorPageState();
}

class _DiscountCalculatorPageState
    extends State<DiscountCalculatorPage> {
  final TextEditingController priceController =
  TextEditingController();

  final TextEditingController discountController =
  TextEditingController();

  double discountValue = 0;
  double finalPrice = 0;

  void calculateDiscount() {
    double price = double.tryParse(priceController.text) ?? 0;
    double discount =
        double.tryParse(discountController.text) ?? 0;

    setState(() {
      discountValue = price * discount / 100;
      finalPrice = price - discountValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator reducere'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Preț inițial',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: discountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Procent reducere (%)',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: calculateDiscount,
              child: const Text('CALCULEAZĂ'),
            ),

            const SizedBox(height: 30),

            Text(
              'Valoarea reducerii: ${discountValue.toStringAsFixed(2)} lei',
              style: const TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 10),

            Text(
              'Preț final: ${finalPrice.toStringAsFixed(2)} lei',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    priceController.dispose();
    discountController.dispose();
    super.dispose();
  }
}