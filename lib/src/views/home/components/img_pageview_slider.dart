import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/src/configs/configs.dart';
import 'package:movie_app/src/controllers/utility_controller.dart';
import 'package:movie_app/src/global_components/switch_btn.dart';

import 'img_slider.dart';

Widget imgPageViewSliderBuilder({
  String? object,
  double? height,
  EdgeInsetsGeometry? padding,
  BorderRadius? borderRadius,
}) {
  final _utilityController = Get.find<UtilityController>();

  return Container(
    decoration: BoxDecoration(
      borderRadius: borderRadius ?? BorderRadius.circular(4),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Text(
                  'Trending',
                  style: TextStyle(fontSize: m),
                ),
                const SizedBox(width: 12),
                switchBtnBuilder(
                  text1: "Today",
                  text2: "Week",
                ),
              ],
            ),
            const Text('More'),
          ],
        ),
        const SizedBox(height: 8),
        Stack(
          alignment: AlignmentDirectional.center,
          children: [
            SizedBox(
              height: height ?? 190,
              child: Obx(
                () => PageView.builder(
                  physics: const BouncingScrollPhysics(),
                  controller: _utilityController.controller,
                  itemCount: imgUrl.length,
                  itemBuilder: (context, index) {
                    _utilityController.setSliderIndex(index);
                    return Container(
                      padding: padding ?? const EdgeInsets.fromLTRB(6, 6, 6, 6),
                      child: ClipRRect(
                        borderRadius: borderRadius ?? BorderRadius.circular(4),
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: imgUrl[index],
                          placeholder: (context, url) => Container(
                            color: Colors.black12,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Positioned(
              right: 0,
              child: navBtn(
                utilityController: _utilityController,
                icon: Icons.arrow_forward_ios,
                event: ImgSliderEvents.forward,
              ),
            ),
            Positioned(
              left: 0,
              child: navBtn(
                utilityController: _utilityController,
                icon: Icons.arrow_back_ios,
                event: ImgSliderEvents.backward,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

// btn helper
Widget navBtn({
  required UtilityController utilityController,
  required ImgSliderEvents event,
  IconData? icon,
  Color? color,
}) =>
    IconButton(
      onPressed: () {
        utilityController.toggleImgSlider(
          toggleEvent: event,
          currentIndex: utilityController.imgSliderIndex,
          length: imgUrl.length,
        );
      },
      icon: Icon(
        icon ?? Icons.flutter_dash,
        color: color ?? primaryWhite,
      ),
    );
