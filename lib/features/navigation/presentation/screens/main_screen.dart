import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../products/presentation/screens/home_screen.dart';
import '../../../cart/presentation/screens/cart_screen.dart';
import '../../../cart/presentation/providers/cart_provider.dart';
import '../../../profile/presentation/screens/profile_screen.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  int currentIndex = 0;

  final List<Widget> screens = [
    const HomeScreen(),

    const CartScreen(),

    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(cartProvider);

    return Scaffold(
      body: IndexedStack(index: currentIndex, children: screens),

      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,

        onDestinationSelected: (index) {
          setState(() {
            currentIndex = index;
          });
        },

        destinations: [
          const NavigationDestination(
            icon: Icon(Icons.home_outlined),

            selectedIcon: Icon(Icons.home),

            label: 'Home',
          ),

          NavigationDestination(
            icon: Badge(
              isLabelVisible: cart.items.isNotEmpty,

              label: Text('${cart.items.length}'),

              child: const Icon(Icons.shopping_cart_outlined),
            ),

            selectedIcon: Badge(
              isLabelVisible: cart.items.isNotEmpty,

              label: Text('${cart.items.length}'),

              child: const Icon(Icons.shopping_cart),
            ),

            label: 'Cart',
          ),

          const NavigationDestination(
            icon: Icon(Icons.person_outline),

            selectedIcon: Icon(Icons.person),

            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
