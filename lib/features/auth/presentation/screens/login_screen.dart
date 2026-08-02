import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/auth_provider.dart';
import '../providers/auth_state.dart';

class LoginScreen extends ConsumerStatefulWidget {

  const LoginScreen({super.key});


  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();

}



class _LoginScreenState extends ConsumerState<LoginScreen> {


  final usernameController = TextEditingController();

  final passwordController = TextEditingController();
    @override
  void initState() {
    super.initState();

    ref.listenManual(
      authProvider,
      (previous, next) {

        if (next.status == AuthStatus.authenticated) {

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Login Successful"),
            ),
          );


          context.go('/home');

        }


        if (next.status == AuthStatus.error) {

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                next.errorMessage ?? "Login failed",
              ),
            ),
          );

        }

      },
    );

  }



  @override
  Widget build(BuildContext context) {

    final authState = ref.watch(authProvider);
    
    return Scaffold(

      appBar: AppBar(
        title: const Text("Login"),
      ),


      body: Padding(

        padding: const EdgeInsets.all(20),

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,

          children: [


            TextField(

              controller: usernameController,

              decoration: const InputDecoration(
                labelText: "Username",
                border: OutlineInputBorder(),
              ),

            ),


            const SizedBox(height: 20),



            TextField(

              controller: passwordController,

              obscureText: true,

              decoration: const InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
              ),

            ),


            const SizedBox(height: 30),



            ElevatedButton(

              onPressed: authState.status == AuthStatus.loading
                  ? null
                  : () {

                ref
                    .read(authProvider.notifier)
                    .login(
                  email: usernameController.text,
                  password: passwordController.text,
                );

              },


              child: authState.status == AuthStatus.loading

                  ? const CircularProgressIndicator()

                  : const Text("Login"),

            )

          ],

        ),

      ),

    );

  }

}