import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:voyagevue/features/auth/presentation/view/loginview.dart';
import 'package:voyagevue/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:voyagevue/features/onboarding/presentation/view/onboarding_view.dart';
class SplashCubit extends Cubit<void> {
  SplashCubit(this._loginbloc) : super(null);

  final LoginBloc _loginbloc;

  Future<void> init(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 5), () async {
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider.value(
              value: _loginbloc,
              child: OnboardingView(),
            ),
          ),
        );
      }
    });
  }
}
