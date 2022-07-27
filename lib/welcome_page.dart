import 'package:flutter/foundation.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter/material.dart';
import 'package:tracking_project/signUp/signUpPage.dart';
import 'main.dart';
import 'package:tracking_project/SecondPage.dart';
import 'package:tracking_project/FirstPage.dart';
import 'package:tracking_project/signUp/SignedUp.dart';



class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {

  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => zeroPage()),
    );
  }

  Widget _buildFullscreenImage() {
    return Image.asset(
      'assets/images/Pay-attention-amico.png',
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    );
  }

  Widget _buildImage(String assetName, [double width = 250]) {
    return Image.asset('assets/images/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      globalHeader: Align(
        alignment: Alignment.topLeft,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 16, left: 16),
            child: _buildImage('location.png', 40),
          ),
        ),
      ),


      globalFooter: SizedBox(
        width: double.infinity,
        height: 60,
        child: ElevatedButton(
          child: const Text(
            'Let\'s go right away!',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),

          ),
          onPressed: () => _onIntroEnd(context),
            style: ElevatedButton.styleFrom(
            primary: Colors.grey)
        ),
      ),
      pages: [
      PageViewModel(
      title: "Welcome to TrackAI App!",
      body:
      "This mobile app is for inspecting and analysis any problem or damage in concrete.",
      image: _buildImage('Pay attention-amico.png'),
      decoration: pageDecoration,
      ),
        PageViewModel(
          title: "Repair",
          body:
          "Help us to find the place of pavement failure, cracking, road defects, etc..",
          image: _buildImage('Construction-bro.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Inspect",
          body:
          "By uploading a video or a photo for your journey , we will be able to find places of cracking concrete and ground defects! ",
          image: _buildImage('tracking.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Find Defects",
          body:
          "Working 24/7 to improve our infrastructure!\n Make sure you have accessed your Location and camera " ,
          image: _buildImage('Location tracking-cuate.png'),
          decoration: pageDecoration.copyWith(
           // contentMargin: const EdgeInsets.symmetric(horizontal: 16),
            //fullScreen: true,
            //bodyFlex: 2,
            //imageFlex: 3,
          ),
        ),




      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: false,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: true,
      //rtl: true, // Display as right-to-left
      back: const Icon(Icons.arrow_back,color: Colors.black54),
      skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600)),
      next: const Icon(Icons.arrow_forward,color: Colors.black54,),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black54)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Colors.transparent,
        activeSize: Size(22.0, 10.0),
        activeColor: Colors.amber,
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}
