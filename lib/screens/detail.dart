import 'package:artefaqt/components/app_bar.dart';
import 'package:artefaqt/model.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

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
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(height: 10),
                Text(args.item.comment, style: const TextStyle(fontSize: 16)),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: Transform.scale(
                        scale: 3,
                        child: SizedBox(
                            height: 300,
                            child: RiveAnimation.asset(
                              'assets/skins.riv',
                              fit: BoxFit.cover,
                              onInit: _onRiveInit,
                            ))))
              ]),
        ));
  }
}
