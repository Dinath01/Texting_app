import 'package:flutter/material.dart';
import 'package:text_app/components/button.dart';
import 'package:text_app/components/text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              children: [
                const SizedBox(height: 120),

                Icon(
                  Icons.messenger,
                  size: 100,
                ),

                const SizedBox(height: 10),

                Text(
                  "Welcome!",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Monument'),
                ),

                const SizedBox(height: 50),


                MyTextField(
                    controller: emailController,
                    hintText: "Email",
                    obscureText: false),
                
                const SizedBox(height: 3),

                MyTextField(
                    controller: passwordController,
                    hintText: "Password",
                    obscureText: true),
                
                const SizedBox(height: 25,),

                MyButton(onTap: (){}, text: "Sign Up"),

                const SizedBox(height: 25,),

                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Not a Member?', style: TextStyle(fontFamily: 'Monument'),),
                    SizedBox(width: 4),
                    Text('Register Now', style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Monument'),),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
