import 'package:flutter/material.dart';

class NotificationSettingsScreen extends StatefulWidget {
  @override
  _NotificationSettingsScreenState createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends State<NotificationSettingsScreen> {
  bool emailNotifications = true;
  bool smsNotifications = false;
  bool appNotifications = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification Settings'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Manage your notification preferences:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            // Email Notifications
            SwitchListTile(
              title: Text('Email Notifications'),
              value: emailNotifications,
              onChanged: (value) {
                setState(() {
                  emailNotifications = value;
                });
              },
            ),
            Divider(),

            // SMS Notifications
            SwitchListTile(
              title: Text('SMS Notifications'),
              value: smsNotifications,
              onChanged: (value) {
                setState(() {
                  smsNotifications = value;
                });
              },
            ),
            Divider(),

            // App Notifications
            SwitchListTile(
              title: Text('App Notifications'),
              value: appNotifications,
              onChanged: (value) {
                setState(() {
                  appNotifications = value;
                });
              },
            ),
            Divider(),

            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Save settings logic can be added here
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Notification settings updated!'),
                    ),
                  );
                },
                child: Text('Save Changes'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
