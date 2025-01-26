import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voyagevue/app/di/di.dart';
import 'package:voyagevue/features/auth/domain/usecase/login_usecase.dart';
import 'package:voyagevue/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:voyagevue/features/auth/presentation/view_model/register/register_bloc.dart';
import 'package:voyagevue/features/home/presentation/view_model/home_cubit.dart';
import 'package:voyagevue/features/onboarding/domain/usecase/onboarding_usecase.dart';
import 'package:voyagevue/features/onboarding/presentation/view_model/bloc/onboarding_bloc.dart';
import 'package:voyagevue/features/onboarding/presentation/widget/bottom_navigation.dart';
import 'package:voyagevue/features/onboarding/presentation/widget/build_image_container.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => OnboardingBloc(GetOnboardingData()),
        ),
        BlocProvider(
          create: (context) => LoginBloc(
            loginUseCase: getIt<LoginUseCase>(),
            registerBloc: getIt<RegisterBloc>(),
            homeCubit: getIt<HomeCubit>(),
          ),
        ),
      ],
      child: const OnboardingScreen(),
    );
  }
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  OnboardingScreenState createState() => OnboardingScreenState();
}

class OnboardingScreenState extends State<OnboardingScreen> {
  final PageController controller = PageController();

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<OnboardingBloc, OnboardingState>(
        builder: (context, state) {
          return PageView(
            controller: controller,
            onPageChanged: (index) {},
            children: state.onboardingItems.map((item) {
              return buildImageContainer(
                context,
                const Color.fromARGB(255, 219, 222, 239),
                item.title,
                item.description,
                item.image,
              );
            }).toList(),
          );
        },
      ),
      bottomSheet: CustomBottomNavigationBar(controller: controller),
    );
  }
}
