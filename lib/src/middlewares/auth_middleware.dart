import 'package:flutter/cupertino.dart';
import 'package:get/get_navigation/src/routes/route_middleware.dart';

import '../utils/auth.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) =>
      Auth().isLoggedIn ? const RouteSettings(name: "/dashboard") : null;
}
