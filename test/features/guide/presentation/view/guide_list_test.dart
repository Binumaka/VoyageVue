import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voyagevue/features/guide/domain/entity/guide_entity.dart';
import 'package:voyagevue/features/guide/presentation/view/guide_list.dart';
import 'package:voyagevue/features/guide/presentation/view_model/bloc/guide_bloc.dart';

void main() {
  group('GuideListView', () {
    late GuideBloc guideBloc;

    setUp(() {
      guideBloc = GuideBloc as GuideBloc;
    });

    testWidgets('renders loading indicator when the state is loading', (tester) async {
      // Arrange
      whenListen(
        guideBloc,
        Stream.value(GuideState(isLoading: true, guide: [], error: '')),
      );

      // Act
      await tester.pumpWidget(
        BlocProvider<GuideBloc>(
          create: (_) => guideBloc,
          child: MaterialApp(
            home: Scaffold(
              body: GuideListView(
                onSelectGuide: (_) {},
                selectedGuideId: null,
              ),
            ),
          ),
        ),
      );

      // Assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('displays error message when there is an error', (tester) async {
      // Arrange
      whenListen(
        guideBloc,
        Stream.value(GuideState(isLoading: false, guide: [], error: 'An error occurred')),
      );

      // Act
      await tester.pumpWidget(
        BlocProvider<GuideBloc>(
          create: (_) => guideBloc,
          child: MaterialApp(
            home: Scaffold(
              body: GuideListView(
                onSelectGuide: (_) {},
                selectedGuideId: null,
              ),
            ),
          ),
        ),
      );

      // Assert
      expect(find.text('Error: An error occurred'), findsOneWidget);
    });

    testWidgets('displays "No guides available" when there are no guides', (tester) async {
      // Arrange
      whenListen(
        guideBloc,
        Stream.value(GuideState(isLoading: false, guide: [], error: '')),
      );

      // Act
      await tester.pumpWidget(
        BlocProvider<GuideBloc>(
          create: (_) => guideBloc,
          child: MaterialApp(
            home: Scaffold(
              body: GuideListView(
                onSelectGuide: (_) {},
                selectedGuideId: null,
              ),
            ),
          ),
        ),
      );

      // Assert
      expect(find.text('No guides available.'), findsOneWidget);
    });

    testWidgets('renders a list of guides when guides are available', (tester) async {
      // Arrange
      final guideState = GuideState(
        isLoading: false,
        guide: [
          GuideEntity(id: '1', name: 'John Doe', experience: 5, email: '', languages: [], contact: 1234, availability: false),
          GuideEntity(id: '2', name: 'John Doe', experience: 5, email: '', languages: [], contact: 1234, availability: false),
          
        ],
        error: '',
      );
      whenListen(
        guideBloc,
        Stream.value(guideState),
      );

      // Act
      await tester.pumpWidget(
        BlocProvider<GuideBloc>(
          create: (_) => guideBloc,
          child: MaterialApp(
            home: Scaffold(
              body: GuideListView(
                onSelectGuide: (_) {},
                selectedGuideId: null,
              ),
            ),
          ),
        ),
      );

      // Assert
      expect(find.text('John Doe'), findsOneWidget);
      expect(find.text('Experience: 5 years'), findsOneWidget);
      expect(find.text('Jane Smith'), findsOneWidget);
      expect(find.text('Experience: 3 years'), findsOneWidget);
    });

    testWidgets('calls onSelectGuide when a guide is tapped', (tester) async {
      // Arrange
      final guideState = GuideState(
        isLoading: false,
        guide: [
          GuideEntity(id: '1', name: 'John Doe', experience: 5, email: '', languages: [], contact: 1234, availability: false),
        ],
        error: '',
      );
      whenListen(
        guideBloc,
        Stream.value(guideState),
      );
      String? selectedGuideId;
      final onSelectGuide = (String? id) {
        selectedGuideId = id;
      };

      // Act
      await tester.pumpWidget(
        BlocProvider<GuideBloc>(
          create: (_) => guideBloc,
          child: MaterialApp(
            home: Scaffold(
              body: GuideListView(
                onSelectGuide: onSelectGuide,
                selectedGuideId: null,
              ),
            ),
          ),
        ),
      );

      // Tap the guide
      await tester.tap(find.text('John Doe'));
      await tester.pumpAndSettle();

      // Assert
      expect(selectedGuideId, '1');
    });
  });
}
