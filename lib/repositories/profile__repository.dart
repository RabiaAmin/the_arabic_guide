import '../models/profile.dart';

class ProfileRepository {
  // Mock data
  Profile _profile = Profile(
    name: 'John Doe',
    email: 'john.doe@example.com',
    userType: 'Enrolled User',
    notificationsEnabled: true,
  );

  // Fetch profile data
  Future<Profile> fetchProfile() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));
    return _profile;
  }

  // Update profile data
  Future<void> updateProfile(Profile updatedProfile) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    _profile = updatedProfile;
  }
}
