import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../moduls/api_models.dart';

class DBHelpers {
  DBHelpers._();

  static final DBHelpers dbHelpers = DBHelpers._();

  String databaseName = "quote.db";
  String tableName = "quotes";
  String colQuoteContent = "quoteContent";

  Database? db;

  Future<void> initDatabase() async {
    String dataBasePath = await getDatabasesPath();
    String path = join(dataBasePath, "quote.db");
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int vision) async {
        await db.execute(
            "CREATE TABLE IF NOT EXISTS $tableName($colQuoteContent TEXT);");
      },
    );
  }

  insertData
      ({required Quote data}) async{
    await initDatabase();

    String query =
        "INSERT INTO $tableName($colQuoteContent) VALUES(?);";
    List args = [data.quoteContent];

    await db!.rawInsert(query, args);
  }

  Future<List<Map<String, dynamic>?>> fetchAllData() async {
    await initDatabase();

    String query = "SELECT * FROM $tableName";

    List<Map<String, dynamic>> res = await db!.rawQuery(query);


    return res;
  }
}