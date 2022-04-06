import 'package:final_submission/data/models/restaurant_list_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  static Database? _database;

  DatabaseHelper._internal() {
    _instance = this;
  }

  factory DatabaseHelper() => _instance ?? DatabaseHelper._internal();

  static const String _tableFavoriteRestaurant = 'favorite_restaurant';

  Future<Database> _intializedDb() async {
    var path = await getDatabasesPath();
    var db =
        openDatabase('$path/restaurant_db.db', onCreate: ((db, version) async {
      await db.execute('''CREATE TABLE $_tableFavoriteRestaurant (
          id TEXT PRIMARY KEY,
          name TEXT,
          description TEXT,
          pictureId TEXT,
          city TEXT,
          rating REAL
          )     
        ''');
    }), version: 1);

    return db;
  }

  Future<Database?> get database async {
    _database ??= await _intializedDb();
    return _database;
  }

  Future<void> insertRestaurant(Restaurant restaurant) async {
    final db = await database;
    await db!.insert(_tableFavoriteRestaurant, restaurant.toJson());
  }

  Future<void> insertFavorite(Restaurant restaurant) async {
    final db = await database;
    await db!.insert(_tableFavoriteRestaurant, restaurant.toJson());
  }

  Future<List<Restaurant>> getFavorites() async {
    final db = await database;
    List<Map<String, dynamic>> results =
        await db!.query(_tableFavoriteRestaurant);
    return results.map((res) => Restaurant.fromJson(res)).toList();
  }

  Future<Map> getFavoriteById(String id) async {
    final db = await database;
    List<Map<String, dynamic>> results = await db!.query(
      _tableFavoriteRestaurant,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return {};
    }
  }

  Future<void> removeFavorite(String id) async {
    final db = await database;

    await db!.delete(
      _tableFavoriteRestaurant,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
