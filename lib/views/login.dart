import 'package:appprojetointegrador/models/motorista.dart';
import 'package:appprojetointegrador/views/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sqflite/sqflite.dart';
import 'package:appprojetointegrador/Data/DAOUsuarios.dart';

import 'user.dart';

var idLogado;

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool hasRegisterUser = false;
  String error = "";

  final TextEditingController _textEditingControllerUsuario =
      TextEditingController();
  final TextEditingController _textEditingControllerSenha =
      TextEditingController();

  void _onPressedRegister() {
    Navigator.pushNamed(context, '/register');
  }

  void _onPressedEntrar() async {
    Database bd = await openBancoUsuario();
    var motoristas = await bd.query("motoristas", columns: ["usuario"]);
    for (int i = 0; i < motoristas.length.toInt(); i++) {
      if (_textEditingControllerUsuario.text.toString() ==
          motoristas[i]["usuario"]) {
        hasRegisterUser = true;
      }
    }
    if (hasRegisterUser) {
      var senha = await bd.query("motoristas",
          columns: ["senha"],
          where:
              "usuario = \"${_textEditingControllerUsuario.text.toString()}\"");
      if (_textEditingControllerSenha.text.toString() == senha[0]["senha"]) {
        var dadosMotoristaLogado = await bd.query("motoristas",
            where:
                "usuario = \"${_textEditingControllerUsuario.text.toString()}\"");
        Motorista motoristaLogado = Motorista(
          id: dadosMotoristaLogado[0]["id"],
          nome: dadosMotoristaLogado[0]["nome"].toString(),
          sobrenome: dadosMotoristaLogado[0]["sobrenome"].toString(),
          usuario: dadosMotoristaLogado[0]["usuario"].toString(),
          email: dadosMotoristaLogado[0]["email"].toString(),
          senha: dadosMotoristaLogado[0]["senha"].toString(),
          receita: dadosMotoristaLogado[0]["receita"].toString(),
          valorFinanciado:
              dadosMotoristaLogado[0]["valuefinanciado"].toString(),
          valorAlugado: dadosMotoristaLogado[0]["valuealugado"].toString(),
          valorManutencao:
              dadosMotoristaLogado[0]["valuemanutencao"].toString(),
          abastecimentos: dadosMotoristaLogado[0]["abastecimentos"].toString(),
        );
        print(motoristaLogado.abastecimentos);
        await Future.delayed(const Duration(seconds: 1));
        if (!mounted) return;
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Home(motoristaLogado)));
      } else {
        setState(() {
          error = "Credenciais Inválidas";
        });
      }
    } else {
      setState(() {
        error = "Credenciais Inválidas";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(
          'Uber Health',
        ),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft, colors: [Colors.white, Colors.white10]),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(
                height: 152,
                child: Image.asset("lib/images/car.png"),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(60, 5, 60, 5),
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 5.0),
                    ),
                    icon: Icon(Icons.person),
                    hintText: 'Usuário',
                  ),
                  controller: _textEditingControllerUsuario,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(60, 5, 60, 10),
                child: TextField(
                  obscureText: true,
                  obscuringCharacter: '*',
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 5.0,
                      ),
                    ),
                    icon: Icon(Icons.key),
                    hintText: 'Senha',
                  ),
                  controller: _textEditingControllerSenha,
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  onSurface: Colors.green,
                  elevation: 16,
                  shadowColor: Colors.red,
                ),
                child: const Text('ENTRAR'),
                onPressed: () => _onPressedEntrar(),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  onSurface: Colors.red,
                  elevation: 16,
                  shadowColor: Colors.red,
                ),
                child: const Text('NÃO TEM CONTA? REGISTRE-SE'),
                onPressed: () => _onPressedRegister(),
              ),
              Text(
                "$error",
                style: TextStyle(
                  color: Colors.red[700],
                  fontSize: 13.5,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
