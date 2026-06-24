import 'package:flutter/material.dart';
import 'user_list_screen.dart'; // Ficará vermelho até você criar o arquivo!

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // REMOVIDO o 'const' daqui de baixo:
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:
          const UserListScreen(), // O 'const' pode ir aqui, se o construtor da tela permitir
    );
  }
}
