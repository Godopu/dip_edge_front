import 'package:dip_edge_front/const.dart';
import 'package:flutter/material.dart';

var colors = [
  [Colors.orange, Colors.pink],
  [Colors.purple, Colors.blue],
  [Colors.green.withAlpha(100), Colors.green],
];

Future<String?> makeServiceScreenDialog(
  BuildContext context,
) async {
  var result = await showDialog(
    builder: (context) => AlertDialog(
      // title: const Text('Title'),
      backgroundColor: Theme.of(context).colorScheme.surface.withOpacity(0.9),
      elevation: 5,
      content: SizedBox(
        width: 1000,
        height: 700,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // header
              children: [
                Text(
                  'Service: dip-object-tracking',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white.withAlpha(230),
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: IconButton(
                    icon: const Icon(
                      Icons.cancel,
                      size: 30,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                )
              ],
            ),
            const SizedBox(height: defaultPadding),
          ],
        ),
      ),
    ),
    context: context,
  );

  return result;
}

Widget _makeRichText(BuildContext context, String key, String value) {
  return RichText(
    text: TextSpan(
      text: key,
      style: Theme.of(context).textTheme.headlineMedium!.copyWith(
            color: Colors.white,
            fontSize: 22,
          ),
      children: [
        TextSpan(
          text: value,
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                color: Colors.white,
                // fontWeight: FontWeight.w900,
                fontSize: 18,
              ),
        ),
      ],
    ),
  );
}
