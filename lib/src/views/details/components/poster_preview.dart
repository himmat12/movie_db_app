import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../configs/configs.dart';
import '../../../controllers/base_controller.dart';
import '../../../controllers/details_controller.dart';
import '../../../controllers/download_controller.dart';
import '../../../controllers/utility_controller.dart';
import '../../../global/loading_spinner.dart';

class PosterPreview extends StatefulWidget {
  const PosterPreview({required this.filePath, Key? key}) : super(key: key);

  final String filePath;

  @override
  _PosterPreviewState createState() => _PosterPreviewState();
}

class _PosterPreviewState extends State<PosterPreview> {
  final _detailsController = Get.find<DetailsController>();
  final _downloadController = Get.find<DownloadController>();
  final _utilityController = Get.find<UtilityController>();

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    _downloadController.setFileUrl(widget.filePath);
    _downloadController.resetDownloadState();

    print(_downloadController.filePath.value);
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryDarkBlue,
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          _detailsController.images.value.posters == null
              ? const SizedBox.shrink()
              : Obx(
                  () => CachedNetworkImage(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    errorWidget: (context, url, error) => Container(
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: Colors.black12,
                      ),
                      child: const Icon(
                        Icons.error,
                        color: primaryWhite,
                      ),
                    ),
                    imageUrl:
                        'https://image.tmdb.org/t/p/original/${widget.filePath}',
                    placeholder: (context, url) =>
                        Container(color: Colors.black12),
                    fit: _downloadController.isExpanded.value == true
                        ? BoxFit.fitHeight
                        : BoxFit.scaleDown,
                  ),
                ),
          Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.4),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BackButton(
                  color: primaryWhite,
                  onPressed: () {
                    Get.back();
                  },
                ),
                Row(
                  children: [
                    // fullscreen/default screen
                    IconButton(
                      onPressed: () {
                        _downloadController.toggleExpanded();
                      },
                      icon: Obx(
                        () => Icon(
                          _downloadController.isExpanded.value == true
                              ? Icons.fullscreen_exit
                              : Icons.fullscreen,
                          size: 28,
                          color: primaryWhite,
                        ),
                      ),
                    ),

                    // share
                    IconButton(
                      onPressed: () {
                        _utilityController.shareIt(
                          'https://image.tmdb.org/t/p/original/${_downloadController.filePath}',
                        );
                      },
                      icon: const Icon(
                        Icons.share,
                        size: 22,
                        color: primaryWhite,
                      ),
                    ),

                    // download
                    IconButton(onPressed: () {
                      _downloadController.downloadFile(
                          url:
                              'https://image.tmdb.org/t/p/original/${_downloadController.filePath}');
                    }, icon: Obx(
                      () {
                        if (_downloadController.downloadState.value ==
                            ViewState.busy) {
                          return LoadingSpinner().miniFadingCircleSpinner;
                        } else if (_downloadController.downloadState.value ==
                            ViewState.retrived) {
                          return const Icon(
                            Icons.file_download_done,
                            color: primaryWhite,
                          );
                        }
                        return const Icon(
                          Icons.download,
                          color: primaryWhite,
                        );
                      },
                    )),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
