// /models/event_model.dart

class Event {
  final String id; // Unique event ID
  final String name; // Event name
  final String description; // Event description
  final DateTime date; // Event date
  final String location; // Event location

  Event({
    required this.id,
    required this.name,
    required this.description,
    required this.date,
    required this.location,
  });

  // Convert Event object to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'date': date.toIso8601String(),
      'location': location,
    };
  }

  // Create an Event object from a Map
  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      date: DateTime.parse(map['date']),
      location: map['location'],
    );
  }
}

