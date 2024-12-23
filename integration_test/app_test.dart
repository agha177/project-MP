import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:project_mp/main.dart'; // Replace with your actual project name

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('App Integration Tests', () {
    testWidgets('Verify app launches and navigates through screens',
        (WidgetTester tester) async {
      // Launch the app
      await tester.pumpWidget(HedieatyApp());

      // Verify the initial screen is Sign-In screen
      expect(find.text('Sign In'), findsOneWidget);

      // Navigate to Register Screen
      final registerButton = find.text('Register');
      expect(registerButton, findsOneWidget);
      await tester.tap(registerButton);
      await tester.pumpAndSettle();

      // Verify the Register screen
      expect(find.text('Create Account'), findsOneWidget);

      // Simulate entering user data
      await tester.enterText(find.byKey(Key('emailField')), 'test@example.com');
      await tester.enterText(find.byKey(Key('passwordField')), 'password123');
      await tester.tap(find.byKey(Key('registerButton')));
      await tester.pumpAndSettle();

      // Verify navigation to Home Screen
      expect(find.text('Home'), findsOneWidget);

      // Navigate to Profile Screen
      final profileButton = find.text('Profile');
      expect(profileButton, findsOneWidget);
      await tester.tap(profileButton);
      await tester.pumpAndSettle();

      // Verify Profile screen loads
      expect(find.text('Edit Profile'), findsOneWidget);
    });

    testWidgets('Add and verify an event', (WidgetTester tester) async {
      // Launch the app
      await tester.pumpWidget(HedieatyApp());
      await tester.pumpAndSettle();

      // Navigate to Home Screen
      final loginButton = find.text('Login');
      expect(loginButton, findsOneWidget);
      await tester.tap(loginButton);
      await tester.pumpAndSettle();

      // Navigate to Event List Screen
      final eventListButton = find.text('Events');
      expect(eventListButton, findsOneWidget);
      await tester.tap(eventListButton);
      await tester.pumpAndSettle();

      // Add a new event
      final addEventButton = find.byIcon(Icons.add);
      expect(addEventButton, findsOneWidget);
      await tester.tap(addEventButton);
      await tester.pumpAndSettle();

      await tester.enterText(
          find.byKey(Key('eventNameField')), 'Birthday Party');
      await tester.enterText(
          find.byKey(Key('eventCategoryField')), 'Celebration');
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();

      // Verify the event is added to the list
      expect(find.text('Birthday Party'), findsOneWidget);
    });

    testWidgets('Edit Profile and save changes', (WidgetTester tester) async {
      // Launch the app
      await tester.pumpWidget(HedieatyApp());
      await tester.pumpAndSettle();

      // Navigate to Profile Screen
      final profileButton = find.text('Profile');
      expect(profileButton, findsOneWidget);
      await tester.tap(profileButton);
      await tester.pumpAndSettle();

      // Open Edit Profile dialog
      final editProfileButton = find.text('Edit Profile');
      expect(editProfileButton, findsOneWidget);
      await tester.tap(editProfileButton);
      await tester.pumpAndSettle();

      // Simulate entering new data
      await tester.enterText(find.byKey(Key('nameField')), 'John Smith');
      await tester.enterText(
          find.byKey(Key('emailField')), 'john.smith@example.com');
      await tester.enterText(find.byKey(Key('phoneField')), '+1234567890');
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();

      // Verify the profile is updated
      expect(find.text('John Smith'), findsOneWidget);
      expect(find.text('john.smith@example.com'), findsOneWidget);
    });
  });
}
