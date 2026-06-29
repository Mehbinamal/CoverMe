import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._();

  static final DatabaseHelper instance = DatabaseHelper._();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();

    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();

    final path = join(
      dbPath,
      "coverme.db",
    );

    return openDatabase(
      path,
      version: 1,

      onConfigure: (db) async {
      await db.execute("PRAGMA foreign_keys = ON;");
      },

      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(
    Database db,
    int version,
  ) async {

    // Teacher

    await db.execute("""

CREATE TABLE teacher(

id INTEGER PRIMARY KEY AUTOINCREMENT,

name TEXT NOT NULL UNIQUE,

homeroom TEXT

)

""");


    // Timetable

    await db.execute("""
CREATE TABLE timetable(
    id INTEGER PRIMARY KEY AUTOINCREMENT,

    teacherId INTEGER NOT NULL,

    day INTEGER NOT NULL,

    period INTEGER NOT NULL,

    classroom TEXT,

    subject TEXT,

    FOREIGN KEY(teacherId) REFERENCES teacher(id),

    UNIQUE(teacherId, day, period)
);

""");

    // Leave

    await db.execute("""

CREATE TABLE leave_table(
    id INTEGER PRIMARY KEY AUTOINCREMENT,

    teacherId INTEGER NOT NULL,

    date TEXT NOT NULL,

    reason TEXT,

    FOREIGN KEY(teacherId) REFERENCES teacher(id),

    UNIQUE(teacherId, date)
);

""");

    // Task

    await db.execute("""
CREATE TABLE task(

    id INTEGER PRIMARY KEY AUTOINCREMENT,

    teacherId INTEGER NOT NULL,

    assignedTeacherId INTEGER,

    day INTEGER NOT NULL,

    date TEXT NOT NULL,

    period INTEGER NOT NULL,

    classroom TEXT NOT NULL,

    subject TEXT NOT NULL,

    status TEXT NOT NULL,

    FOREIGN KEY(teacherId) REFERENCES teacher(id),

    FOREIGN KEY(assignedTeacherId) REFERENCES teacher(id),

    UNIQUE(teacherId, day, period, date)

);

""");
  }
}