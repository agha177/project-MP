import 'package:flutter/material.dart';
import 'gift_details_screen.dart'; // Import the GiftDetailsScreen

class FriendGiftListScreen extends StatelessWidget {
  // Mock data for friend's gifts
  final List<Map<String, String>> friendGifts = [
    {'name': 'Smartphone', 'category': 'Electronics', 'status': 'Available'},
    {'name': 'Book', 'category': 'Books', 'status': 'Pledged'},
    {'name': 'Watch', 'category': 'Accessories', 'status': 'Available'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Friend\'s Gifts', style: TextStyle(color: Colors.white)),
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
        child: friendGifts.isEmpty
            ? Center(
                child: Text(
                  'No gifts found.',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              )
            : ListView.builder(
                itemCount: friendGifts.length,
                itemBuilder: (context, index) {
                  final gift = friendGifts[index];
                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      leading: Icon(
                        Icons.card_giftcard,
                        color: gift['status'] == 'Available'
                            ? Colors.green
                            : Colors.orange,
                      ),
                      title: Text(
                        gift['name']!,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      subtitle: Text(
                        "Category: ${gift['category']}\nStatus: ${gift['status']}",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      isThreeLine: true,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GiftDetailsScreen(gift: gift),
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
