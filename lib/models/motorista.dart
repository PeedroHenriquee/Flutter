import 'package:appprojetointegrador/Data/DAOUsuarios.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';

class Motorista {
  Object? id;
  Object? nome;
  Object? sobrenome;
  Object? usuario;
  Object? email;
  Object? senha;
  Object? receita;
  Object? valorFinanciado;
  Object? valorAlugado;
  Object? valorManutencao;
  Object? abastecimentos;

  Motorista({
    required this.id,
    required this.nome,
    required this.sobrenome,
    required this.usuario,
    required this.email,
    required this.senha,
    required this.receita,
    required valorFinanciado,
    required valorAlugado,
    required valorManutencao,
    required abastecimentos,
  });
}
