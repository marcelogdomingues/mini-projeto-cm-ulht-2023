import 'package:flutter/material.dart';
import 'package:iquechumbei/models/avaliacao.dart';

class AvaliacoesProvider extends ChangeNotifier {
  final List<Avaliacao> _avaliacoes = [
    Avaliacao(
      id: '1',
      disciplina: 'Computação Móvel',
      tipo: 'Projeto',
      dataHora: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 10, 0),
      dificuldade: 4,
      observacoes: 'Um bocadinho Trabalhoso',
    ),
    Avaliacao(
      id: '2',
      disciplina: 'Algoritmia e Estrutura de Dados',
      tipo: 'Defesa',
      dataHora: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day+2, 13, 30),
      dificuldade: 1,
      observacoes: 'Se é Java é Fácil',
    ),
    Avaliacao(
      id: '3',
      disciplina: 'Álgebra Linear',
      tipo: 'Frequência',
      dataHora: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day+3, 10, 0),
      dificuldade: 5,
      observacoes: 'Preciso de rezar',
    ),
    Avaliacao(
      id: '4',
      disciplina: 'Calculo I',
      tipo: 'Mini-teste',
      dataHora: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day+10, 10, 0),
      dificuldade: 5,
      observacoes: 'Meh',
    ),
  ];

  List<Avaliacao> get avaliacoes => _avaliacoes;

  void addAvaliacao(Avaliacao avaliacao) {
    _avaliacoes.add(avaliacao);
    notifyListeners();
  }

  void deleteAvaliacao(Avaliacao avaliacao) {
    _avaliacoes.remove(avaliacao);
    notifyListeners();
  }

  void editAvaliacao(Avaliacao avaliacao) {
    final index = _avaliacoes.indexWhere((element) => element.id == avaliacao.id);
    _avaliacoes[index] = avaliacao;
    notifyListeners();
  }
}
