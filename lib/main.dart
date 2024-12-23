import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart'; // Import Hive
import 'services/database_helper.dart'; // Import DatabaseHelper
import 'screens/home_screen.dart';
import 'screens/event_list_screen.dart';
import 'screens/gift_list_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/sign_in_screen.dart';
import 'screens/register_screen.dart';

void debugHiveData() {
  final eventBox = Hive.box<Map>('events');
  print('Events Box Content: ${eventBox.toMap()}');
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyBqHcodNztkUTHbkPYvZvdbROCDV4yYsYI",
        authDomain: "project-mp-ec031.firebaseapp.com",
        projectId: "project-mp-ec031",
        storageBucket: "project-mp-ec031.appspot.com",
        messagingSenderId: "845319138776",
        appId: "1:845319138776:android:c5a9d11d91987f1bfcd6adYOUR_APP_ID",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  // Initialize Hive
  try {
    final dbHelper = DatabaseHelper();
    await dbHelper.initialize(); // Initialize Hive and open the box

    // Log success
    print("Hive initialized successfully.");

    // Optional: Test Hive database (can be removed later)
    await testDatabase();
  } catch (e) {
    print("Error initializing Hive: $e");
  }

  runApp(HedieatyApp());
}

// Function to test database functionality
Future<void> testDatabase() async {
  final dbHelper = DatabaseHelper();

  try {
    // Add sample data
    await dbHelper.addUser({
      'id': '1',
      'name': 'John Doe',
      'email': 'john.doe@example.com',
      'phone': '1234567890',
    });

    await dbHelper.addEvent({
      'id': '101',
      'name': 'Birthday Party',
      'date': '2024-12-25',
      'location': 'John’s House',
    });

    // Retrieve and print data
    final users = dbHelper.getAllUsers();
    print('Users: $users');

    final events = dbHelper.getAllEvents();
    print('Events: $events');
  } catch (e) {
    print("Error during database test: $e");
  }
}

class HedieatyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hedieaty',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        textTheme: TextTheme(
          displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(fontSize: 16),
          bodyMedium: TextStyle(fontSize: 14, color: Colors.grey[700]),
        ),
        cardTheme: CardTheme(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          filled: true,
          fillColor: Colors.grey[200],
        ),
      ),
      initialRoute: '/sign_in', // Set the SignInScreen as the initial screen
      routes: {
        '/sign_in': (context) => SignInScreen(),
        '/register': (context) => RegisterScreen(),
        '/home': (context) => HomeScreen(),
        '/profile': (context) => ProfileScreen(),
        '/event_list': (context) => EventListScreen(),
        '/gift_list': (context) => GiftListScreen(),
      },
    );
  }
}
