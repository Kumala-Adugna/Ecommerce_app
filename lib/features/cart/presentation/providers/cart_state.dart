import '../../domain/entities/cart_item.dart';

class CartState {
  final List<CartItem> items;

  const CartState({
    this.items = const [],
  });

  double get totalAmount {
    return items.fold(
      0,
      (sum, item) => sum + item.totalPrice,
    );
  }

  int get itemCount {
    return items.fold(
      0,
      (sum, item) => sum + item.quantity,
    );
  }

  CartState copyWith({
    List<CartItem>? items,
  }) {
    return CartState(
      items: items ?? this.items,
    );
  }
}
