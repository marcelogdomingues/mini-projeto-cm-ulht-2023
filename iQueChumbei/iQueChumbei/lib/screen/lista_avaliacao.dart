import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/avaliacao.dart';
import 'detalhe_avaliacao.dart';
import 'editar_avaliacao.dart';


class ListaAvaliacao extends StatefulWidget {
  final List<Avaliacao> avaliacoes;

  ListaAvaliacao({required this.avaliacoes});

  @override
  _ListaAvaliacaoState createState() => _ListaAvaliacaoState();
}

class _ListaAvaliacaoState extends State<ListaAvaliacao> {

  @override
  void initState() {
    widget.avaliacoes.sort((a, b) => a.dataHora.compareTo(b.dataHora));
  }

  void _deleteAvaliacao(Avaliacao avaliacao) {
    if (avaliacao.dataHora.isBefore(DateTime.now())) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Só podem ser eliminados registos de avaliações futuras.'),
        ),
      );
      return;
    }

    setState(() {
      widget.avaliacoes.remove(avaliacao);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('O registo de avaliação selecionado foi eliminado com sucesso.'),
      ),
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
        final index = widget.avaliacoes.indexWhere((element) => element.id == result.id);
        widget.avaliacoes[index] = result;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('O registo de avaliação selecionado foi editado com sucesso.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final isDarkMode = brightness == Brightness.dark;

    return Theme(
      data: isDarkMode ? ThemeData.dark() : ThemeData.light(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Lista de Avaliações'),
        ),
        body: ListView.builder(
          itemCount: widget.avaliacoes.length,
          itemBuilder: (BuildContext context, int index) {
            final avaliacao = widget.avaliacoes[index];

            final color = avaliacao.dataHora.isBefore(DateTime.now().add(Duration(days: 1)))
                ? Colors.red
                : isDarkMode ? Colors.white : Colors.black;
            return Dismissible(
              key: ValueKey(avaliacao),
              direction: DismissDirection.endToStart,
              background: Container(
                alignment: Alignment.centerRight,
                color: Colors.red,
                child: Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
              ),
              confirmDismiss: (direction) async {
                if (avaliacao.dataHora.isBefore(DateTime.now())) {
                  return false;
                }
                final result = await showDialog<bool>(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Tem a certeza que pretende eliminar esta avaliação?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                          child: Text('Não'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(true);
                          },
                          child: Text('Sim'),
                        ),
                      ],
                    );
                  },
                );

                if (result == true) {
                  _deleteAvaliacao(avaliacao);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Registo de avaliação eliminado com sucesso.'),
                    ),
                  );
                }
                return result ?? false;
              },
              child: ListTile(
                title: Text(avaliacao.disciplina),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(DateFormat('dd/MM/yyyy HH:mm', 'pt_PT').format(avaliacao.dataHora)),
                    Text('Tipo de Avaliação : ${avaliacao.disciplina}'),
                    Text('Dificuldade: ${avaliacao.dificuldade}'),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () => _editAvaliacao(avaliacao),
                    ),
                    SizedBox(width: 8),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () async {
                        if (avaliacao.dataHora.isBefore(DateTime.now())) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Só podem ser eliminados registos de avaliações futuras.'),
                            ),
                          );
                        } else {
                          final result = await showDialog<bool>(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Tem a certeza que pretende eliminar esta avaliação?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(false);
                                    },
                                    child: Text('Não'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(true);
                                    },
                                    child: Text('Sim'),
                                  ),
                                ],
                              );
                            },
                          );
                          if (result == true) {
                            _deleteAvaliacao(avaliacao);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Registo de avaliação eliminado com sucesso.'),
                              ),
                            );
                          }
                        }
                      },
                    )
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetalheAvaliacao(avaliacao: avaliacao),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
