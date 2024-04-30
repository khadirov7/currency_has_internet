import 'package:currency_state/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:currency_state/screens/currency_screen.dart';
import 'package:currency_state/cubit/internet_cubit.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'cubit/currency_cubit.dart';
import 'data/local/local_currency.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currencyDatabase = CurrencyDatabase();
    final connectivity = Connectivity();
    return MultiBlocProvider(
      providers: [
        BlocProvider<InternetCubit>(
          create: (context) => InternetCubit(connectivity),
        ),
        BlocProvider<CurrenciesCubit>(
          create: (context) => CurrenciesCubit(currencyDatabase,connectivity)
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
