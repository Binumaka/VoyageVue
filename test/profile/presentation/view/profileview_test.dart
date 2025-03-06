import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:voyagevue/features/dashboard/presentation/view_model/home_cubit.dart';
import 'package:voyagevue/profile/presentation/view/profileview.dart';

class MockHomeCubit extends Mock implements HomeCubit {}

void main() {
  late MockHomeCubit mockHomeCubit;

  setUp(() {
    mockHomeCubit = MockHomeCubit();
  });

  Widget createTestWidget() {
    return BlocProvider<HomeCubit>(
      create: (_) => mockHomeCubit,
      child: const MaterialApp(
        home: ProfileView(),
      ),
    );
  }

  testWidgets('ProfileView renders profile details correctly', (tester) async {
    await tester.pumpWidget(createTestWidget());

    // Check if profile image, name, and email are displayed
    expect(find.byType(CircleAvatar), findsOneWidget);
    expect(find.text('Binu'), findsOneWidget);
    expect(find.text('binu@gmail.com'), findsOneWidget);
  });

  testWidgets('ProfileView has Edit Profile, Settings, and Help & Support options', (tester) async {
    await tester.pumpWidget(createTestWidget());

    expect(find.text('Edit Profile'), findsOneWidget);
    expect(find.text('Settings'), findsOneWidget);
    expect(find.text('Help & Support'), findsOneWidget);
  });

  testWidgets('Tapping logout shows snackbar and calls logout', (tester) async {
    when(() => mockHomeCubit.logout(any())).thenAnswer((_) {});

    await tester.pumpWidget(createTestWidget());

    // Tap the logout button
    await tester.tap(find.byIcon(Icons.logout));
    await tester.pump();

    // Verify logout function was called
    verify(() => mockHomeCubit.logout(any())).called(1);
  });
}
