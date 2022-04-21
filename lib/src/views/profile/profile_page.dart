import 'package:flutter/material.dart';

import '../../utils/auth.dart';
import 'components/guest_credentials.dart';
import 'components/user_credentials.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 28, 16, 0),
      child: Column(
        children: [
          // poster & username
          Auth().isGuestLoggedIn
              ? const GuestUserCredientials()
              : const AuthUserCredentials(),
        ],
      ),
    );
  }
}
