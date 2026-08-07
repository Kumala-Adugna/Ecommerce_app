import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'category_notifier.dart';
import 'category_state.dart';

final categoryProvider = NotifierProvider<CategoryNotifier, CategoryState>(
  CategoryNotifier.new,
);
