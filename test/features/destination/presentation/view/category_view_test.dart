import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voyagevue/features/destination/domain/entity/destination_entity.dart';
import 'package:voyagevue/features/destination/presentation/view/category_view.dart';
import 'package:voyagevue/features/destination/presentation/view_model/bloc/destination_bloc.dart';

class MockDestinationBloc extends Mock implements DestinationBloc {}

class FakeDestinationState extends Fake implements DestinationState {}

class FakeDestinationEntity extends Fake implements DestinationEntity {}

void main() {
  late MockDestinationBloc mockDestinationBloc;

  setUpAll(() {
    registerFallbackValue(FakeDestinationState());
    registerFallbackValue(FakeDestinationEntity());
  });

  setUp(() {
    mockDestinationBloc = MockDestinationBloc();
  });

  Widget createTestWidget() {
    return MaterialApp(
      home: BlocProvider<DestinationBloc>.value(
        value: mockDestinationBloc,
        child: const CategoryDestinationsPage(category: 'Beach'),
      ),
    );
  }

  testWidgets('displays loading indicator when loading', (WidgetTester tester) async {

    await tester.pumpWidget(createTestWidget());
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('displays error message when error occurs', (WidgetTester tester) async {

    await tester.pumpWidget(createTestWidget());
    expect(find.textContaining('Failed to load destinations'), findsOneWidget);
  });

  testWidgets('displays empty state message when no destinations found', (WidgetTester tester) async {

    await tester.pumpWidget(createTestWidget());
    expect(find.textContaining('No destinations found for Beach'), findsOneWidget);
  });

  testWidgets('displays destinations when loaded successfully', (WidgetTester tester) async {

    await tester.pumpWidget(createTestWidget());
    expect(find.text('Maldives'), findsOneWidget);
    expect(find.text('Bali'), findsOneWidget);
  });
}
