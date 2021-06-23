import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestApiWidget extends StatefulWidget {
  const TestApiWidget({Key? key}) : super(key: key);

  @override
  _TestApiWidgetState createState() => _TestApiWidgetState();
}

class _TestApiWidgetState extends State<TestApiWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Test Api Widget'),
            test(),
            TextButton(
              onPressed: () {
                showLicensePage(
                  context: context,
                  applicationLegalese: 'himmat',
                  applicationName: 'movie db',
                );

                // showModalBottomSheet(
                //   context: context,
                //   builder: (context) => BottomSheet(
                //     onClosing: () {},
                //     builder: (context) => Column(
                //       children: const [
                //         Text('flutter bottom sheet'),
                //       ],
                //     ),
                //   ),
                //   constraints: BoxConstraints(
                //     minHeight: 120,
                //     maxHeight: 400,
                //     minWidth: 70,
                //     maxWidth: MediaQuery.of(context).size.width,
                //   ),
                // );
              },
              child: const Text('Show Api Service'),
            ),
          ],
        ),
      ),
    );
  }
}

Widget test() => TextButton(
      onPressed: () {
        Get.bottomSheet(BottomSheet(
          onClosing: () {},
          builder: (context) => Column(
            children: const [
              Text('getx bottom sheet'),
            ],
          ),
        ));
      },
      child: const Text('data'),
    );
