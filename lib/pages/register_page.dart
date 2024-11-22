import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_flutter_app/components/my_button.dart';
import 'package:first_flutter_app/components/my_textfield.dart';
import 'package:first_flutter_app/components/square_tile.dart';
import 'package:first_flutter_app/services/auth_services.dart';
import 'package:flutter/material.dart';
class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key,required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  void signUserUp() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    //try creating the account
    try {
      if(passwordController.text == confirmpasswordController.text)
        {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
          );
        }else{
        //show error message , passwords don't match
        if (passwordController.text != confirmpasswordController.text) {
          Navigator.pop(context);
          showErrorMessage("Passwords do not match");
          return;
        }


      }
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showErrorMessage(e.code);
      return;
    }



  }
  //Error Message popup
  void showErrorMessage(String message){
    showDialog(
        context: context,
        builder:(context) {
          return AlertDialog(
            backgroundColor: Colors.blueAccent.shade100,
              title : Text(message, style: const TextStyle(fontWeight: FontWeight.bold) ,),


          );
        }
    );
  }
  //text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(//Makes scrollable page
          child: Column(
            children: [
              const SizedBox(height: 50),
              const Icon(Icons.lock,size: 50,),
              const Text("DEEPFECTOR",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 39)),
              const SizedBox(height: 50),
              Text(
                'Let\'s create an account for you real quick',
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
              MyTextfield(
                controller: confirmpasswordController,
                hintText: 'Confirm Password',
                obscureText: true,
              ),

              const SizedBox(height: 10),
              MyButton(
                onTap: signUserUp,
                text: "Sign Up",
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
                  SquareTile(onTap:() async{await AuthService().signInWithGoogle(context); },
                  imagePath:  'lib/images/google.png'),
                  const SizedBox(width: 10),
                  SquareTile(onTap:() {},
                  imagePath: 'lib/images/apple.png'),
                ],
              ),
              const SizedBox(height: 50),
              Row(
                children: [
                  const Text("Already have an account!"),
                  const SizedBox(width: 2),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      "Login now",
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
