import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Registerview extends StatefulWidget {
  const Registerview({super.key});

  @override
  State<Registerview> createState() => _RegisterviewState();
}

class _RegisterviewState extends State<Registerview> {
  final _gap = const SizedBox(height: 14,);

  final _emailController =TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();
  final _confirmpasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex:1,
              child: ClipRRect(
                child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(125),
                        bottomLeft:Radius.circular(125),
                      ),
                      color: Color.fromARGB(199, 181, 181, 183),
                    ),
                    child: Center(
                      child: SizedBox(
                        width: double.infinity,
                        height: 200,
                        child: Image.asset(
                          'assets/images/image1.png',
                          fit: BoxFit.contain,
                          ),
                      ),
                    ),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Expanded(
              flex: 2,
              child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                    color: Color.fromARGB(255, 220, 210, 209),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text(
                          'Register',
                          style: GoogleFonts.junge(
                              fontSize: 38,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          _gap,
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            hintText: 'abc@gmail.com',
                            hintStyle: const TextStyle(
                              color:Color.fromARGB(255, 162, 158, 158),
                            ),
                            border:OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ), 
                            ),
                        ),
                        _gap,
                        TextFormField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                            labelText: 'Username',
                            hintText: 'abc',
                            hintStyle: const TextStyle(
                              color:Color.fromARGB(255, 162, 158, 158),
                            ),
                            border:OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ), 
                            ),
                        ),
                        _gap,
                        TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            hintText: '********',
                            hintStyle: const TextStyle(
                              color:Color.fromARGB(255, 162, 158, 158),
                            ),
                            border:OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ), 
                            ),
                        ),
                        _gap,
                        TextFormField(
                          controller: _confirmpasswordController,
                          decoration: InputDecoration(
                            labelText: 'Confirm Password',
                            hintText: '********',
                            hintStyle: const TextStyle(
                              color:Color.fromARGB(255, 162, 158, 158),
                            ),
                            border:OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ), 
                            ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.symmetric(vertical: 6),
                          ),
                            onPressed: () {}, 
                            child: Text(
                              'Sign In',
                              style: GoogleFonts.inter(
                                fontSize: 30,
                                fontWeight: FontWeight.w300,
                                color: Colors.white,
                              ),
                              ),
                            ),
                        ),
                        _gap,
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Already have an account? ",
                                style: TextStyle(color: Colors.grey.shade800),
                              ),
                              const Text(
                                "Sign In",
                                style: TextStyle(color: Colors.blue),
                              )
                            ],
                          ),
                      ],
                    ),
                  ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}