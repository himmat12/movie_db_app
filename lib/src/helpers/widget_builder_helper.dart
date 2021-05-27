import 'package:flutter/material.dart';
import 'package:movie_app/src/controllers/base_controller.dart';

class WidgetBuilderHelper extends StatelessWidget {
  final ViewState state;
  final Widget onLoadingBuilder;
  final Widget onSuccessBuilder;
  final Widget onErrorBuilder;

  const WidgetBuilderHelper({
    Key? key,
    required this.state,
    required this.onLoadingBuilder,
    required this.onSuccessBuilder,
    required this.onErrorBuilder,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    switch (state) {
      case ViewState.busy:
        return onLoadingBuilder;

      case ViewState.error:
        return onErrorBuilder;

      case ViewState.retrived:
        break;

      default:
        break;
    }
    return onSuccessBuilder;
  }
}
