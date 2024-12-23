import 'package:flutter/material.dart';
import 'package:project_mp/screens/user_event_screen.dart';
import 'friend_event_list_screen.dart'; // Screen for friend's events
import 'pledged_gifts_screen.dart'; // Screen for pledged gifts
import 'notification_settings_screen.dart'; // Screen for notification settings
import 'package:project_mp/services/database_helper.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final dbHelper = DatabaseHelper(); // Database Helper instance
  Map<String, dynamic> userProfile = {};

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    final users = dbHelper.getAllUsers();
    if (users.isNotEmpty) {
      setState(() {
        userProfile =
            users.first; // Assuming the first user is the logged-in user
      });
    } else {
      userProfile = {
        'id': '1', // Unique key for user
        'name': 'abdelrahman',
        'email': 'abdelrahman@gmail.com',
        'phone': '01019345662',
        'events': '2',
        'gifts': '3',
        'profilePicture':
            'https://example.com/default-profile-picture.png', // Default profile picture URL
      };
      await dbHelper.addUser(userProfile);
      setState(() {});
    }
  }

  void _showEditProfileDialog() {
    final nameController = TextEditingController(text: userProfile['name']);
    final emailController = TextEditingController(text: userProfile['email']);
    final phoneController = TextEditingController(text: userProfile['phone']);
    final profilePictureController =
        TextEditingController(text: userProfile['profilePicture']);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Profile'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                ),
                TextField(
                  controller: phoneController,
                  decoration: InputDecoration(labelText: 'Phone'),
                ),
                TextField(
                  controller: profilePictureController,
                  decoration: InputDecoration(labelText: 'Profile Picture URL'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                final updatedProfile = {
                  'id': userProfile['id'],
                  'name': nameController.text,
                  'email': emailController.text,
                  'phone': phoneController.text,
                  'profilePicture': profilePictureController.text,
                  'events': userProfile['events'],
                  'gifts': userProfile['gifts'],
                };
                await dbHelper.addUser(updatedProfile);
                setState(() {
                  userProfile = updatedProfile;
                });
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple.shade100, Colors.purple.shade400],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 80,
                  backgroundImage: NetworkImage(userProfile['profilePicture'] ??
                      'https://example.com/default-profile-picture.png'),
                ),
                SizedBox(height: 20),
                Text(
                  userProfile['name'] ?? 'Unknown',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  userProfile['email'] ?? 'No Email',
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                ),
                SizedBox(height: 8),
                Text(
                  userProfile['phone'] ?? 'No Phone',
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                ),
                SizedBox(height: 20),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildStatCard('Events', userProfile['events'] ?? '0'),
                        _buildStatCard('Gifts', userProfile['gifts'] ?? '0'),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: _showEditProfileDialog,
                  icon: Icon(Icons.edit),
                  label: Text('Edit Profile'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple.shade700,
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                    textStyle: TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NotificationSettingsScreen(),
                      ),
                    );
                  },
                  icon: Icon(Icons.notifications),
                  label: Text('Notification Settings'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange.shade600,
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserEventsScreen(),
                      ),
                    );
                  },
                  icon: Icon(Icons.event),
                  label: Text('My Events & Gifts'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal.shade600,
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FriendEventListScreen(),
                      ),
                    );
                  },
                  icon: Icon(Icons.group),
                  label: Text('Friend\'s Events'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GiftPledgedScreen(),
                      ),
                    );
                  },
                  icon: Icon(Icons.card_giftcard),
                  label: Text('My Pledged Gifts'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.purple.shade800,
          ),
        ),
        SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
        ),
      ],
    );
  }
}
