import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:divinity/Paths/imports.dart';
import 'package:divinity/screens/AdminSide/AdminMain.dart';
import 'package:divinity/screens/AdminSide/SponserListDash.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart ' as firebase_storage;
import '../../resourses/colors.dart';
import '../../resourses/navigators.dart';
import '../../reuseable_widgets/Widgets.dart';
import '../forgetPassword.dart';

class SponsorList extends StatefulWidget {
  const SponsorList({super.key});

  @override
  State<SponsorList> createState() => _SponsorListState();
}

class _SponsorListState extends State<SponsorList> {
  TextEditingController CompanyNameController = TextEditingController();
  TextEditingController LocationController = TextEditingController();
  TextEditingController DescriptionController = TextEditingController();
  final storage = firebase_storage.FirebaseStorage.instance;
  final _firestoreRef = FirebaseFirestore.instance.collection('Sponsor');
  bool loader = false;

  File? _image;
  final _picker = ImagePicker();

  Future getImage() async {
    final _pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (_pickedImage != null) {
        _image = File(_pickedImage.path);
      } else {
        print('No Image Picker');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width * (1 / 360);
    return WillPopScope(
      onWillPop: ()async{
        await  NavigateToReplace(context, NavigationbarScreen());
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: MyColors.bgBlue,
          foregroundColor: MyColors.bgBlue,
          elevation: 0,
          backgroundColor: MyColors.bgBlue,
          automaticallyImplyLeading: false,
          centerTitle: true,
          toolbarHeight: 75,
          title: Text(
            'Admin Dashboard',
            style: TextStyle(
                fontFamily: "Lora",
                fontWeight: FontWeight.bold,
                fontSize: 32,
                color: MyColors.white),
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 34,
                ),
                Container(
                  width: 320 * w,
                  height: 880,
                  decoration: BoxDecoration(
                      color: MyColors.logoInBox,
                      borderRadius: BorderRadius.circular(25)),
                  child: Form(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'DashBoard',
                          style: TextStyle(
                              fontFamily: "Lora",
                              fontWeight: FontWeight.bold,
                              fontSize: 32),
                        ),
                        SizedBox(
                          height: 23,
                        ),
                        Text(
                          'Add data in Sponsor List ',
                          style: TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 22),
                        ),
                        SizedBox(
                          height: 23,
                        ),
                        Textfields(
                            obscureText: false,
                            controller: CompanyNameController,
                            maxline: 1,
                            title: 'Company Name',
                            autoHint: [AutofillHints.email],
                            onPress: Text(''),
                            password: false,
                            width: 282 * w,
                            hint: 'Company Name',
                            height: 45),

                        Textfields(
                            obscureText: false,
                            autoHint: [AutofillHints.password],
                            onPress: Text(''),
                            title: "Location",
                            maxline: 1,
                            controller: LocationController,
                            height: 65,
                            width: 282 * w,
                            password: true,
                            hint: "Location"),

                        Textfields(
                            obscureText: false,
                            autoHint: [AutofillHints.password],
                            onPress: Text(''),
                            maxline: 4,
                            maxLength: 70,
                            title: "Description",
                            controller: DescriptionController,
                            height: 130,
                            width: 282 * w,
                            password: true,
                            hint: "Description"),
                        // SizedBox(height: 10,),
                        Text(
                          'Add Image',
                          style: TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 22),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {
                            getImage();
                            print('picked');
                            setState(() {});
                          },
                          child: Container(
                            height: 250,
                            width: 250,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: MyColors.boothList.withOpacity(.5),
                            ),
                            child: (_image == null)
                                ? Icon(
                                    Icons.add_a_photo,
                                    color: MyColors.white,
                                    size: 50,
                                  )
                                : Image.file(_image!),
                          ),
                        ),

                        SizedBox(height: 45),
                        InkWell(
                            onTap: () {
                              setState(() {
                                loader =true;
                                var Id = DateTime.now().millisecondsSinceEpoch.toString();

                                firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref('/sponser/'+Id);
                                firebase_storage.UploadTask uploadTask = ref.putFile(_image!.absolute);

                                Future.value(uploadTask).then((val )async{
                                  var url = await ref.getDownloadURL();
                                  print(url);
                                  _firestoreRef.doc(Id).set({
                                    'Company': CompanyNameController.text,
                                    'Location': LocationController.text,
                                    'des': DescriptionController.text,
                                    'Image': url.toString()
                                  }).then((val) {
                                    ErrorMassage.errormassage(
                                        context, 'Data Uploaded');
                                    setState(() {
                                      loader =false;
                                    });
                                  }).onError((error, StackTrace) {
                                    setState(() {
                                      loader =false;
                                    });

                                    ErrorMassage.errormassage(
                                        context, error.toString(

                                    ));
                                  });
                                }).onError((error, StackTrace) {
                                  setState(() {

                                  });
                                  loader =false;
                                  ErrorMassage.errormassage(
                                      context, error.toString());
                                });

                              });

                            },
                            child: Button('Upload', 190 * w, loading: loader)),
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
                    onTap: () async {
                      NavigateTo(context, Adminmain());
                    },
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Upload Data on Booth List',
                              style: TextStyle(
                                  color: MyColors.black,
                                  fontSize: 12,
                                  fontFamily: 'Montserrat')),
                        ])),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // void uploadData(){
  //   var Id = DateTime.now().millisecondsSinceEpoch.toString();
  //
  //   firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref('/Booth/'+Id);
  //   firebase_storage.UploadTask uploadTask = ref.putFile(_image!.absolute);
  //
  //   Future.value(uploadTask).then((val )async{
  //     var url = await ref.getDownloadURL();
  //     print(url);
  //     _firestoreRef.doc(Id).set({
  //       'Company': CompanyNameController.text,
  //       'Location': LocationController.text,
  //       'des': DescriptionController.text,
  //       'Image': url.toString()
  //     }).then((val) {
  //       ErrorMassage.errormassage(
  //           context, 'Data Uploaded');
  //     }).onError((error, StackTrace) {
  //       setState(() {
  //
  //       });
  //       loader =false;
  //       ErrorMassage.errormassage(
  //           context, error.toString());
  //     });
  //   }).onError((error, StackTrace) {
  //     setState(() {
  //
  //     });
  //     loader =false;
  //     ErrorMassage.errormassage(
  //         context, error.toString());
  //   });
  // }
}
