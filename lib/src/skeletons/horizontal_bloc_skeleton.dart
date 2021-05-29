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
              (index) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 6, 0),
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    width: 88,
                    height: 140,
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 20,
                    width: 66,
                    color: Colors.black26,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
