import 'package:flutter/material.dart';

class UserEventsScreen extends StatelessWidget {
  final List<Map<String, String>> userEvents = [
    {'name': 'My Birthday Party', 'category': 'Personal', 'status': 'Upcoming'},
    {'name': 'My Wedding', 'category': 'Family', 'status': 'Current'},
  ]; // This would be fetched dynamically in a real app.

  Color getStatusColor(String status) {
    switch (status) {
      case 'Upcoming':
        return Colors.green;
      case 'Current':
        return Colors.blue;
      case 'Past':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Events'),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: userEvents.isEmpty
          ? Center(
              child: Text(
                'No events created yet.',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: userEvents.length,
              itemBuilder: (context, index) {
                final event = userEvents[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: Icon(
                      Icons.event,
                      color: getStatusColor(event['status']!),
                    ),
                    title: Text(
                      event['name']!,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text("Category: ${event['category']}"),
                  ),
                );
              },
            ),
    );
  }
}
