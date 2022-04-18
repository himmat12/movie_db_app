import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'horizontal_bloc_skeleton.dart';

Widget pageSkeleton() {
  return SingleChildScrollView(
    child: Shimmer.fromColors(
      // period: const Duration(seconds: 2),
      baseColor: Colors.black26,
      highlightColor: Colors.blueGrey.shade50,
      child: Column(
        children: [
          SizedBox(
            height: 80,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 46,
                    width: 46,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black26,
                    ),
                  ),
                  Container(
                    height: 22,
                    width: 130,
                    color: Colors.black26,
                  ),
                  Container(
                    height: 30,
                    width: 30,
                    decoration: const BoxDecoration(
                      // shape: BoxShape.circle,
                      color: Colors.black26,
                    ),
                  ),
                ]),
          ),
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
  );
}
