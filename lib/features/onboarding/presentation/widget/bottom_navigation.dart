import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voyagevue/features/auth/presentation/view/loginview.dart';
import 'package:voyagevue/features/onboarding/presentation/view_model/bloc/onboarding_bloc.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final PageController controller;

  const CustomBottomNavigationBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    // Add a listener to the PageController
    controller.addListener(() {
      final currentIndex = controller.page?.round() ?? 0;
      context.read<OnboardingBloc>().updateCurrentIndex(currentIndex);
    });

    return Container(
      color: const Color.fromARGB(255, 219, 222, 239),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      height: 100, // Adjusted height for spacing
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Page Indicators
          BlocBuilder<OnboardingBloc, OnboardingState>(
            builder: (context, state) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(state.onboardingItems.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      controller
                          .jumpToPage(index); // Navigate to the selected page
                      context
                          .read<OnboardingBloc>()
                          .updateCurrentIndex(index); // Update current index
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: state.currentIndex == index
                            ? const Color.fromARGB(
                                255, 91, 119, 140) // Active color
                            : const Color.fromARGB(
                                255, 247, 246, 246), // Inactive color
                      ),
                    ),
                  );
                }),
              );
            },
          ),
          const SizedBox(height: 15), // Spacing between indicators and button

          // Next or Get Started Button
          BlocBuilder<OnboardingBloc, OnboardingState>(
            builder: (context, state) {
              return ElevatedButton(
                onPressed: () {
                  if (state.currentIndex == state.onboardingItems.length - 1) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginView(),
                      ),
                    );
                  } else {
                    controller.nextPage(
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  state.currentIndex == state.onboardingItems.length - 1
                      ? "Get Started"
                      : "Next",
                  style:
                      const TextStyle(fontSize: 18, color: Color(0xFFFCF5D7)),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
