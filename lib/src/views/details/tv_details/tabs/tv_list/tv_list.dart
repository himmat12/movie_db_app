import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controllers/configuration_controller.dart';
import '../../../../../global/tv_thumbnail_card.dart';
import '../../../../../mixins/avatar.dart';
import '../../../../../models/results/tv_result_model.dart';

class TvList extends StatelessWidget with AvatarBuilderMixin {
  final List<TvResultsModel> tv;
  final String? imageUrl;
  final void Function()? onLongPress;

  final _configurationController = Get.find<ConfigurationController>();

  TvList({required this.tv, this.onLongPress, Key? key, this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 28),
        GridView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: tv.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            mainAxisExtent: 186,
          ),
          itemBuilder: (context, index) => AbsorbPointer(
            absorbing: tv[index].posterPath == null ? true : false,
            child: tvThumbnailCard(
              onLongPress: onLongPress,
              padding: const EdgeInsets.all(0),
              tv: tv[index],
              imageUrl:
                  '${_configurationController.posterUrl}${tv[index].posterPath}',
            ),
          ),
        ),
      ],
    );
  }
}
