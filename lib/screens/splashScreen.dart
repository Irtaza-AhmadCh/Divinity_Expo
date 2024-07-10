import 'package:firebase_auth/firebase_auth.dart';
import 'getstart.dart';
import '../Paths/imports.dart';


class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final _userstate = _auth.currentUser;
    if(_userstate== null){
    Timer(Duration(seconds: 4),
        (){
      NavigateToReplace(context, GetstartScreen());
        });}
    else{
      Timer(Duration(seconds: 4),
              (){
            NavigateToReplace(context, NavigationbarScreen());
          });}
    }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Stack(
        children: [ Container(
          width: double.maxFinite,
          child: Image.asset('assets/Splash_bg/bg.png', fit:  BoxFit.cover, ),
        ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  width: 133,
                  height: 96,
                  child:
                    Image.asset('assets/splash_screen_main_logo/logo.png',scale: 1,   )

                ),
              ),
              SizedBox(height: 8,),
              Center(
                child: Container(
                    width: 123,
                    height: 63,
                    child:
                    Image.asset('assets/Divinity_logo/logo.png',scale: 1,  )

                ),
              ),
            ],
          )
        ]
      ),
    );
  }
}
