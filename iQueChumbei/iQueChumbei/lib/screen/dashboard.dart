import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '/models/avaliacao.dart';
import '/data/chart_dashboard_data.dart';
import 'package:fl_chart/fl_chart.dart';

class Dashboard extends StatefulWidget {
  final List<Avaliacao> avaliacoes;

  Dashboard({required this.avaliacoes});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<Avaliacao> _avaliacoes = []; // initialize _avaliacoes with an empty list
  double _avgDificuldade7Days = 0.0;
  double _avgDificuldade7to14Days = 0.0;
  List<Avaliacao> _avaliacoes7Days = [];

  @override
  void initState() {
    super.initState();
    _avaliacoes = widget.avaliacoes;
    _calcAveragesAnd7Days();
  }

  void _calcAveragesAnd7Days() {
    var now = DateTime.now();
    var sevenDaysFromNow = now.add(Duration(days: 7));
    var fourteenDaysFromNow = now.add(Duration(days: 14));
    var totalDificuldade7Days = 0.0;
    var totalDificuldade7to14Days = 0.0;
    var count7Days = 0;
    var count7to14Days = 0;

    for (var avaliacao in _avaliacoes) {
      if (avaliacao.dataHora.isAfter(now) && avaliacao.dataHora.isBefore(sevenDaysFromNow.add(Duration(days: 1)))) {
        totalDificuldade7Days += avaliacao.dificuldade;
        count7Days++;
      } else if (avaliacao.dataHora.isAfter(sevenDaysFromNow) && avaliacao.dataHora.isBefore(fourteenDaysFromNow.add(Duration(days: 1)))) {
        totalDificuldade7to14Days += avaliacao.dificuldade;
        count7to14Days++;
      }
    }

    if (count7Days > 0) {
      _avgDificuldade7Days = totalDificuldade7Days / count7Days;
    } else {
      _avgDificuldade7Days = 0.0;
    }

    if (count7to14Days > 0) {
      _avgDificuldade7to14Days = totalDificuldade7to14Days / count7to14Days;
    } else {
      _avgDificuldade7to14Days = 0.0;
    }

    _avaliacoes7Days = _avaliacoes.where((avaliacao) => avaliacao.dataHora.isBefore(sevenDaysFromNow.add(Duration(days: 1)))).toList();
  }

  List<DificuldadeData> _getDificuldadeData() {
    var totalDificuldadeFacil = 0;
    var totalDificuldadeMedia = 0;
    var totalDificuldadeDificil = 0;

    for (var avaliacao in _avaliacoes7Days) {
      if (avaliacao.dificuldade <= 2) {
        totalDificuldadeFacil++;
      } else if (avaliacao.dificuldade <= 4) {
        totalDificuldadeMedia++;
      } else {
        totalDificuldadeDificil++;
      }
    }

    return [
      DificuldadeData('Fácil', totalDificuldadeFacil, const Color(0xFF4CAF50)),
      DificuldadeData('Média', totalDificuldadeMedia, const Color(0xFFEF8344)),
      DificuldadeData('Difícil', totalDificuldadeDificil, const Color(0xFFF44336)),
    ];
  }

