import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/currecy_state.dart';
import '../cubit/currency_cubit.dart';
import '../data/models/form_status.dart';

class CurrencyScreen extends StatelessWidget {
  const CurrencyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Currency Rates'),
      ),
      body: BlocBuilder<CurrenciesCubit, CurrencyState>(
        builder: (context, state) {
          if (state.formsStatus == FormsStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.formsStatus == FormsStatus.success) {
            return ListView.builder(
              itemCount: state.currencies.length,
              itemBuilder: (context, index) {
                final currency = state.currencies[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    leading: Icon(Icons.monetization_on),
                    title: Text(currency.title),
                    subtitle: Text('CB Price: ${currency.cb_price}'),
                    trailing: Icon(Icons.chevron_right),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Text(
                'Error: ${state.statusText}',
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            );
          }
        },
      ),
    );
  }
}
