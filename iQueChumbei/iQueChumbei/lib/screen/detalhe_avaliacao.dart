import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';

import '../models/avaliacao.dart';
import 'editar_avaliacao.dart';

class DetalheAvaliacao extends StatefulWidget {
  final Avaliacao avaliacao;

  DetalheAvaliacao({required this.avaliacao});

  @override
  _DetalheAvaliacaoState createState() => _DetalheAvaliacaoState();
}

class _DetalheAvaliacaoState extends State<DetalheAvaliacao> {

  late Avaliacao _avaliacao;

  void initState() {
    super.initState();
    _avaliacao = Avaliacao(
      id: widget.avaliacao.id,
      disciplina: widget.avaliacao.disciplina,
      tipo: widget.avaliacao.tipo,
      dataHora: widget.avaliacao.dataHora,
      dificuldade: widget.avaliacao.dificuldade,
    );
  }

  void _editAvaliacao(Avaliacao avaliacao) async {
    if (avaliacao.dataHora.isBefore(DateTime.now())) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Só podem ser editados registos de avaliações futuras.'),
        ),
      );
      return;
    }

    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditarAvaliacao(avaliacao: avaliacao),
      ),
    );

    if (result != null && result is Avaliacao) {
      setState(() {
        _avaliacao = result;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('O registo de avaliação selecionado foi editado com sucesso.'),
        ),
      );
    }
  }

  void _sendText() async {
    final Uri uri = Uri(
      scheme: 'sms',
      path: 'sms://',
      queryParameters: {'body': _buildMessage()},
    );

    try {
      await launch(uri.toString());
    } catch (e) {
      print('Error launching SMS: $e');
    }
  }

  void _launchEmail() async {
    final Uri uri = Uri(
      scheme: 'mailto',
      path: '',
      queryParameters: {
        'to': '', // substituir pelo endereço de e-mail do destinatário
        'subject': 'Avaliação de ${widget.avaliacao.disciplina}',
        'body': _buildMessage(),
      },
    );

    try {
      await launch(uri.toString());
    } catch (e) {
      print('Error launching email: $e');
    }
  }

  String _buildMessage() {
    return 'Vamos ter avaliação de ${widget.avaliacao.disciplina}, em ${widget.avaliacao.dataHora}, com a dificuldade de ${widget.avaliacao.dificuldade} numa escala de 1 a 5.\nObservações para esta avaliação: ${widget.avaliacao.observacoes}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhe da Avaliação'),
        actions: [
          IconButton(
            onPressed: () {
              Share.share(_buildMessage());
            },
            icon: Icon(Icons.share),
          ),
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => _editAvaliacao(_avaliacao),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _avaliacao.disciplina,
              style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Text(
                  'Tipo: ',
                  style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  '${_avaliacao.tipo}',
                  style: const TextStyle(fontSize: 20.0),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Text(
                  'Data e Hora: ',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  '${DateFormat('dd/MM/yyyy HH:mm').format(_avaliacao.dataHora)}',
                  style: TextStyle(fontSize: 20.0),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Builder(
              builder: (BuildContext context) {
                String dificuldadeText = '';
                int _avaliacaoDif = _avaliacao.dificuldade;
                switch (_avaliacaoDif) {
                  case 1:
                    dificuldadeText = 'Fácil';
                    break;
                  case 2:
                    dificuldadeText = 'Moderado';
                    break;
                  case 3:
                    dificuldadeText = 'Médio';
                    break;
                  case 4:
                    dificuldadeText = 'Difícil';
                    break;
                  case 5:
                    dificuldadeText = 'Muito difícil';
                    break;
                  default:
                    break;
                }
                return Row(
                  children: [
                    Text(
                      'Nível de dificuldade: ',
                      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '$_avaliacaoDif / 5 - $dificuldadeText',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                );
              },
            ),
            SizedBox(height: 16.0),
            RichText(
              text: TextSpan(
                style: TextStyle(fontSize: 18.0, color: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white),
                children: [
                  TextSpan(
                    text: 'Observações: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: _avaliacao.observacoes != null && _avaliacao.observacoes!.isNotEmpty ? _avaliacao.observacoes! : 'Nenhuma observação.',
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: _sendText,
                  child: Text('Enviar mensagem'),
                ),
                ElevatedButton(
                  onPressed: _launchEmail,
                  child: Text('Enviar email'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
