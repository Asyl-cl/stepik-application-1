import 'package:flutter/material.dart';
import 'package:flutter_application_2/model/user.dart';

class UserInfoPage extends StatelessWidget {
  final User userInfo;
  UserInfoPage({required this.userInfo});
  bool _has(String? value) => value != null && value.trim().isNotEmpty;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Info'), centerTitle: true),
      body: Card(
        margin: EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              title: Text(
                '${userInfo.name}',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              subtitle: _has(userInfo.story) ? Text('${userInfo.story}') : null,
              leading: const Icon(Icons.person, color: Colors.black),
              trailing: _has(userInfo.country) ? Text(userInfo.country!) : null,
            ),
            ListTile(
              title: Text(
                '${userInfo.phone}',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              leading: Icon(Icons.phone, color: Colors.black),
            ),
            if (_has(userInfo.email))
              ListTile(
                title: Text(
                  '${userInfo.email}',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                leading: Icon(Icons.mail, color: Colors.black),
              ),
          ],
        ),
      ),
    );
  }
}
