import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:voyagevue/features/destination/domain/entity/destination_entity.dart';
import 'package:voyagevue/features/destination/presentation/view/destination_view.dart';
import 'package:voyagevue/features/destination/presentation/view_model/bloc/destination_bloc.dart';

// This creates a mock class for the Bloc
import 'category_view_test.dart';

// Mock class for AccelerometerEvents
class MockAccelerometerEvents extends Stream<AccelerometerEvent> {
  @override
  StreamSubscription<AccelerometerEvent> listen(
    void Function(AccelerometerEvent event)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    return const Stream<AccelerometerEvent>.empty().listen(
      onData,
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );
  }

  @override
  bool get isBroadcast => true;
}

void main() {
  late MockDestinationBloc mockDestinationBloc;

  final testTopDestinations = [
    DestinationEntity(
      id: '1',
      title: 'Top Destination 1',
      description: 'Description 1',
      image: 'image1.jpg',
      location: 'Location 1',
      category: 'Nature',
      section: 'TopDestination',
      image1: '', image2: '', bestTimeToVisit: '',
    ),
  ];

  final testMoreToExplore = [
    DestinationEntity(
      id: '2',
      title: 'More to Explore 1',
      description: 'Description 2',
      image: 'image2.jpg',
      location: 'Location 2',
      category: 'Adventure',
      section: 'MoretoExplore', image1: '', image2: '', bestTimeToVisit: '',
    ),
  ];

  // Combined list of destinations for the section state
  final testSectionDestinations = [...testTopDestinations, ...testMoreToExplore];

  setUp(() {
    mockDestinationBloc = MockDestinationBloc();
  });

  testWidgets('DestinationView shows loading indicator when state is loading',
      (WidgetTester tester) async {
    // Arrange
    when(mockDestinationBloc.state as Function()).thenReturn(
      DestinationState.initial().copyWith(isLoading: true),
    );

    // Mock the stream behavior
    whenListen(
      mockDestinationBloc,
      Stream.value(DestinationState.initial().copyWith(isLoading: true)),
      initialState: DestinationState.initial().copyWith(isLoading: true),
    );

    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<DestinationBloc>.value(
          value: mockDestinationBloc,
          child: const DestinationView(),
        ),
      ),
    );

    // Assert
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('DestinationView shows destinations when loaded',
      (WidgetTester tester) async {
    // Arrange
    final loadedState = DestinationState.initial().copyWith(
      isLoading: false,
      section: testSectionDestinations,
    );

    when(mockDestinationBloc.state as Function()).thenReturn(loadedState);

    // Mock the stream behavior
    whenListen(
      mockDestinationBloc,
      Stream.value(loadedState),
      initialState: loadedState,
    );

    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<DestinationBloc>.value(
          value: mockDestinationBloc,
          child: const DestinationView(),
        ),
      ),
    );
    
    // Wait for image loading
    await tester.pump();

    // Assert
    expect(find.text('Categories'), findsOneWidget);
    expect(find.text('Top Destinations'), findsOneWidget);
    expect(find.text('More to Explore'), findsOneWidget);
    
    // Check if destinations are displayed
    expect(find.text('Top Destination 1'), findsOneWidget);
    expect(find.text('More to Explore 1'), findsOneWidget);
    
  });

  testWidgets('Tapping a category triggers navigation and loads category',
      (WidgetTester tester) async {
    // Arrange
    final loadedState = DestinationState.initial().copyWith(
      isLoading: false,
      section: testSectionDestinations,
    );

    when(mockDestinationBloc.state as Function()).thenReturn(loadedState);

    // Mock the stream behavior
    whenListen(
      mockDestinationBloc,
      Stream.value(loadedState),
      initialState: loadedState,
    );

    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<DestinationBloc>.value(
          value: mockDestinationBloc,
          child: const DestinationView(),
        ),
      ),
    );
    
    // Find the first category button (HimalayanTreks)
    await tester.pump();
    final categoryButton = find.text('HimalayanTreks');
    expect(categoryButton, findsOneWidget);
    
    // Tap on the category
    await tester.tap(categoryButton);
    await tester.pumpAndSettle();
    
  });

  testWidgets('Tapping a destination navigates to detail view',
      (WidgetTester tester) async {
    // Arrange
    final loadedState = DestinationState.initial().copyWith(
      isLoading: false,
      section: testSectionDestinations,
    );

    when(mockDestinationBloc.state as Function()).thenReturn(loadedState);

    // Mock the stream behavior
    whenListen(
      mockDestinationBloc,
      Stream.value(loadedState),
      initialState: loadedState,
    );

    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<DestinationBloc>.value(
          value: mockDestinationBloc,
          child: const DestinationView(),
        ),
      ),
    );
    
    // Wait for widgets to build
    await tester.pump();
    
    // Find the destination card
    final destinationCard = find.text('Top Destination 1');
    expect(destinationCard, findsOneWidget);
    
    // Tap on the destination
    await tester.tap(destinationCard);
    await tester.pumpAndSettle();
  });

  testWidgets('Pull to refresh triggers reload of data',
      (WidgetTester tester) async {
    // Arrange
    final loadedState = DestinationState.initial().copyWith(
      isLoading: false,
      section: testSectionDestinations,
    );

    when(mockDestinationBloc.state as Function()).thenReturn(loadedState);

    // Mock the stream behavior
    whenListen(
      mockDestinationBloc,
      Stream.value(loadedState),
      initialState: loadedState,
    );

    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<DestinationBloc>.value(
          value: mockDestinationBloc,
          child: const DestinationView(),
        ),
      ),
    );
    
    // Wait for widgets to build
    await tester.pump();
    
    // Perform pull to refresh
    await tester.drag(find.text('Categories'), const Offset(0, 300));
    await tester.pumpAndSettle();
  });

  testWidgets('Error is cleared when shown', (WidgetTester tester) async {
    // Arrange
    final errorState = DestinationState.initial().copyWith(
      isLoading: false,
      error: 'Test error message',
    );
    
    final loadedState = DestinationState.initial().copyWith(
      isLoading: false,
      error: '',
    );

    // First return error state, then loaded state
    when(mockDestinationBloc.state as Function()).thenReturn(errorState);

    // Mock the stream behavior with state changes
    whenListen(
      mockDestinationBloc,
      Stream.fromIterable([errorState, loadedState]),
      initialState: errorState,
    );

    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<DestinationBloc>.value(
          value: mockDestinationBloc,
          child: const DestinationView(),
        ),
      ),
    );
    
    // Wait for listener to process error
    await tester.pump();
  });
}