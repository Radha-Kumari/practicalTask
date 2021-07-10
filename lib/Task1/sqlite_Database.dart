import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class SQLiteDatabase{

  static final _databaseName="UserData.db";
  static final _databaseVersion=1;

  static final table1="User";
  static final table2="Company";
  static final table3="Address";

  //user table fields
  static final Id='id';
  static final Name='name';
  static final UserName='username';
  static final Email='email';
  static final Phone='phone';
  static final Website='website';
  static final IdCompany='idcompany';
  static final IdAddress='idaddress';

  //Company  table field
  static final CompanyId='companyid';
  static final CompanyName='companyname';
  static final CatchPhrase='catchphrase';
  static final BS='bs';

  //company  table field
  static final AddressId='addressid';
  static final Street='street';
  static final Suite='suite';
  static final City='city';
  static final Zipcode='zipcode';

  SQLiteDatabase._privateConstructor();
  static final SQLiteDatabase instance=SQLiteDatabase._privateConstructor();

  static Database _database;

  //get the database
  Future<Database> get database async{
    if(_database !=null) return _database;

    _database=await _initDatabase();
    return _database;
  }

  _initDatabase() async{

    Directory documentsDirectory=await getApplicationDocumentsDirectory();
    String path=join(documentsDirectory.path,_databaseName);

    return openDatabase(path,version: _databaseVersion,onCreate: _onCreate);

  }


  Future  _onCreate(Database db,int version) async{

    await db.execute('''
              CREATE TABLE $table1 (
                $Id INTEGER PRIMARY KEY,
                $Name TEXT NOT NULL,
                $UserName TEXT NOT NULL,
                $Email TEXT NOT NULL,
                $Phone TEXT NOT NULL,
                $Website TEXT NOT NULL,
                $IdAddress INTEGER NOT NULL,
                $IdCompany INTEGER NOT NULL
              )
               ''');

    await db.execute('''
              CREATE TABLE $table2 (
                $CompanyId INTEGER PRIMARY KEY,
                $CompanyName TEXT NOT NULL,
                $CatchPhrase TEXT NOT NULL,
                $BS TEXT NOT NULL
              )
               ''');

    await db.execute('''
              CREATE TABLE $table3 (
                $AddressId INTEGER PRIMARY KEY,
                $Street TEXT NOT NULL,
                $Suite TEXT NOT NULL,
                $Zipcode TEXT NOT NULL,
                $City TEXT NOT NULL
              )
               ''');
  }


  Future<int>  insertData(Map<String,dynamic> row)  async{
    Database db=await instance.database;
    return await db.insert(table1, row);
  }

  Future<int>  insertCompanyData(Map<String,dynamic> row)  async{
    Database db=await instance.database;
    return await db.insert(table2, row);
  }

  Future<int>  insertAddressData(Map<String,dynamic> row)  async{
    Database db=await instance.database;
    return await db.insert(table3, row);
  }

  Future<List<Map<String,dynamic>>>  fetchAllData() async{
    Database db=await instance.database;
    var result= await db.rawQuery('SELECT * FROM $table1');
    return result.toList();
  }

  Future<Map<String,dynamic>>  fetchCompanyData(int companyId) async{
    Database db=await instance.database;
    var result= await db.rawQuery('SELECT * FROM $table2 WHERE $CompanyId=$companyId');
    return result[0];
  }

  Future<Map<String,dynamic>>  fetchAddressData(int addressId) async{
    Database db=await instance.database;
    var result= await db.rawQuery('SELECT * FROM $table3 WHERE $AddressId=$addressId');
    return result[0];
  }

  Future<int> deleteUserData() async{
    Database db=await instance.database;
    return await db.delete(table1);
  }

  Future<int> deleteAddressData() async{
    Database db=await instance.database;
    return await db.delete(table3);
  }

  Future<int> deleteCompanyData() async{
    Database db=await instance.database;
    return await db.delete(table2);
  }

}