import 'package:flutter/material.dart';
import 'package:shopping_exam/screens/home_screen.dart';

import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final email = TextEditingController();
  final pass = TextEditingController();
  bool obscure = true;
  final _formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    // bug 1
    // is not super to "pass"
    email.dispose();
    pass.dispose();
  }

  void _login() {
    // BUG 2 –
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Logged in (demo)')));

    if (_formkey.currentState!.validate()) {
      //  BUG 3
      // posh is to pop is to not seved to lest
      Navigator.pop(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFFDFEFF), Color(0xFFF6F7FB)],
          ),
        ),
        child: SafeArea(
          child: Form(
            key: _formkey,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              children: [
                const SizedBox(height: 30),

                // Email
                TextFormField(
                  controller: email,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    // BUG 4
                    if (value == null || value.isEmpty) {
                      return 'invalid email';
                    }
                    if (!value.contains('@gmail.com')) {
                      return 'invalid email';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.mail_outline),
                  ),
                ),

                const SizedBox(height: 12),

                // Password
                TextFormField(
                  controller: pass,
                  obscureText: obscure,
                  validator: (value) {
                    // BUG 5
                    if (value == null || value.isEmpty) {
                      return 'invalid email';
                    }
                    if (value.length < 8) {
                      return 'enter to password to 8';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscure
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                      ),
                      onPressed: () => setState(() => obscure = !obscure),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                SizedBox(
                  height: 48,
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      shape: const StadiumBorder(),
                      backgroundColor: const Color.fromARGB(255, 132, 134, 149),
                    ),
                    onPressed: _login,
                    child: const Text('Login'),
                  ),
                ),

                const SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?  "),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const SignupScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Register',
                        style: TextStyle(
                          color: Color(0xFF8A8DFF),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
