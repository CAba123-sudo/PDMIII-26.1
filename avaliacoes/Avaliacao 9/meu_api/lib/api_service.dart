import 'dart:convert';
import 'package:http/http.dart' as http;
import 'user_model.dart';

class ApiService {
  final String _url = 'https://jsonplaceholder.typicode.com/users';

  Future<List<UserModel>> fetchUsers() async {
    try {
      final response = await http
          .get(Uri.parse(_url))
          .timeout(
            const Duration(
              seconds: 10,
            ), // Evita que o app espere indefinidamente
          );

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        // Mapeia a lista dinâmica do JSON para uma lista de UserModels
        return body.map((dynamic item) => UserModel.fromJson(item)).toList();
      } else {
        throw Exception(
          'Falha ao carregar usuários: Código ${response.statusCode}',
        );
      }
    } catch (e) {
      // Captura erros de falta de internet, timeout ou problemas no parse
      throw Exception('Erro de conexão ou servidor: $e');
    }
  }
}
