import 'package:appprojetointegrador/models/motorista.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:url_launcher/url_launcher.dart';

import 'home.dart';
import 'expenses.dart';
import 'user.dart';

class Tips extends StatefulWidget {
  Motorista motoristaLogado;
  Tips(this.motoristaLogado, {Key? key}) : super(key: key);

  @override
  State<Tips> createState() => _TipsState();
}

class _TipsState extends State<Tips> {
  int __selectedIndex = 2;
  final Uri _urlReviewCar = Uri.parse(
      'https://www.portalautoshopping.com.br/blog/voce-sabe-importancia-de-fazer-revisao-do-carro/');
  final Uri _urlCalibrateTires = Uri.parse(
      'https://blog.sempararempresas.com.br/calibragem-de-pneus-veja-de-quanto-em-quanto-tempo-ela-deve-ser-feita/');
  final Uri _urlSuspension =
      Uri.parse('https://seminovos.unidas.com.br/blog/suspensao-de-carro/');
  final Uri _urlFastRoutes = Uri.parse(
      'https://blog.racon.com.br/rota-de-carro-para-o-trabalho-como-otimizar-a-minha/');

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
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: const Icon(
              Icons.search,
              color: Colors.black,
            ),
            title: const Text("Car Review"),
            onTap: () async {
              if (!await launchUrl(_urlReviewCar)) {
                throw "Could not launch $_urlReviewCar";
              }
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.tire_repair_sharp,
              color: Colors.black,
            ),
            title: const Text("Calibrate Tires"),
            onTap: () async {
              if (!await launchUrl(_urlCalibrateTires)) {
                throw "Could not launch $_urlCalibrateTires";
              }
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.car_repair,
              color: Colors.black,
            ),
            title: const Text("Suspension"),
            onTap: () async {
              if (!await launchUrl(_urlSuspension)) {
                throw "Could not launch $_urlSuspension";
              }
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.map_sharp,
              color: Colors.black,
            ),
            title: const Text("Fast Routes"),
            onTap: () async {
              if (!await launchUrl(_urlFastRoutes)) {
                throw "Could not launch $_urlFastRoutes";
              }
            },
          ),
        ],
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
            backgroundColor: Colors.teal,
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
