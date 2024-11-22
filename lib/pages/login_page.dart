import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_flutter_app/components/my_button.dart';
import 'package:first_flutter_app/components/my_textfield.dart';
import 'package:first_flutter_app/components/square_tile.dart';
import 'package:first_flutter_app/pages/home.dart';
import 'package:first_flutter_app/pages/login_or_register.dart';
import 'package:first_flutter_app/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key,required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
void signUserIn() async {
  // Show loading indicator
  showDialog(
    context: context,
    builder: (context) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    },
  );

  try {
    // Attempt to sign in
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    );

    // Close the loading indicator
    Navigator.pop(context);

    // Navigate to the home page
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => MovieListView()),
    );
  } on FirebaseAuthException catch (e) {
    // Close the loading indicator
    Navigator.pop(context);

    // Handle specific error codes
    if (e.code == 'user-not-found') {
      showErrorDialog('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      showErrorDialog('Wrong password provided.');
    } else {
      showErrorDialog('An error occurred. Please try again.');
    }
  } catch (e) {
    // Close the loading indicator
    Navigator.pop(context);

    // Handle any other errors
    showErrorDialog('An unexpected error occurred. Please try again.');
  }
}

// Function to show error dialog
void showErrorDialog(String message) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}

  //wrong email message popup
  void wrongEmailMessage(){
    showDialog(
      context: context,
      builder:(context) {
        return const AlertDialog(
          title : Text("Incorrect Email")
        );
      }
    );
  }
  //wrong password message popup
  void wrongPasswordMessage(){
    showDialog(
        context: context,
        builder:(context) {
          return const AlertDialog(
              title : Text("Incorrect Password")
          );
        }
    );
  }
  //text editing controllers
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: SingleChildScrollView(//Makes scrollable page
          child: Column(
            children: [
              const SizedBox(height: 50),
              const Icon(Icons.search,size: 100,),
              const Text("DEEPFECTOR",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 39)),
              const SizedBox(height: 50),
              Text(
                'Welcome back you\'ve been missed!',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 25),
              MyTextfield(
                controller: emailController,
                hintText: 'email@gmail.com',
                obscureText: false,
              ),
              const SizedBox(height: 10),
              MyTextfield(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'forgot password?',
                      style: TextStyle(color: Colors.grey[500]),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              MyButton(
                onTap: signUserIn,
                text: "Sign In",
              ),
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 5,
                        color: Colors.grey[400],
                      ),
                    ),
                    const Text("Or continue with"),
                    Expanded(
                      child: Divider(
                        thickness: 5,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SquareTile(onTap: () => AuthService().signInWithGoogle(context),
                  imagePath: 'lib/images/google.png'),
                  const SizedBox(width: 10),
                  SquareTile(onTap: () => {}
                  ,imagePath: 'lib/images/apple.png'),
                ],
              ),
              const SizedBox(height: 50),
              Row(
                children: [
                  const Text("Not a member!"),
                  const SizedBox(width: 2),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      "Register now",
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
