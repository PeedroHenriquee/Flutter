import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

openBancoUsuario() async {
  var dataBasePath = await getDatabasesPath();
  String path = join(dataBasePath, 'banco.db');
  var bd =
      await openDatabase(path, version: 1, onCreate: (db, versaoRecente) async {
    String sql =
        "CREATE TABLE motoristas (id INTEGER PRIMARY KEY AUTOINCREMENT, nome VARCHAR, sobrenome VARCHAR, usuario VARCHAR, email VARCHAR, senha VARCHAR, receita DOUBLE, valuefinanciado DOUBLE, valuealugado DOUBLE, valuemanutencao DOUBLE, abastecimentos INTEGER)";
    await db.execute(sql);
  });
  return bd;
}
