import 'package:flutter/material.dart';
import 'package:project_mp/services/database_helper.dart'; // Import DatabaseHelper

class EventListScreen extends StatefulWidget {
  final Map<String, dynamic>? selectedFriend;

  const EventListScreen({Key? key, this.selectedFriend}) : super(key: key);

  @override
  _EventListScreenState createState() => _EventListScreenState();
}

class _EventListScreenState extends State<EventListScreen> {
  List<Map<String, dynamic>> events = []; // List to hold events from Hive
  final dbHelper = DatabaseHelper(); // Instance of DatabaseHelper

  @override
  void initState() {
    super.initState();
    _loadEvents(); // Load events from Hive when screen initializes
  }

  Future<void> _loadEvents() async {
    final loadedEvents = dbHelper.getAllEvents(); // Fetch all events from Hive
    final friendName = widget.selectedFriend?['name'];
    setState(() {
      events = friendName != null
          ? loadedEvents
              .where((event) => event['friendName'] == friendName)
              .toList()
          : loadedEvents;
    });
  }

  Future<void> _addEvent(String name, String category) async {
    final newEvent = {
      'id': DateTime.now().toString(), // Unique ID for the event
      'name': name,
      'category': category,
      'status': 'Upcoming', // Default status for new events
      'friendName':
          widget.selectedFriend?['name'], // Associate with the selected friend
    };
    await dbHelper.addEvent(newEvent); // Add the event to Hive
    _loadEvents(); // Reload events to reflect the new addition
  }

  void _showAddEventBottomSheet() {
    final nameController = TextEditingController();
    final categoryController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Event Name'),
              ),
              SizedBox(height: 10),
              TextField(
                controller: categoryController,
                decoration: InputDecoration(labelText: 'Category'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (nameController.text.isEmpty ||
                      categoryController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please fill in all fields')),
                    );
                    return;
                  }
                  _addEvent(nameController.text, categoryController.text);
                  Navigator.pop(context);
                },
                child: Text('Add Event'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple, // Button color
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Color getStatusColor(String? status) {
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
        title: Text(
          widget.selectedFriend != null
              ? "${widget.selectedFriend!['name']}'s Events"
              : "Event List",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: events.isEmpty
          ? Center(
              child: Text(
                'No events yet. Add your first event!',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.purple.shade100, Colors.purple.shade400],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: ListView.builder(
                itemCount: events.length,
                itemBuilder: (context, index) {
                  final event = events[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: Icon(
                        Icons.event,
                        color: getStatusColor(event['status']),
                      ),
                      title: Text(
                        event['name'] ?? 'Unnamed Event',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        "Category: ${event['category'] ?? 'Uncategorized'}",
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () async {
                          if (event['id'] != null) {
                            await dbHelper.deleteEvent(event['id']);
                            _loadEvents(); // Reload events after deletion
                          }
                        },
                      ),
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/gift_list', // Navigate to Gift List Screen
                          arguments: {
                            'eventName': event['name'],
                            'eventCategory': event['category'],
                          },
                        );
                      },
                    ),
                  );
                },
              ),
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddEventBottomSheet,
        label: Text('Add Event'),
        icon: Icon(Icons.add),
        backgroundColor: Colors.deepPurple,
      ),
    );
  }
}
