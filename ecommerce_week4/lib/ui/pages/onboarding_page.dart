part of 'pages.dart';

///This is onboarding screen
class OnboardingPage extends StatefulWidget {
  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  List<Slide> slides = new List();

  Function goToTab;

  @override
  void initState() {
    super.initState();

    slides.add(Slide(
      title: "Fish Shop",
      styleTitle: GoogleFonts.poppins(
          color: Colors.blue, fontSize: 20, fontWeight: FontWeight.bold),
      description: "Makes it easy for you to shop for fish",
      pathImage: "assets/cart.png",
    ));
    slides.add(Slide(
      title: "Fish Shop",
      styleTitle: GoogleFonts.poppins(
          color: Colors.blue, fontSize: 20, fontWeight: FontWeight.bold),
      description:
          "Fish from the shelter makes this fish fresh",
      pathImage: "assets/mancing.png",
    ));
    slides.add(Slide(
      title: "Fish Shop",
      styleTitle: GoogleFonts.poppins(
          color: Colors.blue, fontSize: 20, fontWeight: FontWeight.bold),
      description: "Let's go shopping for fish right now",
      pathImage: "assets/pelihara.png",
    ));
  }

  void onDonePress() {
    Get.off(LoginPage());
  }

  void onSkipPress() {
    this.goToTab(0);
  }

  Widget renderNextButton() {
    return Text(
      "Next",
      style: GoogleFonts.poppins(fontSize: 15, color: Colors.white),
    );
  }

  Widget renderDoneButton() {
    return Text(
      "DONE",
      style: GoogleFonts.poppins(fontSize: 15, color: Colors.white),
    );
  }

  Widget renderSkipButton() {
    return Text(
      "SKIP",
      style: GoogleFonts.poppins(fontSize: 15, color: Colors.white),
    );
  }

  List<Widget> renderListCustomTabs() {
    List<Widget> tabs = new List();
    for (int i = 0; i < slides.length; i++) {
      Slide currentSlide = slides[i];
      tabs.add(Container(
        width: double.infinity,
        height: double.infinity,
        child: Container(
          margin: EdgeInsets.only(bottom: 60.0, top: 60.0),
          child: ListView(
            children: <Widget>[
              GestureDetector(
                  child: Image.asset(
                currentSlide.pathImage,
                width: 200.0,
                height: 200.0,
                fit: BoxFit.contain,
              )),
              Container(
                child: Text(
                  currentSlide.title,
                  style: currentSlide.styleTitle,
                  textAlign: TextAlign.center,
                ),
                margin: EdgeInsets.only(top: 20.0),
              ),
              Container(
                child: Text(
                  currentSlide.description,
                  style: currentSlide.styleDescription,
                  textAlign: TextAlign.center,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
                margin: EdgeInsets.only(top: 20.0),
              ),
            ],
          ),
        ),
      ));
    }
    return tabs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroSlider(
        //List Slider
        slides: this.slides,

        //Skip Button
        renderSkipBtn: this.renderSkipButton(),
        colorSkipBtn: Colors.blue,
        highlightColorSkipBtn: Colors.blue,

        //Next Button
        renderNextBtn: this.renderNextButton(),

        //Done Button
        renderDoneBtn: this.renderDoneButton(),
        onDonePress: this.onDonePress,
        colorDoneBtn: Colors.red,
        highlightColorDoneBtn: Colors.blue,
        //Dot Indicator
        colorDot: Colors.grey,
        colorActiveDot: Colors.blue,
        sizeDot: 10,

        //tabs
        listCustomTabs: this.renderListCustomTabs(),
        backgroundColorAllSlides: Colors.white,
        refFuncGoToTab: (refFunc) {
          this.goToTab = refFunc;
        },

        //show hide status bar
        shouldHideStatusBar: true,

        //onTab complate
      ),
    );
  }
}
