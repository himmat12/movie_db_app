import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/src/configs/configs.dart';
import 'package:movie_app/src/controllers/download_controller.dart';
import 'package:movie_app/src/utils/auth.dart';

Widget appBarBuilder({
  void Function()? onSearchTap,
  double? height,
  EdgeInsetsGeometry? padding,
  String? object,
}) {
  return Container(
    padding: padding ?? const EdgeInsets.fromLTRB(12, 0, 12, 0),
    // color: primaryDarkBlue,
    height: height ?? 66,
    child: Row(
      children: [
        Container(
          height: 36,
          width: 36,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: CachedNetworkImageProvider(
                object ??
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRQwWMJbZoZ26ZyYB8M-1e7OLBVUWXRLNSO6A&usqp=CAU',
              ),
            ),
          ),
        ),
        const Expanded(
          child: Text(
            'Movie DB',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: l,
              // color: primaryWhite,
              color: primaryDarkBlue,
            ),
          ),
        ),
        IconButton(
            onPressed: onSearchTap ??
                () {
                  print(Auth().isGuestLoggedIn
                      ? Auth().guestSessionId
                      : 'guest not logged in');

                  DownloadController().downloadFile(
                      url:
                          'https://img.youtube.com/vi/gmRKv7n2If8/hqdefault.jpg');
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
