import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project_mp/screens/profile_screen.dart';

void main() {
  testWidgets('Profile Screen displays user information',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: ProfileScreen()));

    expect(find.text('Profile'), findsOneWidget);
    expect(find.text('Edit Profile'), findsOneWidget);
  });
}
