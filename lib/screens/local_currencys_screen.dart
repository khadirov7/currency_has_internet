import 'package:flutter/material.dart';
import 'package:currency_state/data/models/currency_model.dart';
import '../data/local/local_currency.dart';

class LocalCurrencyScreen extends StatelessWidget {
  const LocalCurrencyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currencyDatabase = CurrencyDatabase();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Local"),
      ),
      body: FutureBuilder<List<CurrencyModel>>(
        future: currencyDatabase.getAllCurrencies(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            final currencies = snapshot.data!;
            return ListView.builder(
              itemCount: currencies.length,
              itemBuilder: (context, index) {
                final currency = currencies[index];
                return Card(
                  child: ListTile(
                    title: Text(currency.title),
                    subtitle: Text('CB Price: ${currency.cb_price}'),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: Text("Lokal ma'lumotlar mavjud emas."),
            );
          }
        },
      ),
    );
  }
}
