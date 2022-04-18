import 'package:flutter/material.dart';

import '../controllers/base_controller.dart';

class WidgetBuilderHelper extends StatelessWidget {
  final ViewState state;
  final Widget onLoadingBuilder;
  final Widget onSuccessBuilder;
  final Widget onErrorBuilder;

  const WidgetBuilderHelper({
    required this.state,
    required this.onLoadingBuilder,
    required this.onSuccessBuilder,
    required this.onErrorBuilder,
    Key? key,
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
