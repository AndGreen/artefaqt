import 'package:artefaqt/components/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as DetailArguments;

    return Scaffold(
        appBar: CustomAppBar(
          title: args.item.title,
        ),
        body: Stack(
          children: [
            Positioned(
              bottom: 0,
              right: 0,
              child: SvgPicture.asset(height: 250, 'assets/dino_likes.svg'),
            ),
            Column(children: [
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
                  constraints: const BoxConstraints(maxHeight: 350),
                  child: Card(
                    child: MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      removeBottom: true,
                      child: Center(
                        child: Scrollbar(
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(20),
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
                    ),
                  ),
                ),
              ),
            ]),
          ],
        ));
  }
}
