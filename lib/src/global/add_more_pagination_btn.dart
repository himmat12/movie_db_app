import 'package:flutter/material.dart';

import '../configs/configs.dart';
import '../controllers/base_controller.dart';
import 'loading_spinner.dart';

class AddMorePaginationBtn extends StatelessWidget {
  const AddMorePaginationBtn({
    required this.onTap,
    required this.viewState,
    Key? key,
  }) : super(key: key);

  final void Function()? onTap;
  final ViewState viewState;

  @override
  Widget build(BuildContext context) {
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
                    ? LoadingSpinner().fadingCircleSpinner
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
}
