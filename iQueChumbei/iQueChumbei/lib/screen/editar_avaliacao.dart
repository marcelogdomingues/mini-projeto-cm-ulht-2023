import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../models/avaliacao.dart';

class EditarAvaliacao extends StatefulWidget {
  final Avaliacao avaliacao;

  EditarAvaliacao({required this.avaliacao});

  @override
  _EditarAvaliacaoState createState() => _EditarAvaliacaoState();
}

class _EditarAvaliacaoState extends State<EditarAvaliacao> {
  final _formKey = GlobalKey<FormState>();
  final _disciplinaController = TextEditingController();
  final _dataHoraController = TextEditingController();
  final _dificuldadeController = TextEditingController();
  final _observacoesController = TextEditingController();
  final _tiposAvaliacao = ['Frequência', 'Mini-teste', 'Projeto', 'Defesa'];

  String? _selectedTipoAvaliacao;
  int _dificuldadeValue = 1;

  @override
  void initState() {
    super.initState();

    // Pre-populate the form fields with the existing values
    _disciplinaController.text = widget.avaliacao.disciplina;
    _selectedTipoAvaliacao = widget.avaliacao.tipo;
    _dataHoraController.text = DateFormat('yyyy/MM/dd HH:mm').format(widget.avaliacao.dataHora);
    _dificuldadeValue = widget.avaliacao.dificuldade;
    _observacoesController.text = widget.avaliacao.observacoes ?? '';
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final updatedAvaliacao = Avaliacao(
        id: widget.avaliacao.id,
        disciplina: _disciplinaController.text,
        tipo: _selectedTipoAvaliacao!,
        dataHora: DateFormat('yyyy/MM/dd HH:mm').parse(_dataHoraController.text),
        dificuldade: _dificuldadeValue,
        observacoes: _observacoesController.text.isNotEmpty ? _observacoesController.text : null,
      );

      // TODO: Update the existing avaliacao with the new values

      Navigator.of(context).pop(updatedAvaliacao);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Avaliação'),
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
                    DateFormat('yyyy/MM/dd HH:mm').parse(value!);
                    return null;
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
                decoration: InputDecoration(
                  labelText: 'Observações',
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () => _submitForm(),
                child: Text('Editar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}