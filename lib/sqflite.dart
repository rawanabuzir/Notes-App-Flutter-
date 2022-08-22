import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class sqflite{
static  Database? _dbR;
Future<Database?> get dbR async{
  if (_dbR ==null){
    _dbR =await enshaadb();
    return _dbR;
  } else{ return _dbR;}
}
enshaadb () async{
  String dbmasar= await getDatabasesPath();
  String path = join(dbmasar,'firstOne.db');
  Database mydb =await openDatabase(path,onCreate:_onCreate , version: 18,onUpgrade:_onUpgrade);
  return mydb;
}
_onUpgrade (Database dbR, int oldversion ,int newversion) async{

  print("_onUpgrade Done ");
  //await dbR.execute("ALTER TABLE RAWAN ADD COLUMN color TEXT");

}
_onCreate (Database dbR ,int version)async{
  //to add new tables: (batch)
  //when we add it for the first time
  await dbR.execute('''
  CREATE TABLE "RAWAN" (
 "id" INTEGER  NOT NULL PRIMARY KEY AUTOINCREMENT,
  "title" TEXT NOT NULL,
  "notes" TEXT NOT NULL,
  "color" TEXT NOT NULL
 )
 ''');
//   print("Create Done without any problems");


}
ReadData (String sql) async {
  Database? mydb = await dbR;
  List<Map> collect = await mydb!.rawQuery(sql);
  return collect;
}
insertData (String sql) async {
  Database? mydb = await dbR;
  int collect = await mydb!.rawInsert(sql);
  return collect;
}
UpdateData (String sql) async {
  Database? mydb = await dbR;
  int collect = await mydb!.rawUpdate(sql);
  return collect;
}
DeleteData (String sql) async {
  Database? mydb = await dbR;
 int collect = await mydb!.rawDelete(sql);
  return collect;
}

mydeletedatabase() async{
  String dbmasar= await getDatabasesPath();
  String path = join(dbmasar,'firstOne.db');
  await deleteDatabase(path);

}
}