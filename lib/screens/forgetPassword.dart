import 'package:divinity/FireBase/Auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Paths/imports.dart';


class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  TextEditingController emailController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width * (1 / 360);
    final h = MediaQuery.sizeOf(context).height * (1 / 760);

    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColors.bgBlue,
        appBar: AppBar(
          surfaceTintColor: MyColors.bgBlue,
          foregroundColor: MyColors.bgBlue,
          centerTitle: true,
          elevation: 0,
          backgroundColor: MyColors.bgBlue,
          automaticallyImplyLeading: false,
          leading: SizedBox(
            height: 22,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 15, 0, 15),
              child: InkWell(
                onTap: () {
                  NavigatePop(context);
                },
                child: Container(
                  height: 22,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: MyColors.white)),
                  child: Center(
                      child: Icon(
                    Icons.arrow_back,
                    size: 20,
                    color: MyColors.white,
                  )),
                ),
              ),
            ),
          ),
          leadingWidth: 60,
          title: Text(
            'Forgot Password',
            style: TextStyle(
                fontFamily: "Lora",
                fontWeight: FontWeight.bold,
                fontSize: 32,
                color: MyColors.white),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: 320 *w,
                  height: 615,
                  decoration: BoxDecoration(
                      color: MyColors.white,
                      borderRadius: BorderRadius.circular(25)),
                  child: Center(
                      child:
                      Form(
                        key: _formKey,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                          SizedBox(
                            width: 287,
                              height: 259,
                              child: Image.asset('assets/forget_password/forget.png')),
                          SizedBox(height: 25),
                          Text(
                            'Forgot your password?',
                            style: TextStyle(
                              color: MyColors.black,
                              fontSize: 22,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Please enter the email address associated'",
                            style: TextStyle(
                              color: MyColors.black,
                              fontSize: 13,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w100,
                            ),
                          ),
                          Text(
                            " with your account. We'll mail you a link to ",
                            style: TextStyle(
                              color: MyColors.black,
                              fontSize: 13,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w100,
                            ),
                          ),
                          Text(
                            "reset your Password",
                            style: TextStyle(
                              color: MyColors.black,
                              fontSize: 13,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w100,
                            ),
                          ),
                          SizedBox(
                            height: 41,
                          ),
                          Textfields(
                              obscureText: false,
                              autoHint: [AutofillHints.email],
                              title: 'Enter Email',
                              onPress: Text(''),
                              password: false,
                              height: 65,
                              controller: emailController,
                              valid: (emailController) =>
                                  (EmailValidator.validate(emailController)
                                      ? null
                                      : 'Enter a Valid Email'),
                              width: 282,
                              hint: 'bianca.oliver@mail.com'),
                          SizedBox(height: 5,),
                          InkWell(
                            onTap: () {
                              _bottom();
                              // _formKey.currentState!.validate()
                              //     ?  _bottom()
                              //     : null;
                            },
                            child: Button("Send", 190),
                          )
                                              ],
                                            ),
                        ),
                      )),
                ),
                SizedBox(
                  height: 30*w,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _bottom() {
    final w = MediaQuery.sizeOf(context).width * (1 / 360);
    final h = MediaQuery.sizeOf(context).height * (1 / 760);

    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  width: double.maxFinite,
                ),
                Text(
                  'Instruction Sent!',
                  style: TextStyle(
                    fontSize: 22*w,
                    fontFamily: "Lora",
                    fontWeight: FontWeight.bold,
                    color: MyColors.textfieldboard,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Lottie.asset(
                  'assets/video_animations/send.json',
                  repeat: true,
                  height: 219*w,
                  width: 260*w,
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  'The instruction has been sent to you over\n email, kindly follow the instruction to reset\n the password of your account.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14*w,
                    fontFamily: "Montserrat",
                    color: MyColors.Grey,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                    onTap: () {
                      NavigateTo(context, LogInScreen());
                    },
                    child: Button('Okay', 190*w)),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          );
        });
  }


}
