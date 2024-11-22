import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_flutter_app/pages/login_page.dart';
import 'package:first_flutter_app/pages/home.dart';
import 'package:flutter/material.dart';

import 'login_or_register.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          //user logged in
          if(snapshot.hasData){
            return MovieListView();

          }
          else{
            return const LoginOrRegisterPage();
          }

          //user Not logged in
        }
      )
    );
  }
}
