import 'package:flutter/material.dart';
import 'package:voyagevue/view/dashboardview.dart';
import 'package:voyagevue/view/registerview.dart';

class Loginview extends StatefulWidget {
  const Loginview({super.key});

  @override
  State<Loginview> createState() => _LoginviewState();
}

class _LoginviewState extends State<Loginview> {
  final _gap = const SizedBox(height: 20);
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _errorMessage;
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Logo Section
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                width: double.infinity,
                color:Colors.white,
                child: Image.asset('assets/images/image.png',
                fit: BoxFit.cover,
                ),
              ),
              // Login Form Section
              Container(
                height: MediaQuery.of(context).size.height * 0.6,
                width: double.infinity,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            const SizedBox(height: 60),
                            // Email Field
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
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter an email';
                                }
                                if (!RegExp(
                                        r'^[a-zA-Z0-9._%+-]+@[a-z0-9.-]+\.[a-zA-Z]{2,}$')
                                    .hasMatch(value)) {
                                  return 'Please enter a valid email';
                                }
                                return null;
                              },
                            ),
                            _gap,
                            // Password Field
                            TextFormField(
                              controller: _passwordController,
                              obscureText: !_isPasswordVisible,
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
                                    _isPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isPasswordVisible = !_isPasswordVisible;
                                    });
                                  },
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a password';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 10),
                            // Error Message
                            if (_errorMessage != null)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20.0),
                                child: Text(
                                  _errorMessage!,
                                  style: const TextStyle(
                                      color: Colors.red, fontSize: 14),
                                ),
                              ),
                            const SizedBox(height: 2),
                            // Forgot Password
                            Align(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                onTap: () {
                                  // Add Forgot Password Navigation
                                },
                                child: const Text(
                                  "Forgot password?",
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ),
                            ),
                            _gap,
                            // Login Button
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: _login,
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  backgroundColor: const Color.fromARGB(255, 101, 177, 240),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 6),
                                ),
                                child: const Text(
                                  'Log In',
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
                    ],
                  ),
                ),
              ),
              // Divider and Signup Link
              Container(
                height: 1,
                color: Colors.grey.shade400,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account?",
                    style: TextStyle(fontFamily: 'Inter', color: Colors.black),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Registerview()),
                      );
                    },
                    child: const Text(
                      'Sign up',
                      style: TextStyle(fontFamily: 'Inter', color: Colors.blue),
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

  void _login() {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text;
      final password = _passwordController.text;

      // Check if the email and password match the registered credentials
      if (email == RegisterviewState.registeredEmail &&
          password == RegisterviewState.registeredPassword) {
        print('Login successful');
        _errorMessage = null; // Clear previous errors

        // Navigate to the HomePageView after successful login
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Dashboardview()),
        );
      } else {
        setState(() {
          _errorMessage = 'Invalid email or password. Please try again.';
        });
      }
    }
  }
}
