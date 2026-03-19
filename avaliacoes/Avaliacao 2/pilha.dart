class Pilha {
  final List _elementos = [];

  // Empilhar um elemento
  void empilhar(valor) {
    _elementos.add(valor);
  }

  // Desempilhar o elemento do topo
   desempilhar() {
    if (_elementos.isEmpty) {
      throw Exception('Pilha vazia');
    }
    return _elementos.removeLast();
  }

  // Retornar o elemento do topo sem remover
   topo() {
    if (_elementos.isEmpty) {
      throw Exception('Pilha vazia');
    }
    return _elementos.last;
  }

  // Mostrar todos os elementos da pilha
  void mostrarPilha() {
    if (_elementos.isEmpty) {
      print('Pilha vazia');
      return;
    }
    print('Elementos da pilha (topo → base):');
    for (int i = _elementos.length - 1; i >= 0; i--) {
      print(_elementos[i]);
    }
  }

  // Verifica se a pilha está vazia
  bool get isEmpty => _elementos.isEmpty;

  // Retorna o tamanho da pilha
  int get tamanho => _elementos.length;
}