import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/src/configs/color_config.dart';
import 'package:movie_app/src/configs/configs.dart';
import 'package:movie_app/src/controllers/auth_v3_controller.dart';
import 'package:movie_app/src/controllers/configuration_controller.dart';
import 'package:movie_app/src/utils/auth.dart';

class UserProfile extends StatelessWidget {
  UserProfile({Key? key}) : super(key: key);

  final _authV3Controller = Get.find<AuthV3Controller>();
  final _configController = Get.find<ConfigurationController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryWhite,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // poster
            ClipRRect(
              borderRadius: BorderRadius.circular(60),
              child: Auth().userAvatar == null
                  ? Container(
                      alignment: Alignment.center,
                      width: 104,
                      height: 104,
                      color: primaryblue,
                      child: const Icon(
                        Icons.person,
                        color: primaryWhite,
                        size: 56,
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        Auth().userAvatar == null || Auth().userAvatar == ""
                            ? null
                            : Get.toNamed('/poster_preview',
                                arguments: {"filePath": Auth().userAvatar});
                      },
                      child: CachedNetworkImage(
                        width: 104,
                        height: 104,
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
            ),
            const SizedBox(width: 22),
            Text(
              Auth().username ?? 'username',
              style: TextStyle(
                fontSize: l,
                fontWeight: FontWeight.w700,
                color: primaryDarkBlue.withOpacity(
                  0.8,
                ),
              ),
            ),
            const SizedBox(width: 18),

            // profile details
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Profile',
                        style: TextStyle(
                          fontSize: n,
                          fontWeight: FontWeight.w600,
                          color: primaryDarkBlue.withOpacity(
                            0.8,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(thickness: 1.2),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Full Name',
                          style: TextStyle(
                            fontSize: n,
                            fontWeight: FontWeight.w600,
                            color: primaryDarkBlue.withOpacity(
                              0.6,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          Auth().fullname ?? 'Fullname',
                          style: TextStyle(
                            fontSize: n,
                            fontWeight: FontWeight.w600,
                            color: primaryDarkBlue.withOpacity(
                              0.8,
                            ),
                          ),
                        ),
                      ),
                    ],
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
