import 'package:flutter/material.dart';
import 'api_service.dart';
import 'user_model.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  final ApiService _apiService = ApiService();
  late Future<List<UserModel>> _futureUsers;

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  // Inicializa ou reinicializa a busca dos dados
  void _loadUsers() {
    setState(() {
      _futureUsers = _apiService.fetchUsers();
    });
  }

  // Função disparada ao puxar a tela para baixo
  Future<void> _handleRefresh() async {
    _loadUsers();
    await _futureUsers; // Aguarda a nova requisição terminar para sumir o indicador
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Usuários Cadastrados'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: FutureBuilder<List<UserModel>>(
          future: _futureUsers,
          builder: (context, snapshot) {
            // 1. Estado de Carregamento (Loading)
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            // 2. Estado de Erro
            if (snapshot.hasError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: Colors.red,
                        size: 60,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Ops! Ocorreu um problema.',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${snapshot.error}'.replaceAll('Exception: ', ''),
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: _loadUsers,
                        icon: const Icon(Icons.refresh),
                        label: const Text('Tentar Novamente'),
                      ),
                    ],
                  ),
                ),
              );
            }

            // 3. Estado de Sucesso (Dados Prontos)
            if (snapshot.hasData) {
              final users = snapshot.data!;

              if (users.isEmpty) {
                return const Center(child: Text('Nenhum usuário encontrado.'));
              }

              // O ListView.builder renderiza os itens sob demanda (otimiza memória)
              return ListView.builder(
                padding: const EdgeInsets.all(12.0),
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.blueAccent.withOpacity(0.2),
                        child: Text(
                          user.name[0],
                          style: const TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      title: Text(
                        user.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('${user.email}\nEmpresa: ${user.company}'),
                      isThreeLine: true,
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    ),
                  );
                },
              );
            }

            return const Center(child: Text('Nenhum dado disponível.'));
          },
        ),
      ),
    );
  }
}
