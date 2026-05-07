import 'pilha.dart';

void main() {
  Pilha pilha = Pilha();

  print('Empilhando elementos...');
  pilha.empilhar(10);
  pilha.empilhar(20);
  pilha.empilhar(30);

  print('\nMostrando a pilha:');
  pilha.mostrarPilha();

  // Mostrar topo corretamente
  print('\nTopo da pilha: ${pilha.topo()}');

  // Desempilhar corretamente
  print('\nDesempilhando: ${pilha.desempilhar()}');

  print('\nPilha após desempilhar:');
  pilha.mostrarPilha();
}