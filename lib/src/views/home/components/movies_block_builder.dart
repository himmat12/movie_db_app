import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/src/configs/configs.dart';
import 'package:movie_app/src/global_components/more_btn.dart';
import 'package:movie_app/src/global_components/switch_btn.dart';
import 'package:movie_app/src/models/movie_result_model.dart';

Widget moviesBlockBuilder({
  String? title,
  required String posterUrl,
  required List<MovieResultModel> movies,
  void Function()? onMoreTap,
}) {
  return SizedBox(
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  title ?? 'title',
                  style: const TextStyle(fontSize: m),
                ),
                const SizedBox(width: 6),
                switchBtnBuilder(
                  text1: "Today",
                  text2: "This Week",
                ),
              ],
            ),
            moreBtn(onTap: onMoreTap ?? () {}),
          ],
        ),
        Container(
          height: 180,
          child: ListView.separated(
            itemCount: movies.length,
            separatorBuilder: (context, index) => const SizedBox(width: 6),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              MovieResultModel movie = movies[index];
              return ClipRRect(
                // borderRadius: BorderRadius.circular(4),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: "$posterUrl${movie.posterPath}",
                  placeholder: (context, url) => Container(
                    color: Colors.black12,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    ),
  );
}
