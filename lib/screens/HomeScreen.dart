import 'package:cloud_firestore/cloud_firestore.dart';

import 'BoothScreen.dart';
import '../Paths/imports.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}
int snapLenght = 0;

class _HomescreenState extends State<Homescreen> {
  int index = 0;
  List list = [1, 2, 3];
  String text = 'vist';

  @override
  Widget build(BuildContext context) {
    final _snapshotRef =
        FirebaseFirestore.instance.collection('Booth').snapshots();
     final _snapShotRefSponcer =   FirebaseFirestore.instance.collection('Sponsor').snapshots();
    final w = MediaQuery.sizeOf(context).width * (1 / 360);
    final h = MediaQuery.sizeOf(context).height * (1 / 760);
    bool status = false;

    return Scaffold(
        body: WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: SafeArea(
          child: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
                height: 180,
                width: 360 * w,
                color: MyColors.bgBlue,
                child: Image.asset('assets/home_bg/bg.png')),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 15, 0, 0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                              height: 52,
                              width: 123,
                              child: Image.asset(
                                  'assets/Divinity_logo_w/logo.png')),
                          SizedBox(
                              height: 30,
                              width: 30,
                              child: Image.asset('assets/fire_home/fire.png')),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 37, 0),
                        child: InkWell(
                          onTap: () {
                            NavigateTo(context, ScanerScreen());
                          },
                          child: Container(
                            height: 26,
                            width: 59,
                            decoration: BoxDecoration(
                                color: MyColors.darkpink,
                                borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(2.7, 2, 7, 2),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: 21,
                                    width: 21,
                                    decoration: BoxDecoration(
                                      color: MyColors.white,
                                      shape: BoxShape.circle,
                                      // borderRadius: BorderRadius.circular(50)
                                    ),
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Image.asset(
                                            'assets/barcode-scan/barcode.png'),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Scan',
                                    style: TextStyle(
                                        color: MyColors.white,
                                        fontSize: 10,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Our Wonderful Sponsors',
                        style: TextStyle(
                            color: MyColors.white,
                            fontSize: 20,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  StatefulBuilder(
                    builder: (context,internalState){
                      return Column(
                      children: [
                        StreamBuilder(
                            stream: _snapShotRefSponcer,
                            builder:
                                (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                      child: CircularProgressIndicator(
                                        color: MyColors.bgBlue,
                                      ),
                                    );
                                  } else if (snapshot.hasError) {
                                    return Center(
                                      child: Text('Error Ocuur'),
                                    );
                                  } else {
                                    return Container(
                                      height: 250,
                                      child: PageView.builder(
                                          onPageChanged: (ind) {

                                            internalState((){
                                              index = ind;
                                            });
                                          },
                                          scrollDirection: Axis.horizontal,
                                          itemCount: snapshot.data!.docs.length,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding: const EdgeInsets.only(top: 8.0,bottom: 8,right: 25),
                                              child: Container(
                                                  color: Colors.transparent,
                                                  child: Container(
                                                      height: 250,
                                                      decoration: BoxDecoration(
                                                        boxShadow: [
                                                          BoxShadow(
                                                              color: MyColors
                                                                  .black
                                                                  .withOpacity(
                                                                  .1),
                                                              spreadRadius: 2,
                                                              offset: Offset(
                                                                  0, 5),
                                                              blurRadius: 2),
                                                        ],
                                                        color: MyColors.white,
                                                        borderRadius:
                                                        BorderRadius.circular(18),
                                                      ),
                                                      child: Column(children: [
                                                        Padding(
                                                          padding: const EdgeInsets
                                                              .fromLTRB(
                                                              8, 8, 8, 0),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                            children: [
                                                              Container(

                                                                  decoration: BoxDecoration(

                                                                    // color: Color(
                                                                    //     0xfffcefe0),
                                                                    borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                        13),
                                                                  ),
                                                                  height: 160,
                                                                  child: Container(
                                                                    decoration: BoxDecoration(
                                                                      borderRadius: BorderRadius.circular(13),
                                                                      color: MyColors.Grey.withOpacity(.1),
                                                                    ),

                                                                    height: 160,
                                                                    width: 335,
                                                                    child: ClipRRect(
                                                                      borderRadius: BorderRadius.circular(13),
                                                                      child: Image(
                                                                        fit: BoxFit.cover,
                                                                        image: NetworkImage(snapshot.data!.docs[index]['Image']),
                                                                      ),
                                                                    ),
                                                                  )),
                                                              SizedBox(
                                                                height: 6,
                                                              ),
                                                              Text(
                                                                snapshot.data!
                                                                    .docs[index]
                                                                ['Company'],
                                                                style: TextStyle(
                                                                  fontSize: 13*w,
                                                                  fontFamily: 'Montserrat',
                                                                  fontWeight: FontWeight
                                                                      .w600,
                                                                ),
                                                              ),
                                                              Container(
                                                                height: 30,
                                                                width: 335,
                                                                child: Text(
                                                                  overflow: TextOverflow.ellipsis,
                                                                  maxLines: 2,
                                                                  snapshot.data!
                                                                      .docs[index]
                                                                  ['des'],
                                                                  style: TextStyle(
                                                                    fontSize: 10*w,
                                                                    color: MyColors
                                                                        .black
                                                                        .withOpacity(
                                                                        .3),
                                                                    fontFamily: 'Montserrat',
                                                                    fontWeight: FontWeight
                                                                        .w600,
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        )
                                                      ]))),
                                            );
                                          }
                                      ),
                                    );

                                  }
                                }),
                        StreamBuilder(
                            stream: _snapShotRefSponcer,
                            builder:
                                (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                  child: CircularProgressIndicator(
                                    color: MyColors.bgBlue,
                                  ),
                                );
                              } else if (snapshot.hasError) {
                                return Center(
                                  child: Text('Error Ocuur'),
                                );
                              } else {
                                return DotsIndicator(
                                  dotsCount: snapshot.data!.docs.length,
                                  position: index,
                                  mainAxisSize: MainAxisSize.min,
                                  decorator: DotsDecorator(
                                    color: Colors.grey.shade300,
                                    activeColor: Colors.grey.shade500,
                                    size: const Size(15, 9.0),
                                    activeSize: const Size(28.0, 9.0),
                                    activeShape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5.0)),
                                  ),
                                );
                              }
                            }),
                      ],);
                    }
                    ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Booths',
                          style: TextStyle(
                            color: MyColors.black,
                            fontSize: 20,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            NavigateTo(context, BoothScreen());
                          },
                          child: Text(
                            'See all',
                            style: TextStyle(
                              color: MyColors.black,
                              fontSize: 10,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 200*h,
                    width: double.maxFinite,
                    child: StreamBuilder(
                        stream: _snapshotRef,
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Center(
                                        child: CircularProgressIndicator(
                                          color: MyColors.bgBlue,
                                          strokeWidth: 5,
                                        ),
                                      );
                                    } else if (snapshot.hasError) {
                                     return  const Center(
                                          child: Text(
                                        'Error Ouccr ',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontFamily: 'Montserrat'),
                                      ));
                                    } else {
                                       snapLenght =snapshot.data!.docs.length;
                                      return Padding(
                                          padding: EdgeInsets.fromLTRB(0, 15, 25, 0),
                                          child: ListView.builder(
                                            scrollDirection: Axis.vertical,
                                              shrinkWrap: true,
                                              itemCount: snapshot.data!.docs.length,
                                              itemBuilder: (context, index) {
                                             return   Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 6.0),
                                        child: Container(
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
                                                                width: 120,
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
                                                              width: 165*w,
                                                              child: Text(
                                                              maxLines: 2, overflow: TextOverflow.ellipsis,
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
                                                                  status  = !status;

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
                                  ));}}
                        ),
                  ),
                ],
              ),
            )
          ],
        ),
      )),
    ));
  }
}

