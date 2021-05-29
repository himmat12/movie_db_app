import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

Widget bottomNavSkeleton() {
  return Shimmer.fromColors(
    baseColor: Colors.black26,
    highlightColor: Colors.blueGrey.shade50,
    child: Container(
      height: 60,
      margin: const EdgeInsets.fromLTRB(6, 6, 6, 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          4,
          (index) => Container(
            height: 22,
            width: MediaQuery.of(Get.context!).size.width / 5,
            color: Colors.black26,
          ),
        ),
      ),
    ),
  );
}
