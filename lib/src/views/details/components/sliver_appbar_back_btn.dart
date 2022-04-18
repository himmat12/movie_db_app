import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../configs/color_config.dart';

// title widget
class SABTN extends StatefulWidget {
  final void Function()? onBack;

  const SABTN({Key? key, this.onBack}) : super(key: key);

  @override
  _SABTNState createState() => _SABTNState();
}

class _SABTNState extends State<SABTN> {
  ScrollPosition? _position;
  bool? _visible;

  @override
  void dispose() {
    _removeListener();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _removeListener();
    _addListener();
  }

  void _addListener() {
    _position = Scrollable.of(context)?.position;
    _position?.addListener(_positionListener);
    _positionListener();
  }

  void _removeListener() {
    _position?.removeListener(_positionListener);
  }

  void _positionListener() {
    final FlexibleSpaceBarSettings? settings =
        context.dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>();
    bool visible =
        settings == null || settings.currentExtent <= settings.minExtent;
    if (_visible != visible) {
      setState(() {
        _visible = visible;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      opacity: 1,
      curve: Curves.easeIn,
      child: IconButton(
        onPressed: widget.onBack ??
            () {
              Get.back();
            },
        icon: Icon(
          Icons.arrow_back,
          color: _visible == false ? primaryWhite : primaryDarkBlue,
        ),
      ),
    );
  }
}
