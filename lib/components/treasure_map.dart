import 'package:flutter/material.dart';

class TreasureMap extends StatelessWidget {
  const TreasureMap({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
            height: 140,
            child: Center(
              child: Text('Start your journey',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 23,
                      color: Theme.of(context).highlightColor)),
            )),
        Opacity(
            opacity: 0.3,
            child: Center(child: Image.asset('assets/empty_map.png'))),
      ],
    );
  }
}
