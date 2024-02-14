import 'package:ali_cagatay_yilmaz/models/favorite_book.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static final DatabaseService _databaseService = DatabaseService._internal();
  factory DatabaseService() => _databaseService;
  DatabaseService._internal();
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    final getDirectory = await getApplicationDocumentsDirectory();
    String path = '${getDirectory.path}/favoriteBooks.db';
    return await openDatabase(path, onCreate: _onCreate, version: 1);
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE FavoriteBooks(id TEXT PRIMARY KEY, image TEXT, title TEXT, subTitle TEXT, authors TEXT, publisher TEXT, pageCount INTEGER, publishedDate TEXT)');
  }

  Future<List<FavoriteBook>> getFavoriteBooks() async {
    final db = await _databaseService.database;
    var data = await db.rawQuery('SELECT * FROM FavoriteBooks');
    List<FavoriteBook> favoriteBooks = List.generate(
        data.length, (index) => FavoriteBook.fromJson(data[index]));
    return favoriteBooks;
  }

  Future<void> insertFavoriteBook(FavoriteBook favoriteBook) async {
    final db = await _databaseService.database;
    await db.rawInsert(
        'INSERT INTO FavoriteBooks(id, image, title, subTitle, authors, publisher, pageCount, publishedDate ) VALUES(?,?,?,?,?,?,?,?)',
        [
          favoriteBook.id,
          favoriteBook.image,
          favoriteBook.title,
          favoriteBook.subTitle,
          favoriteBook.authors,
          favoriteBook.publisher,
          favoriteBook.pageCount,
          favoriteBook.publishedDate,
        ]);
  }

  Future<void> editFavoriteBook(FavoriteBook favoriteBook) async {
    final db = await _databaseService.database;
    await db.rawUpdate(
        'UPDATE FavoriteBooks SET image=?, title=?, title=?, subTitle=?, authors=?, publisher=?, pageCount=?, publishDate=? WHERE ID=?',
        [
          favoriteBook.image,
          favoriteBook.title,
          favoriteBook.subTitle,
          favoriteBook.authors,
          favoriteBook.publisher,
          favoriteBook.pageCount,
          favoriteBook.publishedDate,
          favoriteBook.id,
        ]);
  }

  Future<void> deleteFavoriteBook(String id) async {
    final db = await _databaseService.database;
    await db.rawDelete('DELETE from FavoriteBooks WHERE id=?', [id]);
  }
}
