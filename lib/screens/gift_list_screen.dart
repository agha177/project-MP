import 'package:flutter/material.dart';
import 'gift_details_screen.dart';
import 'pledged_gifts_screen.dart'; // Import the PledgedGiftScreen

class GiftListScreen extends StatefulWidget {
  @override
  _GiftListScreenState createState() => _GiftListScreenState();
}

class _GiftListScreenState extends State<GiftListScreen> {
  // Updated gift data with photos and real details
  List<Map<String, String>> gifts = [
    {
      'name': 'Smartphone',
      'category': 'Electronics',
      'status': 'Available',
      'photo':
          'https://m.media-amazon.com/images/I/61L1ItFgFHL.jpg',
      'details': 'A brand new smartphone with the latest technology features.',
    },
    {
      'name': 'Book',
      'category': 'Books',
      'status': 'Pledged',
      'photo':
          'https://media.istockphoto.com/id/173015527/photo/a-single-red-book-on-a-white-surface.jpg?s=612x612&w=0&k=20&c=AeKmdZvg2_bRY2Yct7odWhZXav8CgDtLMc_5_pjSItY=',
      'details': 'A classic novel for book lovers.',
    },
    {
      'name': 'Watch',
      'category': 'Accessories',
      'status': 'Available',
      'photo':
          'https://m.media-amazon.com/images/I/61QeNWSSHaL._AC_SL1001_.jpg',
      'details': 'A sleek and modern watch to complete your outfit.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gift List', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.purple,
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GiftPledgedScreen()),
              );
            },
            tooltip: 'Filter Gifts',
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple.shade100, Colors.purple.shade400],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: gifts.isEmpty
            ? Center(
                child: Text(
                  'No gifts found.',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              )
            : ListView.builder(
                itemCount: gifts.length,
                itemBuilder: (context, index) {
                  final gift = gifts[index];
                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      leading: Image.network(
                        gift['photo']!,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddGiftDialog();
        },
        backgroundColor: Colors.deepPurple,
        child: Icon(Icons.add),
        tooltip: 'Add Gift',
      ),
    );
  }

  // Dialog to add a new gift
  void showAddGiftDialog() {
    final nameController = TextEditingController();
    final categoryController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add New Gift'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Gift Name'),
              ),
              TextField(
                controller: categoryController,
                decoration: InputDecoration(labelText: 'Category'),
              ),
            ],
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
                  gifts.add({
                    'name': nameController.text,
                    'category': categoryController.text,
                    'status': 'Available',
                    'photo': '', // Placeholder for now
                    'details': '', // Placeholder for now
                  });
                });
                Navigator.pop(context);
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
