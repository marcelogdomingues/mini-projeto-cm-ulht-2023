import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:provider/provider.dart';

import 'package:iquechumbei/models/avaliacao.dart';
import 'package:iquechumbei/screen/lista_avaliacao.dart';
import 'package:iquechumbei/main.dart';
import '../provider/avaliacao_provider.dart';

class RegistoAvaliacaoPage extends StatefulWidget {
  @override
  _RegistoAvaliacaoPageState createState() => _RegistoAvaliacaoPageState();
}

class _RegistoAvaliacaoPageState extends State<RegistoAvaliacaoPage> {
  final _formKey = GlobalKey<FormState>(); //Chave global usada para identificar o formulário e validar os campos.
  //Controladores de texto usados para obter valores dos campos de entrada do formulário.
  final _disciplinaController = TextEditingController();
  final _dataHoraController = TextEditingController();
  final _dificuldadeController = TextEditingController();
  final _observacoesController = TextEditingController();
  final _tiposAvaliacao = ['Frequência', 'Mini-teste', 'Projeto', 'Defesa'];
  String? _selectedTipoAvaliacao;
  int _dificuldadeValue = 1;

  int _observacoesLength = 0;
  int _maxObservacoesLength = 200;
  String dificuldadeText = 'Fácil';

  //Função que é chamada quando o formulário é submetido e os campos passam na validação.
  //Esta função cria uma nova instância de Avaliacao com os valores do formulário e adiciona à lista _avaliacoes antes de navegar para a página ListaAvaliacao.
  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final avaliacao = Avaliacao(
        id: Uuid().v4(),
        disciplina: _disciplinaController.text,
        tipo: _selectedTipoAvaliacao!,
        dataHora: DateFormat('yyyy/MM/dd HH:mm').parse(_dataHoraController.text),
        dificuldade: _dificuldadeValue,
        observacoes: _observacoesController.text,
      );
      // Save the new avaliacao to the provider
      context.read<AvaliacoesProvider>().addAvaliacao(avaliacao);

      // show snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('A avaliação foi registada com sucesso.'),
        ),
      );

      // wait for snackbar to disappear
      await Future.delayed(Duration(milliseconds: 800));

      // Navigate to the listagem page
      Navigator.of(context).push(
        MaterialPageRoute(
          //builder: (context) => ListaAvaliacao(avaliacoes: context.watch<AvaliacoesProvider>().avaliacoes),
          builder: (context) => iQueChumbei(initialIndex: 1),
        ),
      );
      return;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registo de Avaliação'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _disciplinaController,
                decoration: InputDecoration(
                  labelText: 'Disciplina',
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Por favor, insira a disciplina';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              DropdownButtonFormField(
                decoration: InputDecoration(
                  labelText: 'Tipo de avaliação',
                  hintText: 'Selecione o tipo de avaliação',
                ),
                value: _selectedTipoAvaliacao,
                onChanged: (value) {
                  setState(() {
                    _selectedTipoAvaliacao = value as String?;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Por favor, selecione o tipo de avaliação';
                  }
                  return null;
                },
                items: _tiposAvaliacao
                    .map((tipo) => DropdownMenuItem(
                  value: tipo,
                  child: Text(tipo),
                ))
                    .toList(),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _dataHoraController,
                decoration: InputDecoration(
                  labelText: 'Data e Hora',
                  hintText: 'ex: 2023/03/06 12:30',
                  suffixIcon: Icon(Icons.date_range),
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Por favor, insira a data e hora';
                  }
                  try {
                    var dateTime = DateFormat('yyyy/MM/dd HH:mm').parse(value!);
                    if(dateTime.isAfter(DateTime.now())){
                      return null;
                    } else {
                      return 'A data e hora de realização não pode ser no passado!';
                    }
                  } catch (e) {
                    return 'Data e hora inválidas';
                  }
                },
              ),
              SizedBox(height: 16.0),
              Builder(
                builder: (BuildContext context) {
                  String dificuldadeText = '';
                  switch (_dificuldadeValue) {
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
                  return Text(
                    'Nível de dificuldade: $_dificuldadeValue / 5 - $dificuldadeText',
                    style: TextStyle(fontSize: 16),
                  );
                },
              ),
              Slider(
                value: _dificuldadeValue.toDouble(),
                min: 1,
                max: 5,
                divisions: 4,
                onChanged: (value) {
                  setState(() {
                    _dificuldadeValue = value.toInt();
                  });
                },
                label: '$_dificuldadeValue',
                semanticFormatterCallback: (double value) {
                  String dificuldadeText = '';
                  switch (value.toInt()) {
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
                  return dificuldadeText;
                },
              ),
              TextFormField(
                controller: _observacoesController,
                maxLength: _maxObservacoesLength,
                maxLines: null, // permite múltiplas linhas
                decoration: InputDecoration(
                  labelText: 'Observações',
                  counterText: '$_observacoesLength/$_maxObservacoesLength',
                ),
                onChanged: (value) {
                  setState(() {
                    _observacoesLength = value.length;
                  });
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () => _submitForm(),
                child: Text('Registar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}