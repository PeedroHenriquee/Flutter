import 'package:appprojetointegrador/models/motorista.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sqflite/sqflite.dart';

import '../Data/DAOUsuarios.dart';

class Viagem extends StatefulWidget {
  Motorista motoristaLogado;
  Viagem(this.motoristaLogado, {Key? key}) : super(key: key);

  @override
  State<Viagem> createState() => _ViagemState();
}

class _ViagemState extends State<Viagem> {
  String mensage = "";

  final TextEditingController _textEditingControllerKm =
      TextEditingController();
  final TextEditingController _textEditingControllerValor =
      TextEditingController();

  void _onPressedAdd() async {
    Database bd = await openBancoUsuario();
    bd.update(
        "motoristas",
        {
          "receita": double.parse(widget.motoristaLogado.receita.toString()) +
              double.parse(_textEditingControllerValor.text.toString()),
        },
        where: "id=${widget.motoristaLogado.id}");
    widget.motoristaLogado.receita =
        double.parse(widget.motoristaLogado.receita.toString()) +
            double.parse(_textEditingControllerValor.text.toString());
    setState(() {
      mensage = "Deu tudo certo!";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Uber Health"),
        backgroundColor: Colors.teal,
        leading: const Icon(Icons.car_rental),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Image.asset(
                "lib/images/viagem.png",
                scale: 3,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
              child: TextField(
                controller: _textEditingControllerKm,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: "Quilometragem",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 5.0,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: TextField(
                controller: _textEditingControllerValor,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: "Valor da viagem",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 5.0,
                    ),
                  ),
                ),
              ),
            ),
            Text(
              "$mensage",
              style: TextStyle(
                color: Colors.greenAccent[700],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _onPressedAdd(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
