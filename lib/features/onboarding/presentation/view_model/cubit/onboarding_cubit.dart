import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voyagevue/features/auth/presentation/view/loginview.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(OnboardingInitial());

  final PageController pageController = PageController();
  int currentPage = 0;

  final List<Map<String, String>> onboardingData = [
    {
      "title": "Visit your Dream Destination",
      "subtitle": "Let's view the world together with more joy.",
      "image": "assets/images/onboarding3.png",
    },
    {
      "title": "Stay informed and inspired.",
      "subtitle": "Get the latest updates, travel tips, and exclusive offers directly in the app.",
      "image": "assets/images/onboarding1.png",
    },
    {
      "title": "Adventure is out there!",
      "subtitle": "Uncover hidden gems and iconic destinations tailored to your preferences.",
      "image": "assets/images/onboarding2.png",
    },
  ];

  void onPageChanged(int page) {
    currentPage = page;
    emit(OnboardingPageChanged(page));
  }

  void nextPage() {
    if (currentPage < onboardingData.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      );
    }
  }

  void goToPage(int index) {
    // This function allows jumping directly to a specific page when a dot is clicked
    if (index >= 0 && index < onboardingData.length) {
      pageController.jumpToPage(index);
      currentPage = index;
      emit(OnboardingPageChanged(index));
    }
  }

  VoidCallback goToRegisterView(BuildContext context) {
    return () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginView(),
        ),
      );
    };
  }
}

abstract class OnboardingState {}

class OnboardingInitial extends OnboardingState {}

class OnboardingPageChanged extends OnboardingState {
  final int page;
  OnboardingPageChanged(this.page);
}
