import 'package:flutter/material.dart';
import 'package:movie_app/src/configs/configs.dart';
import 'package:movie_app/src/controllers/base_controller.dart';

import 'loading_spinner.dart';

Widget addMorePaginationBtn(
    {required void Function()? onTap, required ViewState viewState}) {
  return GestureDetector(
    onTap: onTap,
    child: Column(
      children: [
        Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Container(
              width: 88,
              height: 140,
              alignment: Alignment.center,
              padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
              decoration: BoxDecoration(
                color: Colors.black38,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            Center(
              child: viewState == ViewState.busy
                  ? LoadingSpinner.fadingCircleSpinner
                  : const Icon(
                      Icons.add,
                      size: 34,
                      color: primaryWhite,
                    ),
            )
          ],
        ),
        const Text("\n"), //for spacing to match with other cards
      ],
    ),
  );
}
