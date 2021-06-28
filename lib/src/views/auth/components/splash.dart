import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_app/src/configs/configs.dart';

class SplashComponent extends StatelessWidget {
  const SplashComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                const Text(
                  'Movie Database Archive',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: l + 6,
                    fontWeight: FontWeight.w700,
                    color: primaryDarkBlue,
                  ),
                ),
                SvgPicture.asset(
                  'assets/movie.svg',
                  height: 400,
                  fit: BoxFit.scaleDown,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
