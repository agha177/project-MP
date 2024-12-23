import 'package:flutter/material.dart';
import 'package:project_mp/services/database_helper.dart'; // Import DatabaseHelper
import 'event_list_screen.dart'; // Import EventListScreen

class Friend {
  final String name;
  final String events;
  final String? profilePicture;

  Friend({
    required this.name,
    required this.events,
    this.profilePicture,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'events': events,
      'profilePicture': profilePicture,
    };
  }

  static Friend fromMap(Map<String, dynamic> map) {
    return Friend(
      name: map['name'],
      events: map['events'],
      profilePicture: map['profilePicture'],
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Friend> friends = []; // List to store friends from the database
  final dbHelper = DatabaseHelper(); // DatabaseHelper instance

  @override
  void initState() {
    super.initState();
    _loadFriends(); // Load friends from the database
  }

  Future<void> _loadFriends() async {
    final friendMaps = dbHelper.getAllFriends();
    setState(() {
      friends.clear();
      friends.addAll(friendMaps.map((map) => Friend.fromMap(map)));
    });
  }

  Future<void> _addFriend(
      String name, String events, String? profilePicture) async {
    final newFriend =
        Friend(name: name, events: events, profilePicture: profilePicture);
    await dbHelper.addFriend(newFriend.toMap());
    _loadFriends(); // Reload friends after adding
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hedeiaty', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.purple,
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: FriendSearchDelegate(friends),
              );
            },
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: friends.length,
            itemBuilder: (context, index) {
              final friend = friends[index];
              return Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                margin: EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  contentPadding: EdgeInsets.all(15),
                  leading: CircleAvatar(
                    backgroundImage: friend.profilePicture != null
                        ? NetworkImage(friend.profilePicture!)
                        : null,
                    child: friend.profilePicture == null
                        ? Text(friend.name[0],
                            style: TextStyle(color: Colors.white))
                        : null,
                  ),
                  title: Text(
                    friend.name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  subtitle: Text(
                    "Upcoming Events: ${friend.events}",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  trailing:
                      Icon(Icons.chevron_right, color: Colors.deepPurple[600]),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EventListScreen(
                          selectedFriend: friend.toMap(), // Pass the friend name
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showAddFriendDialog();
        },
        label: Text('Add Friend'),
        icon: Icon(Icons.add),
        backgroundColor: Colors.deepPurple,
      ),
    );
  }

  void _showAddFriendDialog() {
    final nameController = TextEditingController();
    final eventsController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Friend'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: eventsController,
                decoration: InputDecoration(labelText: 'Events'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final name = nameController.text;
                final events = eventsController.text;
                if (name.isNotEmpty && events.isNotEmpty) {
                  _addFriend(name, events, null);
                  Navigator.pop(context);
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }
}

class FriendSearchDelegate extends SearchDelegate {
  final List<Friend> friends;

  FriendSearchDelegate(this.friends);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = friends
        .where(
            (friend) => friend.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final friend = results[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: friend.profilePicture != null
                ? NetworkImage(friend.profilePicture!)
                : null,
            child: friend.profilePicture == null
                ? Text(friend.name[0], style: TextStyle(color: Colors.white))
                : null,
          ),
          title: Text(friend.name),
          subtitle: Text("Upcoming Events: ${friend.events}"),
          onTap: () {
            close(context, null);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EventListScreen(
                  selectedFriend: friend.toMap(),
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = friends
        .where((friend) =>
            friend.name.toLowerCase().startsWith(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final friend = suggestions[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: friend.profilePicture != null
                ? NetworkImage(friend.profilePicture!)
                : null,
            child: friend.profilePicture == null
                ? Text(friend.name[0], style: TextStyle(color: Colors.white))
                : null,
          ),
          title: Text(friend.name),
          subtitle: Text("Upcoming Events: ${friend.events}"),
          onTap: () {
            query = friend.name;
          },
        );
      },
    );
  }
}
