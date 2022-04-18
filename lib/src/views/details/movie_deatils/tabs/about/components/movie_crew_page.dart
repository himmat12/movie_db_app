import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../configs/configs.dart';
import '../../../../../../controllers/configuration_controller.dart';
import '../../../../../../controllers/details_controller.dart';
import '../../../../../../controllers/people_controller.dart';
import '../../../../../../mixins/avatar.dart';
import '../../../../../../models/details/common_details_models.dart';

class MovieCrewPage extends StatelessWidget with AvatarBuilderMixin {
  final _detailsController = Get.find<DetailsController>();
  final _configurationController = Get.find<ConfigurationController>();
  final _peopleController = Get.find<PeopleController>();

  MovieCrewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.5,
          title:
              Text(_detailsController.movieDetail.value.title ?? "movie title"),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: _detailsController.credits.value.crew == null ||
                    _detailsController.credits.value.crew!.isEmpty
                ? SizedBox(
                    height: 80,
                    child: Center(
                      child: Text(
                        'No Crews To Feature at the Moment',
                        style:
                            TextStyle(color: primaryDarkBlue.withOpacity(0.6)),
                      ),
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 18),
                        child: Text(
                          '${_detailsController.credits.value.crew == null ? 0 : _detailsController.credits.value.crew!.length} Persons',
                          style: TextStyle(
                            color: primaryDarkBlue.withOpacity(0.7),
                            fontSize: n,
                          ),
                        ),
                      ),
                      ListView.separated(
                        itemCount: _detailsController.credits.value.crew == null
                            ? 0
                            : _detailsController.credits.value.crew!.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 8),
                        itemBuilder: (context, index) {
                          Crew crew =
                              _detailsController.credits.value.crew![index];

                          return InkWell(
                            onTap: () {
                              _peopleController.setPersonId(crew.id!);
                              Get.toNamed('/people_details');
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 16),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: crew.profilePath == null
                                        ? avatarBuilder()
                                        : CachedNetworkImage(
                                            height: 68,
                                            width: 68,
                                            imageUrl:
                                                '${_configurationController.posterUrl}${crew.profilePath}',
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) =>
                                                Container(
                                                    color: Colors.black26),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Container(
                                              color: Colors.black38,
                                              child: const Center(
                                                child: Icon(
                                                  Icons.error_outline,
                                                  color: primaryWhite,
                                                  size: 34,
                                                ),
                                              ),
                                            ),
                                          ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          crew.name ?? "name",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: m - 4,
                                            color: primaryDarkBlue
                                                .withOpacity(0.7),
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        Text(
                                          crew.job ?? "job",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: n - 2,
                                            color: primaryDarkBlue
                                                .withOpacity(0.6),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 80),
                    ],
                  ),
          ),
        ));
  }
}
