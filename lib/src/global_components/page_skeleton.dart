import 'package:flutter/material.dart';
import 'package:movie_app/src/global_components/horizontal_bloc_skeleton.dart';

Widget pageSkeleton() {
  return SingleChildScrollView(
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
  );
}
