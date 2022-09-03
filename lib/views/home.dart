import 'package:appprojetointegrador/models/motorista.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'MyApp.dart';
import 'tips.dart';
import 'expenses.dart';
import 'user.dart';
import 'viagem.dart';

class Home extends StatefulWidget {
  Motorista motoristaLogado;
  Home(this.motoristaLogado, {Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int __selectedIndex = 0;

  void _onPressedTravel() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Viagem(widget.motoristaLogado)));
  }

  void _onItemPressed(int index) {
    setState(() {
      __selectedIndex = index;
      if (__selectedIndex == 1) {
        Navigator.push(
          context,
          PageTransition(
            curve: Curves.linear,
            child: Expenses(widget.motoristaLogado),
            type: PageTransitionType.rightToLeftWithFade,
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
        backgroundColor: Colors.teal,
        leading: const Icon(Icons.car_rental),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: Text(
                "Seja Bem-Vindo ${widget.motoristaLogado.nome}!!!\n",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            Text(
              "Sua receita é de R\$${widget.motoristaLogado.receita}",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 25,
                fontStyle: FontStyle.italic,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(60, 60, 60, 0),
              child: Image.asset(
                "lib/images/money.png",
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _onPressedTravel(),
        child: const Icon(Icons.mode_of_travel),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.teal,
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
          ),
        ],
        currentIndex: __selectedIndex,
        onTap: _onItemPressed,
      ),
    );
  }
}
