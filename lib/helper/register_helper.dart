import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

//nomes das colunas
//final pq os nomes serão fixos
final String registerTable = 'registerTable';
final String idColumn = 'idColumn';
final String nameColumn = 'nameColumn';
final String dataColumn = 'dataColumn';
final String atendColumn = 'atendColumn';
final String hourColumn = 'hourColumn';
final String valueColumn = 'valueColumn';
final String doneColumn = 'doneColumn';

class RegisterHelper {
  //declando a classe
  static final RegisterHelper _instance = RegisterHelper.internal();

  factory RegisterHelper() => _instance;

  RegisterHelper.internal();

  Database _db;

  //inciando o banco de dados, e verificando a existencia de um banco de dados
  Future<Database> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await initDb();
      return _db;
    }
  }

  //função que inicializa o banco de dados
  Future<Database> initDb() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'registernew.db');

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int newerVersion) async {
      await db.execute(
          'CREATE TABLE $registerTable($idColumn INTEGER PRIMARY KEY, $nameColumn TEXT, $dataColumn TEXT,'
          '$atendColumn TEXT, $hourColumn TEXT, $valueColumn TEXT, $doneColumn TEXT)');
    });
  }

  // quando quiser salvar eu preciso passar o agendamento que eu quero salvar
  Future<Register> saveRegister(Register register) async {
    Database dbRegister = await db;
    register.id = await dbRegister.insert(registerTable, register.toMap());
    return register;
  }

//procurando o id que eu passei para acessar o cadastro que eu quero
  Future<Register> getRegister(int id) async {
    Database dbRegister = await db;
    List<Map> maps = await dbRegister.query(registerTable,
        columns: [
          idColumn,
          nameColumn,
          dataColumn,
          atendColumn,
          hourColumn,
          valueColumn,
          doneColumn
        ],
        where: '$idColumn = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return Register.fromMap(maps.first);
    } else {
      return null;
    }
  }

  //Deletando um agendamento
  Future<int> deleteRegister(int id) async {
    Database dbRegister = await db;
    return await dbRegister
        .delete(registerTable, where: '$idColumn = ?', whereArgs: [id]);
  }

  Future<int> updateRegister(Register register) async {
    Database dbRegister = await db;
    return await dbRegister.update(registerTable, register.toMap(),
        where: '$idColumn = ?', whereArgs: [register.id]);
  }

//selecionando todos os itens da tabelas  do meu db
  Future<List> getAllRegisters() async {
    Database dbRegister = await db;
    List listMap = await dbRegister.rawQuery('SELECT * FROM $registerTable');
    List<Register> listRegister = List();
    for (Map m in listMap) {
      listRegister.add(Register.fromMap(m));
    }
    return listRegister;
  }

  Future<int> getNumber() async {
    Database dbRegister = await db;
    return Sqflite.firstIntValue(
        await dbRegister.rawQuery('SELECT CONT(*) FROM $registerTable'));
  }

  Future close() async {
    Database dbRegister = await db;
    dbRegister.close();
  }
}

class Register {
//classe "Agendamento, nela ficará estruturado tudo que
// terá armazenado no nosso agendamento"

  int id;
  String name;
  String hour;
  String atend;
  String date;
  String done;
  String value;

  Register();

  Register.fromMap(Map map) {
    //construtor chamando from map pois os   dado são
    //armazenados em formatos de mapas
    // e os arquivo serão retornados por mapa

    id = map[idColumn];
    name = map[nameColumn];
    date = map[dataColumn];
    atend = map[atendColumn];
    hour = map[hourColumn];
    value = map[valueColumn];
    done = map[doneColumn];

    //aqui no caso estamos pegando de uma mapa e
    // passando pra um contato
  }

  //aqui tranformamos o contato em mapa
  Map toMap() {
    Map<String, dynamic> map = {
      nameColumn: name,
      dataColumn: date,
      atendColumn: atend,
      hourColumn: hour,
      valueColumn: value,
      doneColumn: done,
    };

    //só armazenando se o id for nulo
    if (id != null) {
      map[idColumn] = id;
    }
    return map;
  }

  //para leitura dos dados no banco de dados
  @override
  String toString() {
    return "Register(id: $id, name: $name, atend: $atend,  data: $date,hora: $hour, valor: $value, isDone: $done)";
  }
}
