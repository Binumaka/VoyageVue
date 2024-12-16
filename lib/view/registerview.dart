import 'package:flutter/material.dart';
import 'package:voyagevue/view/loginview.dart';

class Registerview extends StatefulWidget {
  const Registerview({super.key});

  @override
  State<Registerview> createState() => RegisterviewState();
}

class RegisterviewState extends State<Registerview> {
  final _gap = const SizedBox(height: 20);

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();
  final _confirmpasswordController = TextEditingController();

  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  static String? registeredEmail;
  static String? registeredPassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, // This ensures the last part is at the bottom
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                width: double.infinity,
                color: Colors.white,
                child: Image.asset(
                  'assets/images/image.png',
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.6,
                width: double.infinity,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _gap,
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.email, color: Colors.black),
                          labelText: 'Email',
                          hintText: 'abc@gmail.com',
                          hintStyle: const TextStyle(
                            color: Color.fromARGB(255, 162, 158, 158),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      _gap,
                      TextFormField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.person, color: Colors.black),
                          labelText: 'Username',
                          hintText: 'abc',
                          hintStyle: const TextStyle(
                            color: Color.fromARGB(255, 162, 158, 158),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      _gap,
                      TextFormField(
                        controller: _passwordController,
                        obscureText: !isPasswordVisible,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock, color: Colors.black),
                          labelText: 'Password',
                          hintText: '********',
                          hintStyle: const TextStyle(
                            color: Color.fromARGB(255, 162, 158, 158),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                isPasswordVisible = !isPasswordVisible;
                              });
                            },
                          ),
                        ),
                      ),
                      _gap,
                      TextFormField(
                        controller: _confirmpasswordController,
                        obscureText: !isConfirmPasswordVisible,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock_clock, color: Colors.black),
                          labelText: 'Confirm Password',
                          hintText: '********',
                          hintStyle: const TextStyle(
                            color: Color.fromARGB(255, 162, 158, 158),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              isConfirmPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                isConfirmPasswordVisible =
                                    !isConfirmPasswordVisible;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: const Color.fromARGB(255, 93, 178, 247),
                            padding: const EdgeInsets.symmetric(vertical: 8),
                          ),
                          onPressed: () {
                            if (_passwordController.text ==
                                _confirmpasswordController.text) {
                              setState(() {
                                registeredEmail = _emailController.text;
                                registeredPassword = _passwordController.text;
                              });
                
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Registered successfully!')),
                              );
                              Future.delayed(const Duration(seconds: 1), () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Loginview(),
                                  ),
                                );
                              });
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Passwords do not match!')),
                              );
                            }
                          },
                          child: const Text(
                            'Register',
                            style: TextStyle(
                              fontFamily: 'Junge',
                              fontSize: 22,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 1,
                color: Colors.grey.shade400,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account?'),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Loginview()),
                      );
                    },
                    child: const Text(
                      'Sign In',
                      style: TextStyle(
                          fontFamily: 'Inter', color: Colors.blue),
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
