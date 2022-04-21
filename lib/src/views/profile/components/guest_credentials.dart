import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../configs/configs.dart';
import '../../../controllers/auth_v3_controller.dart';

class GuestUserCredientials extends GetView<AuthV3Controller> {
  const GuestUserCredientials({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
            controller.logoutV3();
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
}
