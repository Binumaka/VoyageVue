import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voyagevue/app/di/di.dart';
import 'package:voyagevue/core/theme/app_theme.dart';
import 'package:voyagevue/features/accommodation/presentation/view_model/bloc/accommodation_bloc.dart';
import 'package:voyagevue/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:voyagevue/features/auth/presentation/view_model/register/register_bloc.dart';
import 'package:voyagevue/features/destination/presentation/view_model/bloc/destination_bloc.dart';
import 'package:voyagevue/features/guide/presentation/view_model/bloc/guide_bloc.dart';
import 'package:voyagevue/features/splash/presentation/view/splash_view.dart';
import 'package:voyagevue/features/splash/presentation/view_model/splash_cubit.dart';
import 'package:voyagevue/profile/presentation/view_model/bloc/profile_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<LoginBloc>(), // Providing LoginBloc
        ),
        BlocProvider(
          create: (_) => getIt<RegisterBloc>(), // Provide RegisterBloc
        ),
        BlocProvider(
          create: (_) => getIt<DestinationBloc>(), // Provide DestiantionBloc
        ),
        BlocProvider(
          create: (_) => getIt<ProfileBloc>(), // Provide ProfileBloc
        ),
        BlocProvider(
          create: (_) =>
              getIt<AccommodationBloc>(), // Provide AccommodationBloc
        ),
        BlocProvider(
          create: (_) =>
              getIt<GuideBloc>(), // Provide guide Bloc
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'VoyageVue',
        theme: AppTheme.getApplicationTheme(isDarkMode: false),
        home: BlocProvider.value(
          value: getIt<SplashCubit>(),
          child: SplashView(),
        ),
      ),
    );
  }
}
