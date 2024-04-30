class CurrencyModel {
  final String title;
  final String code;
  final String cb_price;
  final String nbu_buy_price;
  final String nbu_cell_price;
  final String date;

  CurrencyModel({
    required this.title,
    required this.code,
    required this.cb_price,
    required this.nbu_buy_price,
    required this.nbu_cell_price,
    required this.date,
  });

  factory CurrencyModel.fromJson(Map<String, dynamic> json) {
    return CurrencyModel(
      title: json['title'],
      code: json['code'],
      cb_price: json['cb_price'],
      nbu_buy_price: json['nbu_buy_price'] ?? '',
      nbu_cell_price: json['nbu_cell_price'] ?? '',
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'code': code,
      'cb_price': cb_price,
      'nbu_buy_price': nbu_buy_price,
      'nbu_cell_price': nbu_cell_price,
      'date': date,
    };
  }
}
