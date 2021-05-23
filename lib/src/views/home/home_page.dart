import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/src/controllers/utility_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomePage extends StatelessWidget {
  final _utilityController = Get.find<UtilityController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
      height: 200,
      child: Column(
        children: [
          SizedBox(
            height: 80,
            child: Row(
              children: [
                Container(
                  height: 36,
                  width: 36,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRQwWMJbZoZ26ZyYB8M-1e7OLBVUWXRLNSO6A&usqp=CAU'),
                    ),
                  ),
                ),
                const Text('Movie DB'),
                IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
