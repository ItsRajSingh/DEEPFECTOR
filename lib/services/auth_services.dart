import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_flutter_app/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  // Create a single instance of GoogleSignIn
  final GoogleSignIn googleSignIn = GoogleSignIn();

  // Google Sign In 
  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      // Begin the interactive sign-in process
      await googleSignIn.signOut();
      final GoogleSignInAccount? gUser = await googleSignIn.signIn();

      // Check if the user canceled the sign-in
      if (gUser == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Google sign-in canceled')),
        );
        return; // Exit if the sign-in was canceled
      }

      // Obtain auth details from the request 
      final GoogleSignInAuthentication gAuth = await gUser.authentication;

      // Create a new credential for the user
      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      // Finally, let's sign in 
      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      
      // Navigate to home if sign-in was successful
      if (userCredential.user != null) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MovieListView()));
      }
    } catch (e) {
      // Handle errors during the sign-in process
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign-in failed: $e')),
      );
    }
  }
}
