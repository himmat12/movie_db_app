import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:movie_app/src/configs/configs.dart';
import 'package:movie_app/src/global_components/switch_btn.dart';

Widget imgSliderBuilder({
  double? height,
  EdgeInsetsGeometry? padding,
  BorderRadius? borderRadius,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
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
            text2: "This Week",
          ),
        ],
      ),
      const SizedBox(height: 8),
      SizedBox(
        height: height ?? 180,
        width: MediaQuery.of(Get.context!).size.width,
        child: ClipRRect(
          borderRadius: borderRadius ?? BorderRadius.circular(4),
          child: CarouselSlider.builder(
            enableAutoSlider: true,
            initialPage: 0,
            itemCount: imgUrl.length,
            unlimitedMode: true,
            slideBuilder: (index) {
              return Container(
                padding: padding ?? const EdgeInsets.fromLTRB(6, 0, 6, 0),
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
    ],
  );
}

List<String> imgUrl = [
  "https://www.fiveaa.com.au/wp-content/uploads/2020/03/age-of-ultron-10-things-that-will-make-you-cry-in-avengers-age-of-ultron.jpeg",
  "https://i.pinimg.com/736x/cc/8e/ab/cc8eab463420d48b51f271bf886a14a8.jpg",
  "https://cdn.europosters.eu/image/750/posters/the-avengers-age-of-ultron-battle-i24581.jpg",
  "https://visualartideas.com/wp-content/uploads/2019/01/Avengers-Endgame-Wallpaper-Superhero.jpg",
];
