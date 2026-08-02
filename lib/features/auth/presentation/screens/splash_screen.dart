import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/storage/storage_provider.dart';


class SplashScreen extends ConsumerStatefulWidget {

  const SplashScreen({super.key});


  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();

}



class _SplashScreenState extends ConsumerState<SplashScreen> {


  @override
  void initState() {

    super.initState();

    _checkAuthentication();

  }



  Future<void> _checkAuthentication() async {


    await Future.delayed(
      const Duration(seconds: 2),
    );


    final storage = ref.read(localStorageProvider);


    if (storage.isLoggedIn()) {

      if (!mounted) return;

      context.go('/home');

    } 
    else {

      if (!mounted) return;

      context.go('/login');

    }

  }



  @override
  Widget build(BuildContext context) {

    return const Scaffold(

      body: Center(

        child: CircularProgressIndicator(),

      ),

    );

  }

}