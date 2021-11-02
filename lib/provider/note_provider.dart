import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class NoteProvider {
  static Database? db;

  static Future open() async {
    db = await openDatabase(
      join(await getDatabasesPath(), 'notes.db'),
      version: 3,
      onCreate: (Database db, int version) async {
        db.execute('''
          create table Notes(
            id integer primary key autoincrement,
            title text not null,
            content text not null,
            creationdate text not null,
            editingdate text not null,
            favorite integer not null,
            color text not null,
            alarmdate text not null,
            archived integer not null
          );
        ''');
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) async{
        if(oldVersion < newVersion){
          await db.execute("alter table Notes add column archived integer not null");
        }
      }
    );
  }

  static Future<List<Map<String, dynamic>>> getNoteList() async {
    await open();

    return await db!.query('Notes');
  }

  static Future insertNote(Map<String, dynamic> note) async {
    await db?.insert('Notes', note);
  }

  static Future updateNote(Map<String, dynamic> note) async {
    await db?.update(
      'Notes',
      note,
      where: 'id = ?',
      whereArgs: [note['id']]);
  }

  static Future deleteNote(int id) async {
    await db?.delete(
      'Notes',
      where: 'id = ?',
      whereArgs: [id]);
  }
}