import 'package:artefaqt/components/app_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late RiveAnimationController _controller;
  late RiveAnimationController _jumpController;

  @override
  void initState() {
    super.initState();
    _controller = SimpleAnimation('Run');
    _jumpController = OneShotAnimation('Jump');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
          onTap: () {
            setState(() {
              _jumpController.isActive = true;
              _controller.isActive = true;
            });
          },
          child: Center(
              child: Transform.scale(
                  scale: kIsWeb ? 1 : 1.8,
                  child: RiveAnimation.asset(
                    'assets/jump-man.riv',
                    controllers: [_controller, _jumpController],
                    // animations: ['Run', 'Jump'],
                    onInit: (_) => setState(() {
                      _jumpController.isActive = false;
                    }),
                  )))),
      appBar: const CustomAppBar(title: 'Detail View'),
    );
  }
}
