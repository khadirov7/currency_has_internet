import '../data/models/currency_model.dart';
import '../data/models/form_status.dart';

class CurrencyState {
  final FormsStatus formsStatus;
  final List<CurrencyModel> currencies;
  final String statusText;

  CurrencyState({
    required this.formsStatus,
    required this.statusText,
    required this.currencies,
  });

  CurrencyState copyWith({
    FormsStatus? formsStatus,
    List<CurrencyModel>? currencies,
    String? statusText,
  }) =>
      CurrencyState(
        formsStatus: formsStatus ?? this.formsStatus,
        currencies: currencies ?? this.currencies,
        statusText: statusText ?? this.statusText,
      );
}