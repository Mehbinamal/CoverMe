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

name TEXT,

classroom_id TEXT,

isHM INTEGER

)

""");

    // Classroom

    await db.execute("""

CREATE TABLE classroom(

id INTEGER PRIMARY KEY AUTOINCREMENT,

name TEXT

)

""");

    // Subject

    await db.execute("""

CREATE TABLE subject(

id INTEGER PRIMARY KEY AUTOINCREMENT,

name TEXT

)

""");

    // Timetable

    await db.execute("""

CREATE TABLE timetable(

id INTEGER PRIMARY KEY AUTOINCREMENT,

teacherId INTEGER,

classroomId INTEGER,

subjectId INTEGER,

day INTEGER,

period INTEGER

)

""");

    // Leave

    await db.execute("""

CREATE TABLE leave_table(

id INTEGER PRIMARY KEY AUTOINCREMENT,

teacherId INTEGER,

date TEXT,

reason TEXT

)

""");

    // Task

    await db.execute("""

CREATE TABLE task(

id INTEGER PRIMARY KEY AUTOINCREMENT,

teacherId INTEGER,

assignedTeacherId INTEGER,

classroomId INTEGER,

subjectId INTEGER,

day INTEGER,

period INTEGER,

status TEXT

)

""");
  }
}