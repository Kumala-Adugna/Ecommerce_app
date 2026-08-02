import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/presentation/providers/auth_provider.dart';
import '../features/auth/presentation/providers/auth_state.dart';

import '../features/auth/presentation/screens/login_screen.dart';
import '../features/auth/presentation/screens/splash_screen.dart';

import '../features/cart/presentation/screens/cart_screen.dart';
import '../features/products/presentation/screens/home_screen.dart';
import '../features/profile/presentation/screens/profile_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',

    redirect: (context, state) {
      final authState = ref.read(authProvider);

      final isLoggedIn =
          authState.status == AuthStatus.authenticated;

      final isGoingToLogin =
          state.matchedLocation == '/login';

      final isGoingToSplash =
          state.matchedLocation == '/';

      if (!isLoggedIn &&
          !isGoingToLogin &&
          !isGoingToSplash) {
        return '/login';
      }

      if (isLoggedIn &&
          (isGoingToLogin || isGoingToSplash)) {
        return '/home';
      }

      return null;
    },

    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/cart',
        builder: (context, state) => const CartScreen(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileScreen(),
      ),
    ],
  );
});