import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Escuta as alterações no CartProvider
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Seu Carrinho'),
        backgroundColor: Colors.blue,
      ),
      body: cart.items.isEmpty
          ? const Center(
              child: Text(
                'Seu carrinho está vazio 😢',
                style: TextStyle(fontSize: 18),
              ),
            )
          : Column(
              children: [
                // Lista de produtos adicionados
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.items.length,
                    itemBuilder: (context, index) {
                      final product = cart.items[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: ListTile(
                          title: Text(product.name),
                          subtitle: Text('R\$ ${product.price.toStringAsFixed(2)}'),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              // GERENCIAMENTO DE ESTADO: Remove o item do carrinho
                              cart.removeFromCart(product);
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
                
                // Painel inferior com o valor total do carrinho
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total:',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'R\$ ${cart.totalPrice.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 20, 
                              fontWeight: FontWeight.bold, 
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}