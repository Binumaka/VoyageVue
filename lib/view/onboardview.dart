import 'package:flutter/material.dart';
import 'package:voyagevue/view/loginview.dart';

class Onboardview extends StatefulWidget {
  const Onboardview({super.key});

  @override
  _OnboardviewState createState() => _OnboardviewState();
}

class _OnboardviewState extends State<Onboardview> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _onboardingData = [
    {
      "image": "assets/images/onboarding3.png",
      "title": "Visit your Dream Destination",
      "description": "Lets view the world together with more joy."
    },
    {
      "image": "assets/images/onboarding1.png",
      "title": "Stay informed and inspired.",
      "description":
          "Get the latest updates, travel tips, and exclusive offers directly in the app."
    },
    {
      "image": "assets/images/onboarding2.png",
      "title": "Adventure is out there!",
      "description":
          "Uncover hidden gems and iconic destinations tailored to your preferences."
    },
  ];

  void _nextPage() {
    if (_currentPage < _onboardingData.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Loginview()),
      );
    }
  }

  void _goToPage(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: _onboardingData.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  // Image container covering half the screen
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(_onboardingData[index]["image"]!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  // Text content
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 100),
                          child: Text(
                            _onboardingData[index]["title"]!,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Text(
                            _onboardingData[index]["description"]!,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _onboardingData.length,
                    (index) => GestureDetector(
                      onTap: () => _goToPage(index),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        height: 10,
                        width: _currentPage == index ? 20 : 10,
                        decoration: BoxDecoration(
                          color: _currentPage == index
                              ? Colors.blue
                              : const Color.fromARGB(255, 241, 239, 239),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _nextPage,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15),
                  ),
                  child: Text(
                    _currentPage == _onboardingData.length - 1
                        ? "Get Started"
                        : "Next",
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
