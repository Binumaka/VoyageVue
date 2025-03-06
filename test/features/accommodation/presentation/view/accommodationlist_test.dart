import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:voyagevue/features/accommodation/presentation/view/accommodationlist.dart';
import 'package:voyagevue/features/accommodation/presentation/view_model/bloc/accommodation_bloc.dart';

class MockAccommodationBloc extends Mock implements AccommodationBloc {}

void main() {
  late MockAccommodationBloc mockBloc;
  
  setUp(() {
    mockBloc = MockAccommodationBloc();
  });

  Widget createWidgetUnderTest({
    required AccommodationState state,
    String? selectedAccommodationId,
    Function(String?)? onSelectAccommodation,
  }) {
    when(mockBloc.state as Function()).thenReturn(state);

    return MaterialApp(
      home: Scaffold(
        body: BlocProvider<AccommodationBloc>.value(
          value: mockBloc,
          child: AccommodationListView(
            selectedAccommodationId: selectedAccommodationId,
            onSelectAccommodation: onSelectAccommodation ?? ((_) {}),
          ),
        ),
      ),
    );
  }

  group('AccommodationListView', () {
    testWidgets('shows loading indicator when isLoading is true', (WidgetTester tester) async {
      // Arrange
      final loadingState = AccommodationState(
        isLoading: true,
        accommodationsByDestination: [],
        error: '',
      );
      
      // Act
      await tester.pumpWidget(createWidgetUnderTest(state: loadingState));
      
      // Assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Available Accommodations'), findsNothing);
    });

    testWidgets('shows error message when error is not empty', (WidgetTester tester) async {
      // Arrange
      final errorState = AccommodationState(
        isLoading: false,
        accommodationsByDestination: [],
        error: 'Failed to load accommodations',
      );
      
      // Act
      await tester.pumpWidget(createWidgetUnderTest(state: errorState));
      
      // Assert
      expect(find.text('Error: Failed to load accommodations'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('shows empty state when no accommodations available', (WidgetTester tester) async {
      // Arrange
      final emptyState = AccommodationState(
        isLoading: false,
        accommodationsByDestination: [],
        error: '',
      );
      
      // Act
      await tester.pumpWidget(createWidgetUnderTest(state: emptyState));
      
      // Assert
      expect(find.text('No accommodations available'), findsOneWidget);
      expect(find.text('Try another destination or check back later'), findsOneWidget);
    });

    testWidgets('shows list of accommodations when data is available', (WidgetTester tester) async {
      // Arrange
      var testAccommodations;
      final loadedState = AccommodationState(
        isLoading: false,
        accommodationsByDestination: testAccommodations,
        error: '',
      );
      
      // Act
      await tester.pumpWidget(createWidgetUnderTest(state: loadedState));
      
      // Assert
      expect(find.text('Available Accommodations'), findsOneWidget);
      expect(find.text('Luxury Hotel'), findsOneWidget);
      expect(find.text('Budget Inn'), findsOneWidget);
      expect(find.text('\$150.00 per night'), findsOneWidget);
      expect(find.text('\$65.00 per night'), findsOneWidget);
    });

    testWidgets('highlights selected accommodation', (WidgetTester tester) async {
      // Arrange
      var testAccommodations;
      final loadedState = AccommodationState(
        isLoading: false,
        accommodationsByDestination: testAccommodations,
        error: '',
      );
      
      // Act
      await tester.pumpWidget(createWidgetUnderTest(
        state: loadedState,
        selectedAccommodationId: '1',
      ));
      
      // Assert
      // We can't easily test the border directly, but we can check for the "Selected" text
      expect(find.text('Selected'), findsOneWidget);
    });

    testWidgets('calls onSelectAccommodation when accommodation is tapped', (WidgetTester tester) async {
      // Arrange
      String? selectedId;
      var testAccommodations;
      final loadedState = AccommodationState(
        isLoading: false,
        accommodationsByDestination: testAccommodations,
        error: '',
      );
      
      // Act
      await tester.pumpWidget(createWidgetUnderTest(
        state: loadedState,
        onSelectAccommodation: (id) => selectedId = id,
      ));
      
      // Find and tap the first accommodation card
      await tester.tap(find.text('Luxury Hotel'));
      
      // Assert
      expect(selectedId, '1');
    });

    testWidgets('calls onSelectAccommodation with null when selected accommodation is tapped again', (WidgetTester tester) async {
      // Arrange
      String? selectedId = '1';
      var testAccommodations;
      final loadedState = AccommodationState(
        isLoading: false,
        accommodationsByDestination: testAccommodations,
        error: '',
      );
      
      // Act
      await tester.pumpWidget(createWidgetUnderTest(
        state: loadedState,
        selectedAccommodationId: '1',
        onSelectAccommodation: (id) => selectedId = id,
      ));
      
      // Find and tap the first accommodation card (which is already selected)
      await tester.tap(find.text('Luxury Hotel'));
      
      // Assert
      expect(selectedId, null);
    });
    
    testWidgets('retry button triggers refresh event', (WidgetTester tester) async {
      // Arrange
      final errorState = AccommodationState(
        isLoading: false,
        accommodationsByDestination: [],
        error: 'Failed to load accommodations',
      );
      
      // Act
      await tester.pumpWidget(createWidgetUnderTest(state: errorState));
      
      // Find and tap the retry button
      await tester.tap(find.text('Retry'));
    });
  });
}