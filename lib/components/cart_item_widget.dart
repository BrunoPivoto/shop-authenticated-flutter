import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/cart_item.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;
  const CartItemWidget({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(cartItem.id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Theme.of(context).colorScheme.error,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 15),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      confirmDismiss: (_) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Tem certeza?'),
            content: const Text('Quer remover o item do carrinho?'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop(false);
                  },
                  child: const Text('Não')),
              TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop(true);
                  },
                  child: const Text('Sim')),
            ],
          ),
        );
      },
      onDismissed: (_) {
        Provider.of<Cart>(context, listen: false)
            .removeItem(cartItem.productId);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 15),
        child: ListTile(
          leading: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              radius: 25,
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: FittedBox(
                  child: Text(
                    'R\$${cartItem.price}',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              )),
          title: Text(cartItem.name),
          subtitle: Text(
              'Total: R\$ ${(cartItem.price * cartItem.qnt).toStringAsFixed(2)}'),
          trailing: Text('x${cartItem.qnt}'),
        ),
      ),
    );
  }
}
