class AreasEnum {
  static const String saida = 'Saída';
  static const String entrada = 'Entrada';
  static const String conves = 'Convés';
  static const String pracaDeMaquinas = 'Praça de Máquinas';
  static const String casario = 'Casario';

  static const List<String> areas = [conves, pracaDeMaquinas, casario];

  static String getArea(int index) {
    return areas[index];
  }
}
