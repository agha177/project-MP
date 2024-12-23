import 'package:flutter/material.dart';

class GiftDetailsScreen extends StatelessWidget {
  final Map<String, String> gift;

  // Constructor to accept gift data
  GiftDetailsScreen({required this.gift});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          gift['name']!,
          style: TextStyle(color: Colors.white),
        ),
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Gift Image
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  gift['photo'] ??
                      'https://via.placeholder.com/200', // Fallback image
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 20),
              // Gift Name
              Text(
                gift['name']!,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              // Gift Category
              Text(
                'Category: ${gift['category']}',
                style: TextStyle(fontSize: 20, color: Colors.white70),
              ),
              SizedBox(height: 10),
              // Gift Status
              Chip(
                label: Text(
                  gift['status']!,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                backgroundColor: gift['status'] == 'Available'
                    ? Colors.green
                    : Colors.orange,
              ),
              SizedBox(height: 20),
              // Gift Description
              Text(
                gift['details'] ?? 'No details available.',
                style: TextStyle(fontSize: 16, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
