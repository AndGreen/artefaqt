import 'package:artefaqt/components/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:rive/rive.dart';

import '../models/item.dart';

class DetailArguments {
  final Item item;

  DetailArguments({
    required this.item,
  });
}

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  SMITrigger? _controller;

  void _onRiveInit(Artboard artboard) {
    final controller = StateMachineController.fromArtboard(artboard, 'Motion');
    artboard.addController(controller!);
    _controller = controller.findInput<bool>('Skin') as SMITrigger;
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as DetailArguments;

    return Scaffold(
        appBar: CustomAppBar(
          title: args.item.title,
        ),
        body: GestureDetector(
          onTap: () {
            setState(() {
              _controller?.fire();
            });
          },
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: RatingBar.builder(
                initialRating: args.item.rating,
                minRating: 1,
                glow: false,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                ignoreGestures: true,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ConstrainedBox(
                constraints: const BoxConstraints(minHeight: 250),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Center(
                        child: args.item.comment.isNotEmpty
                            ? Text(args.item.comment,
                                style: const TextStyle(fontSize: 16))
                            : const Text(
                                '🤷‍♂️',
                                style: TextStyle(fontSize: 30),
                              )),
                  ),
                ),
              ),
            ),
          ]),
        ));
  }
}
