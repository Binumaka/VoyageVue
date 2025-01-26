import 'package:voyagevue/features/onboarding/domain/entity/onboarding_entity.dart';

class GetOnboardingData {
  List<OnboardingEntity> call() {
    return [
      OnboardingEntity(
        image: "assets/images/onboarding3.png",
        title: "Visit your Dream Destination",
        description: "Lets view the world together with more joy.",
      ),
      OnboardingEntity(
        image: "assets/images/onboarding1.png",
        title: "Stay informed and inspired.",
        description:
            "Get the latest updates, travel tips, and exclusive offers directly in the app.",
      ),
      OnboardingEntity(
        image: "assets/images/onboarding2.png",
        title: "Adventure is out there!",
        description:
            "Uncover hidden gems and iconic destinations tailored to your preferences.",
      ),
    ];
  }
}
