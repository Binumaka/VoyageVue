import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voyagevue/features/auth/presentation/view_model/register/register_bloc.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => RegisterViewState();
}

class RegisterViewState extends State<RegisterView> {
  final _gap = const SizedBox(height: 18);
  final _key = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: double.infinity,
                  color: Colors.white,
                  child: Image.asset(
                    'assets/images/Journey-bro.png',
                    fit: BoxFit.contain,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Form(
                    key: _key,
                    child: Column(
                      children: [
                        const Text(
                          'Register',
                          style: TextStyle(
                            fontFamily: 'Junge',
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        _gap,
                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            prefixIcon:
                                const Icon(Icons.email, color: Colors.black),
                            labelText: 'Email',
                            hintText: 'John@gmail.com',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter email';
                            }
                            return null;
                          },
                        ),
                        _gap,
                        TextFormField(
                          controller: usernameController,
                          decoration: InputDecoration(
                            prefixIcon:
                                const Icon(Icons.person, color: Colors.black),
                            labelText: 'Username',
                            hintText: 'Doe',
                            hintStyle: const TextStyle(
                              color: Color.fromARGB(255, 162, 158, 158),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter username';
                            }
                            return null;
                          },
                        ),
                        _gap,
                        TextFormField(
                          controller: passwordController,
                          obscureText: !isPasswordVisible,
                          decoration: InputDecoration(
                            prefixIcon:
                                const Icon(Icons.lock, color: Colors.black),
                            labelText: 'Password',
                            hintText: '********',
                            hintStyle: const TextStyle(
                              color: Color.fromARGB(255, 162, 158, 158),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  isPasswordVisible = !isPasswordVisible;
                                });
                              },
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter password';
                            }
                            return null;
                          },
                        ),
                        _gap,
                        TextFormField(
                          controller: confirmpasswordController,
                          obscureText: !isConfirmPasswordVisible,
                          decoration: InputDecoration(
                            prefixIcon:
                                const Icon(Icons.lock, color: Colors.black),
                            labelText: 'Confirm Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(isConfirmPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  isConfirmPasswordVisible =
                                      !isConfirmPasswordVisible;
                                });
                              },
                            ),
                            errorText: _errorMessage,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please confirm your password';
                            } else if (value != passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                        ),
                        _gap,
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              if (_key.currentState!.validate()) {
                                final registerState =
                                    context.read<RegisterBloc>().state;
                                final imageName = registerState.imageName;
                                context.read<RegisterBloc>().add(
                                      RegisterUser(
                                        context: context,
                                        email: emailController.text,
                                        username: usernameController.text,
                                        password: passwordController.text,
                                        confirmPassword:
                                            confirmpasswordController.text,
                                        image: imageName,
                                      ),
                                    );
                              }
                            },
                            child: const Text('Sign Up'),
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
                    const Text(
                      "Already have an account? ",
                      style: TextStyle(
                        fontFamily: 'Inter',
                        color: Colors.black,
                      ),
                    ),
                    InkWell(
                      key: const ValueKey('loginButton'),
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Sign In',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          color: Colors.blue,
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
