import 'package:flutter_test/flutter_test.dart';
import 'package:project_mp/services/database_helper.dart';

void main() {
  group('DatabaseHelper Tests', () {
    final dbHelper = DatabaseHelper();

    setUp(() async {
      await dbHelper.initialize();
    });

    test('Add and Retrieve User', () async {
      final user = {
        'id': '1',
        'name': 'Test User',
        'email': 'test@example.com',
        'phone': '+1234567890',
      };

      await dbHelper.addUser(user);
      final fetchedUser = dbHelper.getUser('1');

      expect(fetchedUser, isNotNull);
      expect(fetchedUser!['name'], 'Test User');
    });
  });
}
