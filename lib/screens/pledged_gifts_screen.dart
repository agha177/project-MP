import 'package:flutter/material.dart';
import 'gift_details_screen.dart';

class GiftPledgedScreen extends StatefulWidget {
  @override
  _GiftPledgedScreenState createState() => _GiftPledgedScreenState();
}

class _GiftPledgedScreenState extends State<GiftPledgedScreen> {
  // Mock data for pledged gifts
  List<Map<String, String>> pledgedGifts = [
    {
      'name': 'Laptop',
      'category': 'Electronics',
      'status': 'Pledged',
      'pledger': 'Alice'
    },
    {
      'name': 'Headphones',
      'category': 'Accessories',
      'status': 'Pledged',
      'pledger': 'Bob'
    },
    {
      'name': 'Shoes',
      'category': 'Fashion',
      'status': 'Pledged',
      'pledger': 'Charlie'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pledged Gifts', style: TextStyle(color: Colors.white)),
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
        child: pledgedGifts.isEmpty
            ? Center(
                child: Text(
                  'No pledged gifts.',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              )
            : ListView.builder(
                itemCount: pledgedGifts.length,
                itemBuilder: (context, index) {
                  final gift = pledgedGifts[index];
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
                        color: Colors.orange, // Color indicating pledged gift
                      ),
                      title: Text(
                        gift['name']!,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      subtitle: Text(
                        "Category: ${gift['category']}\nStatus: ${gift['status']}\nPledged by: ${gift['pledger']}",
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Logic to unpledge the gift or mark it as available
          showUnpledgeGiftDialog();
        },
        backgroundColor: Colors.deepPurple, // Consistent FAB color
        child: Icon(Icons.remove_circle_outline),
        tooltip: 'Unpledge Gift',
      ),
    );
  }

  // Dialog to unpledge the gift or mark it as available
  void showUnpledgeGiftDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Unpledge Gift'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          content: Text(
            'Do you want to unpledge a gift or mark it as Available?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  // Here, you can add the logic to update the gift status
                  pledgedGifts[0]['status'] =
                      'Available'; // Example of marking as available
                });
                Navigator.pop(context);
              },
              child: Text('Unpledge'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  // Here, you can add the logic to unpledge a specific gift
                  pledgedGifts.removeAt(
                      0); // Example of removing the first pledged gift
                });
                Navigator.pop(context);
              },
              child: Text('Remove'),
            ),
          ],
        );
      },
    );
  }
}
