import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Loginview extends StatefulWidget {
  const Loginview({super.key});

  @override
  State<Loginview> createState() => _LoginviewState();
}

class _LoginviewState extends State<Loginview> {
  final _gap = const SizedBox(height: 30,);

  final _emailController =TextEditingController();
  final _passwordController = TextEditingController();

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
              height: 10,
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
                          'LOGIN',
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
                            labelText: 'Enter email',
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
                          controller: _passwordController,
                          decoration: InputDecoration(
                            labelText: 'Enter password',
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
                            height: 5,
                          ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "Forget password?",
                            style: TextStyle(color: Colors.grey.shade800),
                          ),
                        ),
                        _gap,
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
                                "Are you new? Create an account ",
                                style: TextStyle(color: Colors.grey.shade800),
                              ),
                              const Text(
                                "Sign up",
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