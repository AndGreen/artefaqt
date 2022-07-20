import 'package:artefaqt/services/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  Widget build(BuildContext context) {
    final page = PageViewModel(
      title: "Title of first page",
      body:
          "Here you can write the description of the page, to explain someting...",
      image: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
        child: Center(child: Image.network("https://picsum.photos/200/300")),
      ),
    );

    return IntroductionScreen(
      pages: [page, page, page],
      done: const Text("Done", style: TextStyle(fontWeight: FontWeight.w600)),
      // showNextButton: false,
      next: const Text("Next"),
      onDone: () async {
        await GetIt.I<SharedPreferences>().setBool(isOnboardingPref, true);
        if (!mounted) return;
        Navigator.of(context)
          ..pop() // remove onboard
          ..popAndPushNamed('/');
      },
    );
  }
}
