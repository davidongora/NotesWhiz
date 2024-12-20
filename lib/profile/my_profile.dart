import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes/onboarding/Auth/Error/error.dart';
import 'package:notes/onboarding/Auth/signup.dart';
import 'package:notes/profile/edit_profile.dart';

class MyProfile extends StatefulWidget {
  final Map<String, dynamic> user;

  const MyProfile({super.key, required this.user});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  late String userName;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userName = widget.user['name'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "My Profile",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(
                context); // This will pop the current screen and go back to the previous one
          },
        ),
      ),
      backgroundColor: Colors.black, // Black background for the entire page
      body: EMyProfile(user: widget.user),
    );
  }
}

class EMyProfile extends StatefulWidget {
  final Map<String, dynamic> user; // Add this to accept user data

  const EMyProfile({
    super.key,
    required this.user,
  });

  @override
  State<EMyProfile> createState() => _EMyProfileState();
}

class _EMyProfileState extends State<EMyProfile> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String userName = widget.user['name'] ?? 'User Name';

    return SingleChildScrollView(
      child: Container(
        color: Colors.black, // Black background for the content area
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Picture
            CircleAvatar(
              radius: 60.0,
              backgroundImage: const AssetImage('assets/rb.png'),
              child: IconButton(
                icon: const Icon(Icons.camera_alt),
                onPressed: () {
                  // Function to change image
                },
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              userName,
              // 'User Name',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            const SizedBox(height: 10),

            // Notes Section
            _buildExpansionTile(
              title: 'App Version',
              icon: Icons.note,
              children: [
                _buildListTile('Version 1.0'),
                // _buildListTile('data'),
              ],
            ),

            // Todo List Section
            _buildExpansionTile(
              title: 'Developer',
              icon: Icons.check_circle_outline,
              children: [
                _buildListTile(
                  'DaveOps',
                ),
                _buildListTile(
                  '0112027035',
                ),
                // _buildListTile('DaveOps', trailing: _buildDeleteButton()),
                // _buildListTile('0112027035', trailing: _buildDeleteButton()),
              ],
            ),
            // Trashed Files Section
            // _buildExpansionTile(
            //   title: 'Trashed Files',
            //   icon: Icons.delete,
            //   children: [
            //     _buildListTile('data'),
            //   ],
            // ),

            // Notifications Section
            _buildExpansionTile(
              title: 'Notifications',
              icon: Icons.notifications,
              children: [
                _buildListTile('will be included  on the next release',
                    onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => errorPage()));
                }),
              ],
            ),

            // Account Settings Section
            _buildExpansionTile(
              title: 'Account Settings',
              icon: Icons.settings,
              children: [
                _buildListTile(
                  'Edit Profile',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditMyProfile(
                                  user: widget.user,
                                )));
                    print('Edit Profile tapped!');
                  },
                ),
                _buildListTile(
                  'Allow Notifications',
                  trailing: Switch(
                    value: true,
                    onChanged: (bool value) {
                      // Handle notification settings toggle
                    },
                  ),
                ),
                _buildListTile(onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignupScreen()));
                }, 'Logout'),
                _buildListTile(
                  onTap: () {
                    Hive.deleteBoxFromDisk('email');
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Account Deleted Successfully')));
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignupScreen()));
                  },
                  'Delete Account',
                  style: const TextStyle(
                      color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper Method to Create ExpansionTile
  Widget _buildExpansionTile({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return ExpansionTile(
      backgroundColor: Colors.black,
      collapsedBackgroundColor: Colors.black,
      title: Text(title, style: const TextStyle(color: Colors.white)),
      leading: Icon(icon, color: Colors.white),
      children: children,
    );
  }

  // Helper Method to Create ListTile
  Widget _buildListTile(String title,
      {Widget? trailing, TextStyle? style, final onTap}) {
    return ListTile(
      title: Text(title, style: style ?? const TextStyle(color: Colors.white)),
      trailing: trailing,
      onTap: onTap,
    );
  }

  // Helper Method to Create Delete Button
  Widget _buildDeleteButton() {
    return IconButton(
      icon: const Icon(Icons.delete, color: Colors.white),
      onPressed: () {
        // Handle delete action
      },
    );
  }
}
