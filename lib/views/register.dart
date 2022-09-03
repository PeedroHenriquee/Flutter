import 'package:appprojetointegrador/Data/DAOUsuarios.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool hasRegisterUser = false;
  bool hasRegisterEmail = false;
  bool valueInitFinanciado = false;
  bool valueInitAlugado = false;
  bool valueInitManutencao = false;
  String error = "";

  final TextEditingController _textEditingControllerNome =
      TextEditingController();
  final TextEditingController _textEditingControllerSobrenome =
      TextEditingController();
  final TextEditingController _textEditingControllerUsuario =
      TextEditingController();
  final TextEditingController _textEditingControllerEmail =
      TextEditingController();
  final TextEditingController _textEditingControllerSenha =
      TextEditingController();
  final TextEditingController _textEditingControllerConfirmeSenha =
      TextEditingController();
  final TextEditingController _textEditingControllerValueFinanciamento =
      TextEditingController();
  final TextEditingController _textEditingControllerValueAlugado =
      TextEditingController();
  final TextEditingController _textEditingControllerValueManutencao =
      TextEditingController();

  void _onPressedCheckBoxFinanciado() {
    setState(() {
      valueInitFinanciado = !valueInitFinanciado;
    });
  }

  void _onPressedCheckBoxAlugado() {
    setState(() {
      valueInitAlugado = !valueInitAlugado;
    });
  }

  void _onPressedCheckBoxManutencao() {
    setState(() {
      valueInitManutencao = !valueInitManutencao;
    });
  }

  void _onPressedRegister() async {
    Database bd = await openBancoUsuario();
    var motoristas =
        await bd.query("motoristas", columns: ["usuario", "email"]);
    for (int i = 0; i < motoristas.length.toInt(); i++) {
      if (_textEditingControllerUsuario.text.toString() ==
          motoristas[i]["usuario"]) {
        hasRegisterUser = true;
      }
      if (_textEditingControllerEmail.text.toString() ==
          motoristas[i]["email"]) {
        hasRegisterEmail = true;
      }
    }
    if (_textEditingControllerNome.text.toString() == "" ||
        _textEditingControllerSobrenome.text.toString() == "" ||
        _textEditingControllerUsuario.text.toString() == "" ||
        _textEditingControllerEmail.text.toString() == "" ||
        _textEditingControllerSenha.text.toString() == "" ||
        _textEditingControllerConfirmeSenha.text.toString() == "" ||
        (valueInitFinanciado &&
            _textEditingControllerValueFinanciamento.text.toString() == "") ||
        (valueInitAlugado &&
            _textEditingControllerValueAlugado.text.toString() == "") ||
        (valueInitManutencao &&
            _textEditingControllerValueManutencao.text.toString() == "") ||
        (!valueInitFinanciado &&
            _textEditingControllerValueFinanciamento.text.toString() != "") ||
        (!valueInitAlugado &&
            _textEditingControllerValueAlugado.text.toString() != "") ||
        (!valueInitManutencao &&
            _textEditingControllerValueFinanciamento.text.toString() != "") ||
        (!valueInitFinanciado && !valueInitAlugado && !valueInitManutencao) ||
        (_textEditingControllerValueFinanciamento.text.toString() == "" &&
            _textEditingControllerValueAlugado.text.toString() == "" &&
            _textEditingControllerValueManutencao.text.toString() == "")) {
      setState(() {
        error = "Algum campo não está preenchido";
      });
      return;
    }
    if (hasRegisterEmail && hasRegisterUser) {
      setState(() {
        error = "Usuário já cadastrado e Email já vinculado";
      });
      return;
    }
    if (hasRegisterEmail) {
      setState(() {
        error = "Email já vinculado";
      });
      return;
    }
    if (hasRegisterUser) {
      setState(() {
        error = "Usuario já cadastrado";
      });
      return;
    }
    if (_textEditingControllerSenha.text.toString() ==
        _textEditingControllerConfirmeSenha.text.toString()) {
      Map<String, Object?> cadastro = {
        "nome": "",
        "sobrenome": "",
        "usuario": "",
        "email": "",
        "senha": "",
        "receita": 0,
        "financiado": 0,
        "valuefinanciado": 0,
        "alugado": 0,
        "valuealugado": 0,
        "manutencao": 0,
        "valuemanutencao": 0,
        "abastecimentos": 0,
      };
      if (_textEditingControllerValueFinanciamento.text.toString() == "" &&
          _textEditingControllerValueAlugado.text.toString() == "") {
        cadastro = {
          "nome": _textEditingControllerNome.text.toString(),
          "sobrenome": _textEditingControllerSobrenome.text.toString(),
          "usuario": _textEditingControllerUsuario.text.toString(),
          "email": _textEditingControllerEmail.text.toString(),
          "senha": _textEditingControllerSenha.text.toString(),
          "receita": 0,
          "valuefinanciado": 0,
          "valuealugado": 0,
          "valuemanutencao": double.parse(
              _textEditingControllerValueManutencao.text.toString()),
          "abastecimentos": 1 - 1,
        };
      }
      if (_textEditingControllerValueFinanciamento.text.toString() == "" &&
          _textEditingControllerValueManutencao.text.toString() == "") {
        cadastro = {
          "nome": _textEditingControllerNome.text.toString(),
          "sobrenome": _textEditingControllerSobrenome.text.toString(),
          "usuario": _textEditingControllerUsuario.text.toString(),
          "email": _textEditingControllerEmail.text.toString(),
          "senha": _textEditingControllerSenha.text.toString(),
          "receita": 0,
          "valuefinanciado": 0,
          "valuealugado":
              double.parse(_textEditingControllerValueAlugado.text.toString()),
          "valuemanutencao": 0,
          "abastecimentos": 1 - 1,
        };
      }
      if (_textEditingControllerValueAlugado.text.toString() == "" &&
          _textEditingControllerValueManutencao.text.toString() == "") {
        cadastro = {
          "nome": _textEditingControllerNome.text.toString(),
          "sobrenome": _textEditingControllerSobrenome.text.toString(),
          "usuario": _textEditingControllerUsuario.text.toString(),
          "email": _textEditingControllerEmail.text.toString(),
          "senha": _textEditingControllerSenha.text.toString(),
          "receita": 0,
          "valuefinanciado": double.parse(
              _textEditingControllerValueFinanciamento.text.toString()),
          "valuealugado": 0,
          "valuemanutencao": 0,
          "abastecimentos": 1 - 1,
        };
      }
      bd.insert("motoristas", cadastro);
      await Future.delayed(const Duration(seconds: 1));
      if (!mounted) return;
      Navigator.pushNamed(context, "/");
    } else {
      setState(() {
        error = "Confirmação de senha incorreta";
      });
    }
  }

  void _onPressedCancel() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        centerTitle: true,
        title: const Text(
          'Uber Health',
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "lib/images/car.png",
                scale: 2,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(80, 5, 80, 5),
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nome',
                  ),
                  controller: _textEditingControllerNome,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(80, 5, 80, 5),
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Sobrenome',
                  ),
                  controller: _textEditingControllerSobrenome,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(80, 5, 80, 5),
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Usuário',
                  ),
                  controller: _textEditingControllerUsuario,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(80, 5, 80, 5),
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                  controller: _textEditingControllerEmail,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(80, 5, 80, 5),
                child: TextField(
                  obscureText: true,
                  obscuringCharacter: "*",
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Senha',
                  ),
                  controller: _textEditingControllerSenha,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(80, 5, 80, 5),
                child: TextField(
                  obscureText: true,
                  obscuringCharacter: "*",
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Confirme sua senha'),
                  controller: _textEditingControllerConfirmeSenha,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(80, 5, 80, 5),
                child: CheckboxListTile(
                  title: const Text("Seu carro é financiado?"),
                  value: valueInitFinanciado,
                  onChanged: (valueInitFinanciado) =>
                      _onPressedCheckBoxFinanciado(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(80, 5, 80, 5),
                child: TextField(
                  controller: _textEditingControllerValueFinanciamento,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 5.0,
                        ),
                      ),
                      hintText: "Valor mensal do financiamento"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(80, 5, 80, 5),
                child: CheckboxListTile(
                  title: const Text("Seu carro é alugado?"),
                  value: valueInitAlugado,
                  onChanged: (valueInitAlugado) => _onPressedCheckBoxAlugado(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(80, 5, 80, 5),
                child: TextField(
                  controller: _textEditingControllerValueAlugado,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 5.0,
                        ),
                      ),
                      hintText: "Valor mensal do aluguel"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(80, 5, 80, 5),
                child: CheckboxListTile(
                  title: const Text("Seu carro já está quitado?"),
                  value: valueInitManutencao,
                  onChanged: (valueInitAlugado) =>
                      _onPressedCheckBoxManutencao(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(80, 5, 80, 5),
                child: TextField(
                  controller: _textEditingControllerValueManutencao,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 5.0,
                      ),
                    ),
                    hintText: "Valor médio mensal da Manutenção",
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                      top: 15,
                      right: 15,
                      bottom: 15,
                    ),
                    width: 150,
                    height: 70,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.teal,
                      ),
                      child: const Text(
                        'Registrar',
                      ),
                      onPressed: () => _onPressedRegister(),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      top: 15,
                      left: 15,
                      bottom: 15,
                    ),
                    width: 150,
                    height: 70,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.teal,
                      ),
                      onPressed: () => _onPressedCancel(),
                      child: const Text(
                        'Cancelar',
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                "$error",
                style: TextStyle(
                  color: Colors.red[700],
                  fontSize: 13.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
