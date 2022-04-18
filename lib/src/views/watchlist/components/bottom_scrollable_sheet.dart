import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../configs/configs.dart';
import '../../../configs/strings.dart';
import '../../../controllers/account_controller.dart';
import '../../../controllers/results_controller.dart';
import '../../../models/results/movie_result_model.dart';

class BottomScrollableSheet extends StatelessWidget {
  BottomScrollableSheet({required this.movie, Key? key}) : super(key: key);

  final MovieResultModel movie;

  final _accountController = Get.find<AccountController>();
  final _resultController = Get.find<ResultsController>();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
      child: DraggableScrollableSheet(
        initialChildSize: 0.4,
        maxChildSize: 0.6,
        minChildSize: 0.2,
        expand: true,
        builder: (context, scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            child: Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                Container(
                  height: 220,
                  decoration: const BoxDecoration(
                    color: primaryWhite,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 22),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            movie.title ?? 'Movie',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: primaryDarkBlue.withOpacity(0.8),
                              fontSize: m - 4,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(height: 22),
                        expandedBtn(
                          onTap: () {
                            _accountController.postToWatchlist(
                              mediaType: movieString,
                              mediaId: int.parse(_resultController.movieId),
                              watchlist: false,
                            );
                            _accountController.getWatchlist(
                                mediaType: moviesString);
                          },
                          icon: Icons.bookmark_outline_rounded,
                          title: 'Remove from Watchlist',
                        ),
                        const SizedBox(height: 22),
                        // expandedBtn(
                        //   onTap: () {},
                        //   icon: Icons.favorite_outline,
                        //   title: 'Add to Favorites',
                        // ),
                      ],
                    ),
                  ),
                ),
                // exit btn
                Positioned(
                  top: 12,
                  right: 10,
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: primaryDarkBlue05,
                      ),
                      child: const Icon(
                        Icons.clear,
                        color: primaryWhite,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // helper expanded btn
  Widget expandedBtn({
    required IconData icon,
    void Function()? onTap,
    String title = "title",
  }) =>
      GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: primaryDarkBlue.withOpacity(0.8),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: primaryWhite,
                size: 28,
              ),
              const SizedBox(width: 18),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: m - 2,
                    color: primaryWhite,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
