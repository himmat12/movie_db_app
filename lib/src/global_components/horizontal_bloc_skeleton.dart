import 'package:flutter/material.dart';

Widget horizontalBlocSkeleton() {
  return Container(
    margin: const EdgeInsets.fromLTRB(6, 6, 6, 6),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              height: 20,
              width: 120,
              color: Colors.black26,
            ),
            const SizedBox(width: 12),
            Container(
              height: 20,
              width: 60,
              color: Colors.black26,
            ),
          ],
        ),
        const SizedBox(height: 12),
        SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              5,
              (index) => Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 6, 0),
                decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(4),
                ),
                height: 120,
                width: 86,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
