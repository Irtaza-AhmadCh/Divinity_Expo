import 'package:cloud_firestore/cloud_firestore.dart';
import '../Paths/imports.dart';


class BoothScreen extends StatefulWidget {
  const BoothScreen({super.key});

  @override
  State<BoothScreen> createState() => _BoothScreenState();
}

class _BoothScreenState extends State<BoothScreen> {
  final _firebaseRef = FirebaseFirestore.instance.collection('User');
  final _snapshotRef = FirebaseFirestore.instance.collection('Booth').snapshots();


  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width * (1 / 360);
    final h = MediaQuery.sizeOf(context).height * (1 / 760);

    return  Scaffold(
      appBar:  AppBar(
        surfaceTintColor: MyColors.bgBlue,
        foregroundColor: MyColors.bgBlue,
        elevation: 0,
        backgroundColor: MyColors.bgBlue,
        automaticallyImplyLeading: false,
        centerTitle: true,
        toolbarHeight: 75,
        leading: SizedBox(
          height: 22,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(25,25,0,25),
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
        leadingWidth: 65,

        title:  Text('All Booths',
          style: TextStyle(
              fontFamily: "Lora",
              fontWeight: FontWeight.bold,
              fontSize: 32,
              color: MyColors.white),
        ) ,
      ),
      body:
      StreamBuilder<QuerySnapshot>(
stream: _snapshotRef,
builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
    if(snapshot.connectionState == ConnectionState.waiting){
    return Center(
    child: CircularProgressIndicator( color: Colors.blueGrey,
    ),
    );
    } else if(snapshot.hasError) {
    return Text('Error occur');

    } else{
    return Padding(
        padding: EdgeInsets.fromLTRB(25, 15, 25, 0),
        child: ListView.builder(

            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: Container(
                  height: 128,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: MyColors.BoothGrey,
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(13),
                            color: MyColors.Grey.withOpacity(.1),
                          ),

                            height: 111,
                            width: 107,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(13),
                              child: Image(
                                fit: BoxFit.cover,
                                image: NetworkImage(snapshot.data!.docs[index]['Image']),
                              ),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 14, 0, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Booth # $index', style: TextStyle(
                                  color: MyColors.black,
                                  fontSize: 8,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w600,
                                ),),
                                Text(snapshot.data!.docs[index]['Company']
                                    .toString(), style: TextStyle(
                                  color: MyColors.black,
                                  fontSize: 14,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                ),),
                                Row(
                                  children: [
                                    Text('Location:', style: TextStyle(
                                      color: MyColors.black,
                                      fontFamily: 'Montserrat',

                                      fontSize: 8,
                                      fontWeight: FontWeight.w700,
                                    ),),
                                    Text(snapshot.data!.docs[index]['Location']
                                        .toString(), style: TextStyle(
                                      color: MyColors.black,
                                      fontSize: 8,
                                      fontFamily: 'Montserrat',

                                      fontWeight: FontWeight.normal,
                                    ),),
                                  ],
                                ),
                                Container(
                                  width: 170,
                                  height: 40,
                                  child: Text(
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    softWrap: false,
                                    snapshot.data!
                                        .docs[index]['des']
                                        .toString(),
                                    style: TextStyle(
                                      color: MyColors.black,
                                      fontFamily: 'Montserrat',
                                      fontSize: 10,
                                      fontWeight: FontWeight.normal,
                                    ),),
                                ),

                              ],

                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                StatefulBuilder(
                                  builder: (BuildContext context,  setstate) {
                                    return InkWell(
                                      onTap: (){

                                        setstate(() {

                                        });
                                      },
                                      child: Container(
                                        height: 22*w,
                                        width: 56*w,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius
                                                .circular(
                                                14),
                                            color: MyColors
                                                .white),
                                        child: Center(
                                            child: (BarCodeResults.contains(snapshot.data!.docs[index]['Company']))?
                                            Text(
                                              'Visited',
                                              style: TextStyle(
                                                color: MyColors
                                                    .black,
                                                fontFamily:
                                                'Montserrat',
                                                fontSize: 8*w,
                                                fontWeight:
                                                FontWeight
                                                    .w700,
                                              ),
                                            ): Text(
                                              'Not Visited',
                                              style: TextStyle(
                                                color: MyColors
                                                    .black,
                                                fontFamily:
                                                'Montserrat',
                                                fontSize: 8*w,
                                                fontWeight:
                                                FontWeight
                                                    .w600,
                                              ),
                                            )
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),

              );
            }
        )

    );
  }
}
)
    );
  }
}
