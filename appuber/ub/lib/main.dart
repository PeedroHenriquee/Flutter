import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   
    return MaterialApp(
      title: 'Controle Eficiente',
       debugShowCheckedModeBanner: false,
       home: Home()
      );
    }
  }

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _textEditingControllerNome =
      TextEditingController();
  final TextEditingController _textEditingControllersenha =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: Text(
            'Controle de Gastos Eficiente',
          ),
        ),
        body: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft, colors: [Colors.white, Colors.white10]
              ),
            ),
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
            SizedBox(
              height: 152,
              child: Image.network(
                'https://th.bing.com/th/id/R.5d8192ee35b80d64ab386059f5bdd71f?rik=ofPD7QTeE%2flW6Q&pid=ImgRaw&r=0',
                
                
              ),
            ),
            TextField(
              maxLength: 11,
              autofocus: true,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderSide:
                 BorderSide(color: Colors.black,width: 5.0),),
                 icon: Icon(Icons.person),
              hintText: 'DIGITE SEU CPF',
              ),  
            ),
            TextField(
              maxLength: 8,
              obscureText: true,
              obscuringCharacter: '*',
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderSide:
                 BorderSide(color: Colors.black,width: 5.0),),
              icon: Icon(Icons.key),
              hintText: 'DIGITE SUA SENHA',
              ),
              controller: _textEditingControllersenha,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
                onSurface: Colors.green,
                elevation: 16,
                shadowColor: Colors.red,
              ), 
              child: Text('ENTRAR'),
              onPressed: () {},
            ),
            SizedBox(height: 15),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                onSurface: Colors.red,
                elevation: 16,
                shadowColor: Colors.red,
              ), 
              child: Text('NÃO TEM CONTA? REGISTRE-SE'),
              onPressed: () {},
            ),            
          ]),
        ),
      ),
    );
  }
}
