import 'package:cloud_firestore/cloud_firestore.dart';
import '../Paths/imports.dart';

class SponserScreen extends StatefulWidget {
  const SponserScreen({super.key});

  @override
  State<SponserScreen> createState() => _SponserScreenState();
}

class _SponserScreenState extends State<SponserScreen> {
  final _firebaseRef = FirebaseFirestore.instance.collection('User');
  final _snapshotRef = FirebaseFirestore.instance.collection('Sponsor').snapshots();

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


        title:  Text('All Sponsors',
          style: TextStyle(
              fontFamily: "Lora",
              fontWeight: FontWeight.bold,
              fontSize: 32,
              color: MyColors.white),
        ) ,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _snapshotRef,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: MyColors.bgBlue,
                strokeWidth: 5,
              ),
            );
          }
          else if (snapshot.hasError) {
          return  const Center(
                child: Text('Error Ouccr ', style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Montserrat'
                ),)
            );
          }
          else {
            return Padding(
                padding: EdgeInsets.fromLTRB(25, 15, 25, 0),
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return   Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 6.0),
                        child:Container(
                          height: 128 *w,
                          decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.circular(18),
                            color: MyColors.BoothGrey,
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding:
                                const EdgeInsets.fromLTRB(
                                    8, 0, 0, 0),
                                child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(13),
                                      color: MyColors.Grey.withOpacity(.1),
                                    ),

                                    height: 111*w,
                                    width: 107*w,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(13),
                                      child: Image(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(snapshot.data!.docs[index]['Image']),
                                      ),
                                    )),
                              ),
                              Padding(
                                padding:
                                const EdgeInsets.fromLTRB(
                                    15, 14, 12, 8),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.end,
                                  children: [
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment
                                            .start,
                                        children: [
                                          Text(
                                            snapshot
                                                .data!
                                                .docs[index]
                                            ['Company']
                                                .toString(),
                                            style: TextStyle(
                                              color: MyColors.black,
                                              fontSize: 14*w,
                                              fontFamily:
                                              'Montserrat',
                                              fontWeight:
                                              FontWeight.bold,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'Location:',
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
                                              ),
                                              Container(
                                                width: 123*w,
                                                child: Text(
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  snapshot
                                                      .data!
                                                      .docs[index]
                                                  ['Location']
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: MyColors
                                                        .black,
                                                    fontSize: 8*w,
                                                    fontFamily:
                                                    'Montserrat',
                                                    fontWeight:
                                                    FontWeight
                                                        .normal,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Expanded(
                                            child: Container(
                                              width: 160*w,
                                              child: Text(
                                                maxLines: 3, overflow: TextOverflow.ellipsis,
                                                softWrap: false,
                                                snapshot.data!
                                                    .docs[index]['des']
                                                    .toString(),
                                                style: TextStyle(
                                                  color: MyColors.black,
                                                  fontFamily:
                                                  'Montserrat',
                                                  fontSize: 10*w,
                                                  fontWeight:
                                                  FontWeight.normal,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10*w,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.end,
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
                        )
                      );
                    }
                ));
          }
        })
    );
  }
}
