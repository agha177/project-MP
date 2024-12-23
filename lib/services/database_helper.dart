import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<void> initialize() async {
    await Hive.initFlutter();

    // Open or create boxes
    await _openBox('users');
    await _openBox('events');
    await _openBox('gifts');
    await _openBox('friends');

    print('Hive boxes initialized successfully.');
  }

  Future<void> _openBox(String boxName) async {
    if (!Hive.isBoxOpen(boxName)) {
      await Hive.openBox<Map>(boxName);
      print('Box "$boxName" opened.');
    }
  }

  Box<Map> getBox(String boxName) {
    if (!Hive.isBoxOpen(boxName)) {
      throw Exception(
          'Box "$boxName" is not open. Please initialize the database.');
    }
    return Hive.box<Map>(boxName);
  }

  // Users
  Future<void> addUser(Map<String, dynamic> user) async {
    final userBox = getBox('users');
    await userBox.put(user['id'], user);
    print('User added: $user');
  }

  Future<void> updateUserProfilePicture(String userId, String imagePath) async {
    final userBox = getBox('users');
    final user = userBox.get(userId);

    if (user != null) {
      user['profilePicture'] = imagePath; // Update profile picture path
      await userBox.put(userId, user);
      print('Profile picture updated for user $userId: $imagePath');
    } else {
      throw Exception('User not found');
    }
  }

  Map<String, dynamic>? getUser(String id) {
    final userBox = getBox('users');
    return userBox.get(id)?.cast<String, dynamic>();
  }

  List<Map<String, dynamic>> getAllUsers() {
    final userBox = getBox('users');
    final users = userBox.values.toList().cast<Map<String, dynamic>>();
    print('All users: $users');
    return users;
  }

  Future<void> deleteUser(String id) async {
    final userBox = getBox('users');
    await userBox.delete(id);
    print('User deleted: $id');
  }

  // Events
  Future<void> addEvent(Map<String, dynamic> event) async {
    final eventBox = getBox('events');
    await eventBox.put(event['id'], event);
    print('Event added: $event');
  }

  List<Map<String, dynamic>> getAllEvents() {
    final eventBox = getBox('events');
    final events = eventBox.values.toList().cast<Map<String, dynamic>>();
    print('All events: $events');
    return events;
  }

  Future<void> deleteEvent(String id) async {
    final eventBox = getBox('events');
    await eventBox.delete(id);
    print('Event deleted: $id');
  }

  // Gifts
  Future<void> addGift(Map<String, dynamic> gift) async {
    final giftBox = getBox('gifts');
    await giftBox.put(gift['id'], gift);
    print('Gift added: $gift');
  }

  List<Map<String, dynamic>> getAllGifts() {
    final giftBox = getBox('gifts');
    final gifts = giftBox.values.toList().cast<Map<String, dynamic>>();
    print('All gifts: $gifts');
    return gifts;
  }

  Future<void> deleteGift(String id) async {
    final giftBox = getBox('gifts');
    await giftBox.delete(id);
    print('Gift deleted: $id');
  }

  // Friends
  Future<void> addFriend(Map<String, dynamic> friend) async {
    final friendBox = getBox('friends');
    final key = DateTime.now().millisecondsSinceEpoch.toString();
    await friendBox.put(key, friend);
    print('Friend added: $friend');
  }

  List<Map<String, dynamic>> getAllFriends() {
    final friendBox = getBox('friends');
    final friends = friendBox.values.toList().cast<Map<String, dynamic>>();
    print('All friends: $friends');
    return friends;
  }

  Future<void> deleteFriend(String id) async {
    final friendBox = getBox('friends');
    await friendBox.delete(id);
    print('Friend deleted: $id');
  }
}
