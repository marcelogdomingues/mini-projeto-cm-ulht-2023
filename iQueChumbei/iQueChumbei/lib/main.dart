import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:iquechumbei/screen/dashboard.dart';
import 'package:iquechumbei/screen/lista_avaliacao.dart';
import 'package:iquechumbei/screen/registo_avaliacao.dart';
import 'package:iquechumbei/provider/avaliacao_provider.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(
    ChangeNotifierProvider(
      create: (_) => AvaliacoesProvider(),
      child: iQueChumbei(initialIndex: 0),
    ),
  ));
}

class iQueChumbei extends StatefulWidget {
  final int initialIndex;

  const iQueChumbei({Key? key, this.initialIndex = 0}) : super(key: key);

  @override
  _iQueChumbeiState createState() => _iQueChumbeiState();
}

class _iQueChumbeiState extends State<iQueChumbei> {
  int _currentIndex = 0;
  bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }


  @override
  Widget build(BuildContext context) {
    final avaliacoesProvider = Provider.of<AvaliacoesProvider>(context);

    List<Widget> _screens = [
      Dashboard(avaliacoes: avaliacoesProvider.avaliacoes),
      ListaAvaliacao(avaliacoes: avaliacoesProvider.avaliacoes),
      RegistoAvaliacaoPage(),
    ];

    return MaterialApp(
      title: 'iQueChumbei',
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        body: _screens[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.dashboard),
              label: 'Dashboard',
            ),
            const BottomNavigationBarItem(
              icon: const Icon(Icons.list),
              label: 'Lista Avaliações',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: 'Registo de Avaliação',
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _isDarkMode = !_isDarkMode;
            });
          },
          child: Icon(Icons.brightness_6),
        ),
      ),
    );
  }
}
