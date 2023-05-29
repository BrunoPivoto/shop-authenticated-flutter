class CartItem {
  final String id;
  final String productId;
  final String name;
  final int qnt;
  final double price;

  CartItem(
      {required this.id,
      required this.productId,
      required this.name,
      required this.qnt,
      required this.price});
}
