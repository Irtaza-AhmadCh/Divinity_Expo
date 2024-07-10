import 'package:firebase_auth/firebase_auth.dart';
import '../FireBase/Auth.dart';
import 'SignUp.dart';
import 'forgetPassword.dart';
import '../Paths/imports.dart';


class LogInScreen extends StatefulWidget {
  LogInScreen({super.key});


  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  bool obscureText = false;
  TextEditingController emailController =TextEditingController();
  TextEditingController passwordController =TextEditingController();
  final _formKey = GlobalKey<FormState>();
 bool loader = false;
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width * (1 / 360);
    final h = MediaQuery.sizeOf(context).height * (1 / 760);


    return
      SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          SystemNavigator.pop();
          return true;
        },
        child: Scaffold(
          body: Stack(
            children: [
              Container(
                width: 360 * w,
                child: Image.asset(
                  'assets/Login_bg/login_bg.png',
                  fit: BoxFit.cover,
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 34 * h,
                    ),
                    Center(
                      child: Container(
                          width: 133,
                          height: 96,
                          child: Image.asset(
                            'assets/splash_screen_main_logo/logo.png',
                            scale: 1,
                          )),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Center(
                      child: Container(
                        width: 125,
                        height: 63,
                        child: Image.asset(
                          'assets/divinty_logo/divinty.png',
                          scale: 1,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 49,
                    ),
                    Container(
                      width: 320 * w,
                      height: 397,
                      decoration: BoxDecoration(
                          color: MyColors.logoInBox,
                          borderRadius: BorderRadius.circular(25)),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              'Login',
                              style: TextStyle(
                                  fontFamily: "Lora",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 32),
                            ),
                            SizedBox(
                              height: 23,
                            ),
                            Textfields(
                              obscureText:   false,
                                controller:  emailController,
                                valid: (emailController)=>
                                ( EmailValidator.validate(emailController) ? null : 'Enter a Valid Email'),
                                height: 65,

                                title: 'Email address',
                                autoHint: [AutofillHints.email],
                                onPress: Text(''),
                                password: false,
                                width: 282 * w,
                                hint: 'Enter Email'),

                            Textfields(

                                obscureText: obscureText,
                                autoHint: [AutofillHints.password],
                                onPress: InkWell(
                                    onTap: () {
                                      setState(() {});
                                      obscureText = !obscureText;
                                      print(obscureText);
                                    },
                                    child: (obscureText)
                                        ? Icon(Icons.visibility_off, size: 14,color: MyColors.black.withOpacity(.25),)
                                        : Icon(Icons.visibility,size: 14,color: MyColors.black.withOpacity(.25),)),
                                title: "Password",
                                controller: passwordController,
                                valid: (passwordController)=>
                                ( (passwordController.toString().length >= 6) ? null : 'Enter atleast 6 digits')
                                ,
                                height: 65,
                                width: 282 * w,
                                password: true,
                                hint: "Password"),
                            Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: 20.0 * w ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      NavigateTo(context, ForgetPasswordScreen());
                                    },
                                    child: Text(
                                      'Forgot Password ?',
                                      style: TextStyle(
                                          color: MyColors.textfieldboard,
                                          fontSize: 12,
                                          fontFamily: 'Montserrat'),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 45),
                            InkWell(
                              onTap: (){
                                _formKey.currentState!.validate()?
                                {
                                  setState(() {

                                  }),
                                  loader= true,
                                  Auth.login(loader,emailController, passwordController, context, _auth),
                               23                                          }
                                      : null;
                              },
                                child: Button('Login', 190 * w,)),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 47,
                    ),
                    InkWell(
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        NavigateTo(context, SignUpScreen());
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Don’t have an account?',
                              style: TextStyle(
                                  color: MyColors.textfieldboard,
                                  fontSize: 12,
                                  fontFamily: 'Montserrat')),
                          Text(
                            'Sign Up',
                            style: TextStyle(
                                color: MyColors.GreenBlue,
                                fontSize: 12,
                                fontFamily: 'Montserrat'),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }


  

}
