import 'package:flutter/material.dart';

// title widget
class SABT extends StatefulWidget {
  final Widget child;

  const SABT({
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  _SABTState createState() => _SABTState();
}

class _SABTState extends State<SABT> {
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
    return Visibility(
      visible: _visible!,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 300),
        opacity: 1,
        curve: Curves.easeIn,
        child: widget.child,
      ),
    );
  }
}