  PieChart _buildPieChart() {
    var data = _getDificuldadeData();

    return PieChart(
      PieChartData(
        sections: List<PieChartSectionData>.generate(
          data.length,
              (index) {
            return PieChartSectionData(
              color: data[index].color,
              value: data[index].value.toDouble(),
              title: data[index].label,
              radius: 150,
              titleStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff),
              ),
            );
          },
        ),
        sectionsSpace: 0,
        centerSpaceRadius: 0,
        borderData: FlBorderData(show: false),
        pieTouchData: PieTouchData(
          enabled: true,
          touchCallback: (FlTouchEvent event, pieTouchResponse) {
            // Handle touch events here
          },
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Próximos 7 dias:',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _avaliacoes7Days.length,
              itemBuilder: (BuildContext context, int index) {
                // calculate the color of the subtitle based on the date of the evaluation
                Color? subtitleColor;
                var daysUntilEvaluation = _avaliacoes7Days[index].dataHora.difference(DateTime.now()).inDays;
                var subtitleText = '${_avaliacoes7Days[index].tipo} - ${DateFormat('dd/MM/yyyy HH:mm').format(_avaliacoes7Days[index].dataHora)}';
                if (daysUntilEvaluation == 0) {
                  return ListTile(
                    title: Text(_avaliacoes7Days[index].disciplina),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: subtitleText,
                                style: TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          'No dia',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.redAccent),
                        ),
                      ],
                    ),
                    trailing: Text(
                      'Dificuldade: ${_avaliacoes7Days[index].dificuldade}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  );
                } else if (daysUntilEvaluation == 1){
                  return ListTile(
                    title: Text(_avaliacoes7Days[index].disciplina),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: subtitleText,
                                style: const TextStyle(color: Colors.orange),
                              ),
                            ],
                          ),
                        ),
                        const Text(
                          'Amanhã',
                          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.orangeAccent),
                        ),
                      ],
                    ),
                    trailing: Text(
                      'Dificuldade: ${_avaliacoes7Days[index].dificuldade}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  );
                } else if (daysUntilEvaluation == 2 || daysUntilEvaluation == 3) {
                  print(daysUntilEvaluation);
                  return ListTile(
                    title: Text(_avaliacoes7Days[index].disciplina),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: subtitleText,
                                style: const TextStyle(color: Colors.blue),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          'Faltam ${daysUntilEvaluation} dias',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueAccent),
                        ),
                      ],
                    ),
                    trailing: Text(
                      'Dificuldade: ${_avaliacoes7Days[index].dificuldade}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  );
                } else {
                }
                if (_avaliacoes7Days[index].dataHora.weekday == DateTime.monday &&
                    (daysUntilEvaluation == 4 || daysUntilEvaluation == 5 || daysUntilEvaluation == 6)) {
                  return ListTile(
                    title: Text(_avaliacoes7Days[index].disciplina),
                    subtitle: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: subtitleText,
                            style: TextStyle(color: subtitleColor),
                          ),
                          const TextSpan(
                            text: ' - dia seguinte',
                            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.redAccent),
                          ),
                        ],
                      ),
                    ),
                    trailing: Text(
                      'Dificuldade: ${_avaliacoes7Days[index].dificuldade}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  );
                }
                return ListTile(
                  title: Text(_avaliacoes7Days[index].disciplina),
                  subtitle: Text(
                    subtitleText,
                    style: TextStyle(color: subtitleColor),
                  ),
                  trailing: Text(
                    'Dificuldade: ${_avaliacoes7Days[index].dificuldade}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                );
              },
            ),
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: const Text(
                'Dificuldade Média:',
                style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Próximos 7 dias:'),
                        Text(_avgDificuldade7Days.toStringAsFixed(2), style: const TextStyle(fontSize: 24.0)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Próximos 7 a 14 dias:'),
                        Text(_avgDificuldade7to14Days.toStringAsFixed(2), style: TextStyle(fontSize: 24.0)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: const Text(
                'Gráfico Dificuldade:',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 300.0, child: _buildPieChart()),
            SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Próximas Avaliações:',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _avaliacoes.length,
              itemBuilder: (BuildContext context, int index) {
                var daysUntilEvaluation = _avaliacoes[index].dataHora.difference(DateTime.now()).inDays;
                if (daysUntilEvaluation > 7) {
                  return ListTile(
                    title: Text(_avaliacoes[index].disciplina),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${_avaliacoes[index].tipo} - ${DateFormat('dd/MM/yyyy HH:mm').format(_avaliacoes[index].dataHora)}',
                          style: TextStyle(color: Colors.green),
                        ),
                        Text(
                          'Ainda tens tempo 😎 -  ${daysUntilEvaluation} dias',
                          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.lightGreen),
                        ),
                      ],
                    ),
                    trailing: Text(
                      'Dificuldade: ${_avaliacoes[index].dificuldade}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}