import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/src/controllers/configuration_controller.dart';

import '../../../configs/configs.dart';
import '../../../utils/auth.dart';

class AuthUserCredentials extends GetView<ConfigurationController> {
  const AuthUserCredentials({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
                      imageUrl: '${controller.profileUrl}/${Auth().userAvatar}',
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
  }
}
