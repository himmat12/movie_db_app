import 'package:flutter/material.dart';
import 'package:movie_app/src/configs/configs.dart';

class AuthBtn extends StatelessWidget {
  const AuthBtn({
    Key? key,
    this.onTap,
    this.title,
    this.btnColor,
  }) : super(key: key);

  final void Function()? onTap;
  final String? title;
  final Color? btnColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // width: 120,
        margin: const EdgeInsets.symmetric(horizontal: 18),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: btnColor ?? primaryblue,
          borderRadius: BorderRadius.circular(2),
        ),
        child: Text(
          // _authV3Controller.sessionState == ViewState.busy
          //     ? 'Authunticating ...'
          //     :
          title ?? 'Sign In',
          style: const TextStyle(
            fontSize: m - 4,
            color: primaryWhite,
          ),
        ),
      ),
    );
  }
}
