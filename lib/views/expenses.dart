import 'package:appprojetointegrador/Data/DAOUsuarios.dart';
import 'package:appprojetointegrador/models/motorista.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sqflite/sqflite.dart';

import 'tips.dart';
import 'home.dart';
import 'user.dart';

class Expenses extends StatefulWidget {
  Motorista motoristaLogado;
  Expenses(this.motoristaLogado, {Key? key}) : super(key: key);

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  int __selectedIndex = 1;
  String error = "";
  String mensage = "";

  final TextEditingController _textEditingControllerValorAbastecido =
      TextEditingController();
  final TextEditingController _textEditingControllerLitrosAbastecido =
      TextEditingController();

  void _onPressedAdd() async {
    Database bd = await openBancoUsuario();
    bd.update(
        "motoristas",
        {
          "receita": double.parse(widget.motoristaLogado.receita.toString()) -
              double.parse(
                  _textEditingControllerValorAbastecido.text.toString()),
        },
        where: "id=${widget.motoristaLogado.id}");
    widget.motoristaLogado.receita =
        double.parse(widget.motoristaLogado.receita.toString()) -
            double.parse(_textEditingControllerValorAbastecido.text.toString());
    setState(() {
      mensage = "Deu tudo certo!";
    });
  }

  void _onItemPressed(int index) {
    setState(() {
      __selectedIndex = index;
      if (__selectedIndex == 0) {
        Navigator.push(
          context,
          PageTransition(
            curve: Curves.linear,
            child: Home(widget.motoristaLogado),
            type: PageTransitionType.leftToRightWithFade,
            duration: const Duration(milliseconds: 400),
          ),
        );
      }
      if (__selectedIndex == 2) {
        Navigator.push(
          context,
          PageTransition(
            curve: Curves.linear,
            child: Tips(widget.motoristaLogado),
            type: PageTransitionType.rightToLeftWithFade,
            duration: const Duration(milliseconds: 400),
          ),
        );
      }
      if (__selectedIndex == 3) {
        Navigator.push(
          context,
          PageTransition(
            curve: Curves.linear,
            child: User(widget.motoristaLogado),
            type: PageTransitionType.rightToLeftWithFade,
            duration: const Duration(milliseconds: 400),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Uber Health"),
        leading: const Icon(Icons.car_rental),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20),
              child: Image.asset(
                "lib/images/fuel.png",
                scale: 3,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
              child: TextField(
                controller: _textEditingControllerValorAbastecido,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: "Valor Abastecido",
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
                controller: _textEditingControllerLitrosAbastecido,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: "Quantidade de litros Abastecido",
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
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            label: 'Expenses',
            backgroundColor: Colors.teal,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lightbulb),
            label: 'Tips',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'User',
          ),
        ],
        currentIndex: __selectedIndex,
        onTap: _onItemPressed,
      ),
    );
  }
}
