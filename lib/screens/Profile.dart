import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:divinity/screens/AdminSide/AdminMain.dart';
import 'package:divinity/screens/SignUp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../FireBase/Auth.dart';
import '../Paths/imports.dart';
import 'HomeScreen.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _auth = FirebaseAuth.instance;
  final _ref = FirebaseFirestore.instance.collection('Booth');
  bool loader = false;

  // Replace with actual user ID


  Future<DocumentSnapshot<Map<String, dynamic>>> getUserData() async {
    final String userId = _auth.currentUser!.uid.toString();
    final userRef = FirebaseFirestore.instance.collection('User').doc(userId);
    final docSnapshot = await userRef.get();
    return docSnapshot;
  }

  final _firebaseRef = FirebaseFirestore.instance.collection('User');
  final _snapshotRef = FirebaseFirestore.instance.collection('User')
      .snapshots();


  @override
  Widget build(BuildContext context) {
    final w = MediaQuery
        .sizeOf(context)
        .width * (1 / 360);

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: MyColors.bgBlue,
        foregroundColor: MyColors.bgBlue,
        elevation: 0,
        backgroundColor: MyColors.bgBlue,
        automaticallyImplyLeading: false,
        centerTitle: true,
        toolbarHeight: 75,
        title: Text(
          'Profile',
          style: TextStyle(
              fontFamily: "Lora",
              fontWeight: FontWeight.bold,
              fontSize: 32,
              color: MyColors.white),
        ),
        actions: [
          IconButton(onPressed: () {
            NavigateTo(context, const Adminmain());
          },
              icon: Icon(
                Icons.add_circle_outline_outlined, color: MyColors.white,))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                height: 293,
                width: double.maxFinite,
                color: MyColors.bgBlue,
                child: Stack(children: [
                  const Image(
                    image: AssetImage('assets/home_bg/bg.png'),
                  ),
                  FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                    future: getUserData(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator(
                          color: MyColors.white,
                          strokeWidth: 5,
                        ));
                      } else if (snapshot.hasError) {
                        return const Center(child: Text('Error fetching data!'));
                      } else {
                        final docSnapshot = snapshot.data;
                        if (docSnapshot!.exists) {
                          final data = docSnapshot.data();
                          final String username = data!['Name'];
                          final String phoneNo = data!['Phone Number'];
                          final String email = data!['Email'];
                          return Column(
                            children: [
                              ProfileField(title: 'Full Name',
                                  text: username,
                                  width: 310 * w),
                              const SizedBox(height: 15,),
                              ProfileField(
                                  title: 'Email', text: email, width: 310 * w),
                              const SizedBox(height: 15,),
                              ProfileField(title: 'Phone Number',
                                  text: phoneNo,
                                  width: 310 * w),

                            ],
                          );
                        } else {
                          return Center(child: Text(
                            'No user found ', style: TextStyle(
                              color: MyColors.white,
                              fontSize: 20
                          ),),);
                        }
                      }
                    },
                  ),


                ])),

            Padding(
              padding: const EdgeInsets.fromLTRB(25, 14, 0, 13),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Visted Booths',
                    style: TextStyle(
                        color: MyColors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat'),
                  ),
                ],
              ),
            ),
            StatefulBuilder(builder: (context, State){
              return  CircularPercentIndicator(
                radius: 90.0,
                lineWidth: 13.0,
                animation: true,
                percent: _precentage(),
                center: Container(
                  height: 123,
                  width: 123,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: MyColors.darkpink,
                      border: Border.all(
                        color: const Color(0xff8d7f97),
                        width: 10,
                      )),
                  child: Center(
                    child: Text(
                      '${_precentageText()}%',
                      style: TextStyle(
                          color: MyColors.white,
                          fontSize: 36,
                          fontFamily: 'Lora',
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                circularStrokeCap: CircularStrokeCap.square,
                progressColor: MyColors.darkpink,
                backgroundColor: Colors.grey.shade300,
              );
            },
            ),
            const SizedBox(height: 13,),
            InkWell(
                onTap: () {
                  _confirm();
                },
                child: Button('Logout', 190 * w)),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  _confirm() {
    showDialog(context: context, builder: (context) =>
        AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              const Center(
                child: Text(
                  'Logout',
                  style: TextStyle(
                      fontFamily: "Lora",
                      fontWeight: FontWeight.bold,
                      fontSize: 32),
                ),
              ),
              const SizedBox(height: 20,),
              const Center(
                child: Text(
                  'Are You Sure ?',
                  style: TextStyle(
                      fontFamily: "Montserrat",
                      fontSize: 20),
                ),
              ),
              const SizedBox(height: 20,),
              InkWell(
                onTap: () {
                  setState(() {
                    loader = true;
                  });
                  Auth.logOut(loader, context, _auth);
                },
                child: Button('Yes, Logout', 190),
              )
            ],),
        ));
  }

  double _precentage(){
 double percentage = BarCodeResults.length/snapLenght;
    return percentage ;
  }
  String _precentageText(){
    State;
    String percentageText = ((BarCodeResults.length/snapLenght*100)).toInt().toString();
    return percentageText ;
  }
}