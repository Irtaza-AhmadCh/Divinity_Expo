import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../FireBase/Auth.dart';
import '../Paths/imports.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();

}
String Id = DateTime.now().millisecondsSinceEpoch.toString();

class _SignUpScreenState extends State<SignUpScreen> {
  bool loading = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool obscureText = false;
  bool loader = false;
  bool obscureText1 = false;
  final _auth = FirebaseAuth.instance;
  final _firestoreRef = FirebaseFirestore.instance.collection('User');
  var PhoneNo = '';




  @override
  Widget build(BuildContext context) {
    final w = MediaQuery
        .sizeOf(context)
        .width * (1 / 360);
    final h = MediaQuery
        .sizeOf(context)
        .height * (1 / 760);

    return SafeArea(
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
            Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 19 * h,
                    ),
                    Container(
                      width: 320 * w,
                      height: 615,
                      decoration: BoxDecoration(
                          color: MyColors.logoInBox,
                          borderRadius: BorderRadius.circular(25)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 5 * h,
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(width: 12*w,),
                                  InkWell(
                                    onTap: () {
                                      NavigatePop(context);
                                    },
                                    child: Container(
                                      width: 34,
                                      height: 22,
                                      decoration: BoxDecoration(
                                          color: MyColors.white,
                                          borderRadius:
                                          BorderRadius.circular(20),
                                          border: Border.all(
                                              color: MyColors.white)),
                                      child: Center(
                                          child: Icon(
                                            Icons.arrow_back,
                                            size: 20,
                                            color: MyColors.black,
                                          )),
                                    ),
                                  ),
                                  Spacer(),
                                  Center(
                                    child: Text(
                                      'SignUp',
                                      style: TextStyle(
                                          fontFamily: "Lora",
                                          fontWeight: FontWeight.bold,
                                          fontSize: 32),
                                    ),
                                  ),
                                  Spacer(),

                                  SizedBox(width: 34*w,),
                                  SizedBox(width: 34,),
                                ],
                              ),
                              SizedBox(
                                height: 23,
                              ),
                              Textfields(
                                  title: 'Full Name',
                                  obscureText: false,
                                  autoHint: [AutofillHints.name],
                                  onPress: Text(''),
                                  controller: nameController,
                                  valid: (nameController) =>
                                  ((nameController
                                      .toString()
                                      .length >= 1)
                                      ? null
                                      : 'Enter a Valid Name'),
                                  height: 65,
                                  password: false,
                                  width: 282 * w,
                                  hint: 'Enter Name'),
                              Textfields(
                                  title: 'Email address',
                                  autoHint: [AutofillHints.email],
                                  obscureText: false,
                                  onPress: Text(''),
                                  controller: emailController,
                                  valid: (emailController) =>
                                  (EmailValidator.validate(emailController)
                                      ? null
                                      : 'Enter a Valid Email'),
                                  height: 65,
                                  width: 282 * w,
                                  hint: 'Enter Email',
                                  password: false),
                              SizedBox(
                                width: 282 * w,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Phone Number(Optional)',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: MyColors.textfieldboard,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'Montserrat',
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    SizedBox(
                                      height: 65,
                                      child: IntlPhoneField(
                                        decoration: InputDecoration(
                                            contentPadding: EdgeInsets.fromLTRB(
                                                0, 0, 0, 20),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: MyColors.textfieldboard,
                                                width: 1,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(30),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: MyColors.textfieldboard,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(30),
                                            ),
                                            focusedErrorBorder:
                                            OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: MyColors.red,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(30),
                                            ),
                                            disabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: MyColors.textfieldboard
                                                    .withOpacity(.8),
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(30),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: MyColors.red,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(30),
                                            )),
                                        initialCountryCode: 'PK',
                                        onChanged: (phone) {
                                          print('Phone no ${phone.completeNumber}');
                                          (PhoneNo =
                                              phone.completeNumber);


                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Textfields(
                                  title: "Password",
                                  autoHint: [AutofillHints.password],
                                  onPress: InkWell(
                                      onTap: () {
                                        setState(() {});
                                        obscureText = !obscureText;
                                        print(obscureText);
                                      },
                                      child: (obscureText)
                                          ? Icon(
                                        Icons.visibility_off,
                                        size: 14,
                                        color: MyColors.black
                                            .withOpacity(.25),
                                      )
                                          : Icon(
                                        Icons.visibility,
                                        size: 14,
                                        color: MyColors.black
                                            .withOpacity(.25),
                                      )),
                                  controller: passwordController,
                                  valid: (passwordController) =>
                                  ((passwordController
                                      .toString()
                                      .length >=
                                      6)
                                      ? null
                                      : 'Enter atleast 6 digits'),
                                  height: 65,
                                  obscureText: obscureText,
                                  width: 282 * w,
                                  hint: "Password",
                                  password: true),
                              Textfields(
                                  obscureText: obscureText1,
                                  autoHint: [AutofillHints.password],
                                  title: "Confirm Password",
                                  onPress: InkWell(
                                    onTap: () {
                                      setState(() {});
                                      obscureText1 = !obscureText1;
                                      print(obscureText1);
                                    },
                                    child: (obscureText1)
                                        ? Icon(
                                      Icons.visibility_off,
                                      size: 14,
                                      color:
                                      MyColors.black.withOpacity(.25),
                                    )
                                        : Icon(Icons.visibility,
                                        size: 14,
                                        color: MyColors.black
                                            .withOpacity(.25)),
                                  ),
                                  controller: passwordConfirmController,
                                  valid: (passwordconfirmController) =>
                                  ((passwordController.text ==
                                      passwordConfirmController.text)
                                      ? null
                                      : 'Enter Correct Password'),
                                  height: 65,
                                  width: 282 * w,
                                  hint: "Password",
                                  password: true),
                              SizedBox(height: 20),
                              InkWell(
                                  onTap: () {
                                    print('tap');

                                    setState(() {
                                      _formKey.currentState!.validate()
                                          ?
                                      {
                                        loader =true,

                                        Auth.signUp(
                                            loader,
                                            _auth,
                                            emailController,
                                            passwordController,
                                            _firestoreRef,
                                            PhoneNo,
                                            nameController,
                                            context),

                                      }
                                          : null;
                                    });
                                  },
                                  child: Button('SignUp', 190*w)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 47 * h,
                    ),
                    InkWell(
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        NavigateTo(context, LogInScreen());
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Have an account?',
                              style: TextStyle(
                                  color: MyColors.textfieldboard,
                                  fontSize: 12,
                                  fontFamily: 'Montserrat')),
                          Text(
                            'LogIn',
                            style: TextStyle(
                                color: MyColors.GreenBlue,
                                fontSize: 12,
                                fontFamily: 'Montserrat'),
                          ),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
