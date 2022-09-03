import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../models/motorista.dart';
import 'tips.dart';
import 'expenses.dart';
import 'home.dart';

class User extends StatefulWidget {
  Motorista motoristaLogado;
  User(this.motoristaLogado, {Key? key}) : super(key: key);

  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> {
  int __selectedIndex = 3;

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
      if (__selectedIndex == 1) {
        Navigator.push(
          context,
          PageTransition(
            curve: Curves.linear,
            child: Expenses(widget.motoristaLogado),
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
            type: PageTransitionType.leftToRightWithFade,
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(5),
              child: Image.asset(
                "lib/images/user.png",
                scale: 0.8,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                "Nome Completo: ${widget.motoristaLogado.nome} ${widget.motoristaLogado.sobrenome}",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                "Usuário: ${widget.motoristaLogado.usuario}",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                "Email: ${widget.motoristaLogado.email}",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25,
                ),
              ),
            ),
          ],
        ),
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
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lightbulb),
            label: 'Tips',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'User',
            backgroundColor: Colors.teal,
          ),
        ],
        currentIndex: __selectedIndex,
        onTap: _onItemPressed,
      ),
    );
  }
}
