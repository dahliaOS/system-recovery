import "package:flutter/material.dart";

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool showAtStartup = true;
  final bool _isDarkMode = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("hi");

        Navigator.pop(context);
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          color: Colors.transparent,
          child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                decoration: BoxDecoration(
                  color: _isDarkMode ? const Color(0xFF1e1e1e) : Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                  /*boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 10,
                          blurRadius: 7,
                          offset: Offset(0, 0),
                        ),
                      ],*/
                ),
                width: 640,
                height: 480,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Image.asset(
                        _isDarkMode
                            ? 'assets/images/other/developer-dark.png'
                            : 'assets/images/other/developer-white.png',
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.high,
                        height: 256,
                        width: 256,
                      ),
                    ),
                    Positioned(
                      top: 40,
                      left: 40,
                      child: Image.asset(
                        _isDarkMode
                            ? 'assets/images/logos/dahliaOS-white.png'
                            : 'assets/images/logos/dahliaOS-modern.png',
                        filterQuality: FilterQuality.high,
                        fit: BoxFit.cover,
                        height: 32,
                      ),
                    ),
                    Positioned(
                      top: 132,
                      left: 40,
                      width: 368,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Welcome!",
                            style: TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.w100,
                              fontFamily: "Roboto",
                            ),
                          ),
                          Text(
                            "\nFor now, dahliaOS is pre-release software. Some features are incomplete, applications may not work as expected, and the experience may not be stable on certain devices. \n\nWe are always looking to improve our software, so feel free to share feedback with us on any of our social media. Have fun!",
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: "Roboto",
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 30,
                      left: 30,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Checkbox(
                            value: showAtStartup,
                            onChanged: (val) {
                              setState(() {
                                showAtStartup = !showAtStartup;
                              });
                            },
                          ),
                          const Text("Show at every startup"),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 30,
                      right: 30,
                      child: ElevatedButton(
                        onPressed: () {
                          print("hi");

                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: const Text("LET'S GO!"),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      /*BoxSurface(
        borderRadius: context.commonData.borderRadiusBig,
        margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width / 3.75,
          vertical: MediaQuery.of(context).size.height / 4.5,
        ),
        child: Material(
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/logos/pangolin.png", scale: 8),
              const SizedBox(
                height: 24,
              ),
              const Text(
                "Welcome to Pangolin!",
                style: TextStyle(fontSize: 28),
              ),
              const SizedBox(
                height: 24,
              ),
              const Text(
                "Note: This is a pre release version of the Desktop. Some features may not work properly yet.",
              ),
              const SizedBox(
                height: 32,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    value: showAtStartup,
                    onChanged: (val) {
                      setState(() {
                        showAtStartup = !showAtStartup;
                      });
                    },
                  ),
                  const Text("Show at every startup"),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              ElevatedButton(
                onPressed: () {
                  DatabaseManager.set("initialStart", showAtStartup);

                  Navigator.pop(context);
                },
                child: Padding(
                  padding: ThemeConstants.buttonPadding,
                  child: const Text("Continue"),
                ),
              ),
            ],
          ),
        ),
      ),*/
    );
  }
}