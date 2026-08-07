import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'cart_notifier.dart';
import 'cart_state.dart';

final cartProvider =
    NotifierProvider<CartNotifier, CartState>(
  CartNotifier.new,
);
