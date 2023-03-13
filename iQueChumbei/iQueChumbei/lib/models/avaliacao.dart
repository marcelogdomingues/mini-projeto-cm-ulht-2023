class Avaliacao {
  final String id; // Identificador único da avaliação
  final String disciplina; // Nome da disciplina da avaliação
  final String tipo; // Tipo de avaliação (ex: prova, trabalho, apresentação)
  final DateTime dataHora; // Data e hora da avaliação
  final int dificuldade; // Grau de dificuldade da avaliação (de 1 a 5)
  final String? observacoes; // Observações adicionais sobre a avaliação

  // Construtor da classe Avaliacao
  Avaliacao({
    required this.id,
    required this.disciplina,
    required this.tipo,
    required this.dataHora,
    required this.dificuldade,
    this.observacoes,
  });

  // Getter para as observações, retorna "Sem Observações" caso não haja nada definido
  String get observacoesText => observacoes?.isNotEmpty == true ? observacoes! : 'Sem Observações';

  // Converte o objeto Avaliacao para um Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'disciplina': disciplina,
      'tipo': tipo,
      'dataHora': dataHora.toIso8601String(),
      'dificuldade': dificuldade,
      'observacoes': observacoes,
    };
  }

  // Cria um objeto Avaliacao a partir de um Map
  factory Avaliacao.fromMap(Map<String, dynamic> map) {
    return Avaliacao(
      id: map['id'] as String,
      disciplina: map['disciplina'] as String,
      tipo: map['tipo'] as String,
      dataHora: DateTime.parse(map['dataHora'] as String),
      dificuldade: map['dificuldade'] as int,
      observacoes: map['observacoes'] as String?,
    );
  }
}
