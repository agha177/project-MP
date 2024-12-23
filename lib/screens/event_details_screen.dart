import 'package:flutter/material.dart';

class EventDetailsScreen extends StatelessWidget {
  final Map<String, String> event;

  const EventDetailsScreen({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(event['name']!),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           Text(
              event['name'] ?? 'Event Name',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Date: ${event['date']}",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 8),
            Text(
              "Location: ${event['location']}",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Logic for RSVP or Pledging Gift
                },
                child: Text('Pledge Gift or RSVP'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
