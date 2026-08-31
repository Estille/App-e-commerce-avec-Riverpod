import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_profile.dart';
import '../data/mock_user.dart';

/// Provider : profil utilisateur (mock, pas d'appel réseau).
final userProfileProvider = Provider<UserProfile>((ref) {
  return mockUser;
});
