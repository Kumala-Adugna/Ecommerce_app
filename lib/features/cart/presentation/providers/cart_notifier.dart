import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/storage/local_storage_service.dart';
import '../../../../core/storage/storage_provider.dart';

import '../../domain/entities/cart_item.dart';
import '../../../products/domain/entities/product.dart';

import 'cart_state.dart';

class CartNotifier extends Notifier<CartState> {
  late final LocalStorageService storage;

  @override
  CartState build() {
    storage = ref.read(localStorageProvider);

    final savedCart = storage.getCart();

    return CartState(
      items: savedCart.map((item) => CartItem.fromJson(item)).toList(),
    );
  }

  Future<void> saveCart() async {
    await storage.saveCart(state.items.map((item) => item.toJson()).toList());
  }

  void addToCart(Product product) {
    final existingIndex = state.items.indexWhere(
      (item) => item.product.id == product.id,
    );

    if (existingIndex >= 0) {
      final updatedItems = [...state.items];

      updatedItems[existingIndex] = updatedItems[existingIndex].copyWith(
        quantity: updatedItems[existingIndex].quantity + 1,
      );

      state = state.copyWith(items: updatedItems);
    } else {
      state = state.copyWith(
        items: [
          ...state.items,

          CartItem(product: product, quantity: 1),
        ],
      );
    }

    saveCart();
  }

  void removeFromCart(int productId) {
    state = state.copyWith(
      items: state.items.where((item) => item.product.id != productId).toList(),
    );

    saveCart();
  }

  void increaseQuantity(int productId) {
    final updatedItems = state.items.map((item) {
      if (item.product.id == productId) {
        return item.copyWith(quantity: item.quantity + 1);
      }

      return item;
    }).toList();

    state = state.copyWith(items: updatedItems);

    saveCart();
  }

  void decreaseQuantity(int productId) {
    final updatedItems = state.items.map((item) {
      if (item.product.id == productId && item.quantity > 1) {
        return item.copyWith(quantity: item.quantity - 1);
      }

      return item;
    }).toList();

    state = state.copyWith(items: updatedItems);

    saveCart();
  }

  void clearCart() {
    state = const CartState();

    storage.clearCart();
  }
}
