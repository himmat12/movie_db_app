import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../configs/configs.dart';
import '../../controllers/auth_v3_controller.dart';
import '../../controllers/configuration_controller.dart';
import '../../utils/auth.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);

  final _configController = Get.find<ConfigurationController>();
  final _authV3Controller = Get.find<AuthV3Controller>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 28, 16, 0),
      child: Column(
        children: [
          // poster & username
          Auth().isGuestLoggedIn
              ? guestUserCredientials()
              : authUserCredentials(),
        ],
      ),
    );
  }

// auth user
  Widget authUserCredentials() => GestureDetector(
        onTap: () {
          Get.toNamed('/user_profile');
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          color: Colors.transparent,
          child: Row(
            children: [
              // poster
              ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: Auth().userAvatar == null
                    ? Container(
                        alignment: Alignment.center,
                        width: 64,
                        height: 64,
                        color: primaryblue,
                        child: const Icon(
                          Icons.person,
                          color: primaryWhite,
                          size: 56,
                        ),
                      )
                    : CachedNetworkImage(
                        width: 64,
                        height: 64,
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) => Container(
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: Colors.black12,
                          ),
                          child: const Icon(
                            Icons.error,
                            color: primaryWhite,
                          ),
                        ),
                        imageUrl:
                            '${_configController.profileUrl}/${Auth().userAvatar}',
                        placeholder: (context, url) => Container(
                          color: Colors.black12,
                        ),
                      ),
              ),
              const SizedBox(width: 16),
              // username
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Auth().username ?? 'username',
                    style: TextStyle(
                      fontSize: m + 2,
                      fontWeight: FontWeight.w700,
                      color: primaryDarkBlue.withOpacity(
                        0.8,
                      ),
                    ),
                  ),
                  Text(
                    'View profile',
                    style: TextStyle(
                      fontSize: n,
                      fontWeight: FontWeight.w600,
                      color: primaryDarkBlue.withOpacity(
                        0.6,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );

  // guest user
  Widget guestUserCredientials() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            decoration: BoxDecoration(
              color: primaryDarkBlue,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              'Guest*',
              style: TextStyle(
                fontSize: m + 2,
                fontWeight: FontWeight.w700,
                color: primaryblue,
              ),
            ),
          ),
          const SizedBox(height: 12),

          // signout
          GestureDetector(
            onTap: () {
              _authV3Controller.logoutV3();
            },
            child: Container(
              color: Colors.transparent,
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Signout',
                    style: TextStyle(
                      color: primaryblue,
                      fontSize: n,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 18,
                    color: Colors.black54,
                  ),
                ],
              ),
            ),
          ),
        ],
      );
}
