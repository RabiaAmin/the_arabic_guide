import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:the_arabic_guide_app/models/profile.dart';
import 'package:the_arabic_guide_app/repositories/profile__repository.dart';
import 'package:the_arabic_guide_app/utils/constants.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileRepository profileRepository = GetIt.I<ProfileRepository>();

  late Future<Profile> _profileFuture;
  Profile? _profile;

  // Controllers for text fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _profileFuture = profileRepository.fetchProfile();
  }

  // Function to save edited profile data
  Future<void> _saveProfile() async {
    final updatedProfile = Profile(
      name: _nameController.text,
      email: _emailController.text,
      userType: _profile!.userType,
      notificationsEnabled: _profile!.notificationsEnabled,
    );
    await profileRepository.updateProfile(updatedProfile);
    setState(() {
      _profile = updatedProfile;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile updated successfully')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KBaseColor,
      body: FutureBuilder<Profile>(
        future: _profileFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            _profile = snapshot.data!;
            _nameController.text = _profile!.name;
            _emailController.text = _profile!.email;

            return buildProfileContent();
          } else {
            return const Center(child: Text("No profile data found."));
          }
        },
      ),
    );
  }

  Widget buildProfileContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Title
          const Text(
            'User Profile',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          // User Type
          Row(
            children: [
              const Text(
                'User Type: ',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              Text(
                _profile!.userType,
                style: const TextStyle(fontSize: 17, color: Colors.teal),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Name Field
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Name',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),

          // Email Field
          TextField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),

          // Notifications Toggle
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Enable Notifications',
                style: TextStyle(fontSize: 18),
              ),
              Switch(
                activeColor: Colors.teal,
                value: _profile!.notificationsEnabled,
                onChanged: (bool newValue) {
                  setState(() {
                    _profile!.notificationsEnabled = newValue;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Save Button
          Center(
            child: ElevatedButton(
              onPressed: _saveProfile,
              child: const Text(
                'Save Changes',
                style: TextStyle(color: KBaseColor),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    kPrimaryColor, // Set your desired background color here
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Additional Options
          const Divider(),
          ListTile(
            leading: const Icon(Icons.lock),
            title: const Text('Change Password'),
            onTap: () {
              // Navigate to change password screen or open dialog
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Log Out'),
            onTap: () {
              // Handle log out
            },
          ),
        ],
      ),
    );
  }
}
