import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/src/configs/configs.dart';
import 'package:movie_app/src/controllers/configuration_controller.dart';
import 'package:movie_app/src/controllers/search_controller.dart';
import 'package:movie_app/src/controllers/utility_controller.dart';
import 'package:movie_app/src/mixins/avatar.dart';
import 'package:movie_app/src/utils/auth.dart';

class AppBarBuilder extends StatelessWidget with AvatarBuilderMixin {
  AppBarBuilder({this.height, this.padding, Key? key}) : super(key: key);

  // final void Function()? onSearchTap;
  final double? height;
  final EdgeInsetsGeometry? padding;

  final _configurationController = Get.find<ConfigurationController>();
  final _searchController = Get.find<SearchController>();
  final _utilityController = Get.find<UtilityController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.fromLTRB(12, 0, 12, 0),
      // color: primaryDarkBlue,
      height: 66,
      child: Row(
        children: [
          // avatar profile
          Auth().isGuestLoggedIn == true
              ? Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  decoration: BoxDecoration(
                    color: primaryDarkBlue,
                    borderRadius: BorderRadiusDirectional.circular(6),
                  ),
                  child: const Text(
                    'Guest*',
                    style: TextStyle(
                      fontSize: n - 2,
                      color: primaryblue,
                    ),
                  ),
                )
              : GestureDetector(
                  onTap: () {
                    Get.toNamed('/user_profile');
                  },
                  child: Container(
                    height: 46,
                    width: 46,
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: primaryblue05,
                      shape: BoxShape.circle,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Auth().userAvatar == null ||
                              Auth().userAvatar == ""
                          ? Container(
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                color: Colors.black12,
                              ),
                              child: const Icon(
                                Icons.person,
                                color: primaryWhite,
                              ),
                            )
                          : CachedNetworkImage(
                              imageUrl:
                                  '${_configurationController.profileUrl}${Auth().userAvatar}',
                              fit: BoxFit.scaleDown,
                              errorWidget: (context, url, error) => Container(
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                  color: Colors.black12,
                                ),
                                child: const Icon(
                                  Icons.person,
                                  color: primaryWhite,
                                ),
                              ),
                              placeholder: (context, url) => Container(
                                color: Colors.black12,
                              ),
                            ),
                    ),
                  ),
                ),
          const Expanded(
            child: Text(
              'TMDB Client',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: l,
                // color: primaryWhite,
                color: primaryDarkBlue,
              ),
            ),
          ),
          IconButton(
              onPressed: () {
                _utilityController.resetSearchTabbarState();
                _searchController.resetSearchState();
                Get.toNamed('/search');
                // print(Auth().isGuestLoggedIn
                //     ? Auth().guestSessionId
                //     : 'guest not logged in');

                // _accountController.getAccountDetails();

                // DownloadController().downloadFile(
                //     url:
                //         'https://img.youtube.com/vi/gmRKv7n2If8/hqdefault.jpg');
              },
              icon: const Icon(
                Icons.search,
                size: 26,
                color: primaryDarkBlue,
                // color: primaryWhite,
              )),
        ],
      ),
    );
  }
}
