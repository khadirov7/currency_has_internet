import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/currency_model.dart';

class CurrencyDatabase {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'currencies.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE currencies (id INTEGER PRIMARY KEY, title TEXT, code TEXT, cb_price TEXT, nbu_buy_price TEXT, nbu_cell_price TEXT, date TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<void> insertCurrency(CurrencyModel currency) async {
    final db = await database;
    await db.insert(
      'currencies',
      currency.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<CurrencyModel>> getAllCurrencies() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('currencies');
    return maps.map((e) => CurrencyModel.fromJson(e)).toList();
  }

  Future<void> updateCurrency(CurrencyModel currency) async {
    final db = await database;
    await db.update(
      'currencies',
      currency.toJson(),
      where: 'code = ?',
      whereArgs: [currency.code],
    );
  }
}
