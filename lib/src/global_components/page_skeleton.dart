import 'package:flutter/material.dart';
import 'package:movie_app/src/configs/color_config.dart';
import 'package:movie_app/src/global_components/horizontal_bloc_skeleton.dart';
import 'package:shimmer/shimmer.dart';

Widget pageSkeleton() {
  return SingleChildScrollView(
    child: Shimmer.fromColors(
      // period: const Duration(seconds: 2),
      baseColor: Colors.black26,
      highlightColor: Colors.blueGrey.shade50,
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 80),
            horizontalBlocSkeleton(),
            const SizedBox(height: 22),
            horizontalBlocSkeleton(),
            const SizedBox(height: 22),
            horizontalBlocSkeleton(),
            const SizedBox(height: 22),
            horizontalBlocSkeleton(),
            const SizedBox(height: 22),
            horizontalBlocSkeleton(),
            const SizedBox(height: 22),
          ],
        ),
      ),
    ),
  );
}
