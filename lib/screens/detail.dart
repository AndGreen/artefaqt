import 'package:artefaqt/components/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

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
    return Scaffold(
      body: GestureDetector(
          onTap: () {
            setState(() {
              _controller?.fire();
            });
          },
          child: Center(
              child: Transform.scale(
                  scale: 1.8,
                  child: RiveAnimation.asset(
                    'assets/skins.riv',
                    fit: BoxFit.cover,
                    onInit: _onRiveInit,
                  )))),
      appBar: const CustomAppBar(title: 'Detail View'),
    );
  }
}
