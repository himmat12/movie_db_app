import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../configs/configs.dart';
import '../../../controllers/utility_controller.dart';
import '../../../models/details/common_details_models.dart';

class ReviewBuilder extends StatefulWidget {
  final ReviewsResult review;
  const ReviewBuilder({
    required this.review,
    Key? key,
  }) : super(key: key);

  @override
  _ReviewBuilderState createState() => _ReviewBuilderState();
}

class _ReviewBuilderState extends State<ReviewBuilder> {
  final _utilityController = Get.find<UtilityController>();

  bool _isHidden = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: primaryDarkBlue.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.review.author ?? 'Author',
                style: TextStyle(
                  color: primaryDarkBlue.withOpacity(0.8),
                  fontSize: n,
                ),
              ),
              GestureDetector(
                onTap: () {
                  _utilityController.loadUrl(url: widget.review.url ?? "#");
                },
                child: const Icon(
                  Icons.launch,
                  color: primaryblue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _isHidden != false
              ? Text(
                  widget.review.content ?? "contents",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: primaryDarkBlue.withOpacity(0.6),
                    fontSize: n - 2,
                  ),
                )
              : Text(
                  widget.review.content ?? "contents",
                  style: TextStyle(
                    color: primaryDarkBlue.withOpacity(0.6),
                    fontSize: n - 2,
                  ),
                ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isHidden = !_isHidden;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.fromLTRB(4, 2, 4, 2),
                  color: Colors.transparent,
                  child: Text(
                    _isHidden != false ? 'More' : 'Less',
                    style: const TextStyle(
                      color: primaryblue,
                      fontSize: n - 2,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
