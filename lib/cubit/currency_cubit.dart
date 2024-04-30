import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/api_provider.dart';
import '../data/local/local_currency.dart';
import '../data/models/currency_model.dart';
import '../data/models/form_status.dart';
import 'currecy_state.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class CurrenciesCubit extends Cubit<CurrencyState> {
  final CurrencyDatabase _currencyDatabase;
  final Connectivity _connectivity;

  CurrenciesCubit(this._currencyDatabase, this._connectivity)
      : super(
    CurrencyState(
      formsStatus: FormsStatus.pure,
      currencies: [],
      statusText: '',
    ),
  ) {
    fetchCurrencies();
  }

  Future<void> fetchCurrencies() async {
    final connectivityResult = await _connectivity.checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      final localCurrencies = await _currencyDatabase.getAllCurrencies();
      emit(state.copyWith(currencies: localCurrencies, formsStatus: FormsStatus.success));
    } else {
      final response = await ApiProvider.getCurrencies();
      if (response.errorText.isEmpty) {
        final currencies = response.data as List<CurrencyModel>;

        for (var currency in currencies) {
          await _currencyDatabase.insertCurrency(currency);
        }

        emit(
          state.copyWith(currencies: currencies, formsStatus: FormsStatus.success),
        );
      } else {
        emit(
          state.copyWith(
            formsStatus: FormsStatus.error,
            statusText: response.errorText,
          ),
        );
      }
    }
  }
}
