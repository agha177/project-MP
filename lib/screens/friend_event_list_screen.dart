import 'package:flutter/material.dart';
import 'package:project_mp/screens/friend_gift_list_screen.dart';
// Import the FriendGiftListScreen

class FriendEventListScreen extends StatelessWidget {
  // Mock data for friend's events
  final List<Map<String, String>> friendEvents = [
    {
      'name': 'John’s Birthday Party',
      'date': '2024-12-25',
      'location': 'John’s House',
    },
    {
      'name': 'Anna’s Wedding',
      'date': '2025-01-15',
      'location': 'Beach Resort',
    },
    {
      'name': 'Office Farewell Party',
      'date': '2024-12-20',
      'location': 'Downtown Cafe',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Friend Events', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal.shade100, Colors.teal.shade400],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: friendEvents.isEmpty
            ? Center(
                child: Text(
                  'No events found.',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              )
            : ListView.builder(
                itemCount: friendEvents.length,
                itemBuilder: (context, index) {
                  final event = friendEvents[index];
                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      leading: Icon(Icons.event, color: Colors.teal),
                      title: Text(
                        event['name']!,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      subtitle: Text(
                        "Date: ${event['date']}\nLocation: ${event['location']}",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      isThreeLine: true,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                FriendGiftListScreen(), // Navigate to FriendGiftListScreen
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
      ),
    );
  }
}
