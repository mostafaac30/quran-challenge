import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:quran_challenge/constants/app_colors.dart';
import 'package:quran_challenge/constants/font_style_mgr.dart';
import 'package:quran_challenge/models/user_data.dart';
import 'package:quran_challenge/pages/home_page/cubit/cubit.dart';
import 'package:quran_challenge/pages/home_page/cubit/states.dart';
import 'package:quran_challenge/widgets/circle_indicator.dart';
import 'dart:math' as math;

import 'package:sizer/sizer.dart';

class Progress extends StatefulWidget {
  Progress({Key? key}) : super(key: key);

  @override
  State<Progress> createState() => _ProgressState();
}

class _ProgressState extends State<Progress> {
  // scaffold key
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int userDoneCount = 0;
  int pairDoneCount = 0;
  int firstIndexOfFalse = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePageCubit, HomePageStates>(
        builder: (context, state) {
      HomePageCubit cubit = HomePageCubit.get(context);

      if (state is HomePageGetUserDataSuccess) {
        cubit.getPairData();
      }
      if (state is HomePageGetPairDataSuccess) {
        cubit.printData(cubit.pairData);
        print('***************************');
        cubit.printData(cubit.userData);
        print('**************index*************');
        // firstIndexOfFalse = cubit.juzList.indexOf(false);
        // print('***************************' + cubit.juzList.toString());

        cubit.userData.isJuzDone.forEach((k, v) {
          if (v) {
            userDoneCount += 1;
          }
        });
        cubit.pairData.isJuzDone.forEach((k, v) {
          if (v) {
            pairDoneCount += 1;
          }
        });
      }

      return state is HomePageGetPairDataLoading
          ?
          //if data is not loaded
          Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Scaffold(
              key: _scaffoldKey,
              backgroundColor: Colors.white12,
              body: SingleChildScrollView(
                child: Container(
                  padding:
                      const EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/background.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: StreamBuilder<
                            DocumentSnapshot<Map<String, dynamic>>>(
                        stream: cubit.getDataSnapshot(cubit.userUID!),
                        builder: (context, snapshot1) {
                          if (snapshot1.hasError) {
                            return Center(child: Text('something_wrong'));
                          }
                          if (snapshot1.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: Text("Loading..."),
                            );
                          }
                          var doc1 = snapshot1.data;
                          var data1 = doc1?.data();
                          var userData1 =
                              UserData.fromJson(data1 as Map<String, dynamic>);
                          userDoneCount = 0;
                          userData1.isJuzDone.forEach((k, v) {
                            if (v) {
                              userDoneCount += 1;
                            }
                          });

                          return StreamBuilder<
                                  DocumentSnapshot<Map<String, dynamic>>>(
                              stream:
                                  cubit.getDataSnapshot(cubit.pairData.pairUID),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return Center(child: Text('something_wrong'));
                                }
                                print('*******************************  ' +
                                    cubit.pairData.pairUID);
                                // if (snapshot.connectionState ==
                                //     ConnectionState.waiting) {
                                //   return Center(
                                //     child: Text("Loading..."),
                                //   );
                                // }
                                var doc = snapshot.data;
                                var data = doc?.data();
                                var userData = UserData.fromJson(
                                    data as Map<String, dynamic>);
                                pairDoneCount = 0;
                                userData.isJuzDone.forEach((k, v) {
                                  if (v) {
                                    pairDoneCount += 1;
                                  }
                                });

                                print('*******************************  ' +
                                    pairDoneCount.toString());
                                print('*******************************  ' +
                                    userDoneCount.toString());
                                return Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CircleIndicator(
                                          radius: 90.0,
                                          percent: userDoneCount / 30,
                                          mainFilledCircleColor: Colors.pink,
                                          secondFilledCircleColor: Colors.red,
                                          mainArcColor: Colors.pink,
                                          secondArcColor: Colors.redAccent,
                                        ), // Spacer(),
                                        Expanded(
                                          child: Text(
                                            'تقدمك',
                                            style: FontStyleManager.st1,
                                            textDirection: TextDirection.rtl,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: 20.0, bottom: 20),
                                      width: double.infinity,
                                      height: 2,
                                      color: Colors.black54,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            '${cubit.pairData.displayName}',
                                            style: FontStyleManager.st1,
                                            textDirection: TextDirection.rtl,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 40,
                                        ),
                                        // Spacer(),
                                        CircleIndicator(
                                          radius: 90.0,
                                          percent: pairDoneCount / 30,
                                          mainFilledCircleColor: Colors.green,
                                          secondFilledCircleColor: Colors.lime,
                                          mainArcColor: Colors.blue,
                                          secondArcColor: Colors.deepPurple,
                                        )
                                      ],
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 36.0),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 20),
                                      width: double.infinity,
                                      height: 46,
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.5),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          showModalBottomSheet<void>(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                topLeft: Radius.circular(20),
                                                topRight: Radius.circular(20),
                                              )),
                                              context: context,
                                              builder: (context) =>
                                                  StatefulBuilder(builder:
                                                      (context, state) {
                                                    return GridView.count(
                                                      crossAxisCount: 4,
                                                      crossAxisSpacing: 12,
                                                      mainAxisSpacing: 12,
                                                      shrinkWrap: true,
                                                      padding:
                                                          EdgeInsets.all(10),
                                                      children: List.generate(
                                                          30, (index) {
                                                        return InkWell(
                                                          onTap: () {
                                                            print(index + 1);
                                                            cubit
                                                                .onButtomJuzState(
                                                                    index);

                                                            //to rebuild the sheet through the stateful builder
                                                            // and passed state()
                                                            state(() {});
                                                          },
                                                          child: Container(
                                                            //circle fill color and border color
                                                            decoration:
                                                                BoxDecoration(
                                                              color: cubit.userData
                                                                          .isJuzDone[
                                                                      index
                                                                          .toString()]
                                                                  ? cubit
                                                                      .btmSheetDoneColor
                                                                  : cubit
                                                                      .btmSheetUnDoneColor,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                              //shadow
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color: Colors
                                                                      .green,
                                                                  blurRadius: cubit
                                                                              .userData
                                                                              .isJuzDone[
                                                                          index
                                                                              .toString()]
                                                                      ? cubit
                                                                          .btmSheetDoneShadow
                                                                      : cubit
                                                                          .btmSheetUnDoneShadow,
                                                                ),
                                                              ],
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                '${index + 1}',
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 25,
                                                                  fontFamily:
                                                                      'digital-7',
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      }),
                                                    );
                                                  }));
                                        },
                                        child: Row(
                                          children: [
                                            Text(
                                              'Juz ${0 + 1}',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                              ),
                                            ),
                                            Spacer(),
                                            Transform.rotate(
                                              //make arrow is drop down arrow
                                              angle: 90 * math.pi / 180 * -1,
                                              child: Icon(
                                                Icons.arrow_back_ios,
                                                color: Colors.white,
                                                size: 18,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 15),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 20),
                                      width: double.infinity,
                                      height: 105,
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.6),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Update state',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),
                                          ),
                                          Expanded(
                                            child: Row(
                                              children: [
                                                //draw circlular container with color green with outer boarder is white
                                                InkWell(
                                                  onTap: () {
                                                    cubit.onJuzState();
                                                  },
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        right: 10),
                                                    width: 30,
                                                    height: 30,
                                                    decoration: BoxDecoration(
                                                      color:
                                                          cubit.juzStateColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      border: Border.all(
                                                        color: Colors.white,
                                                        width: 2,
                                                      ),
                                                      //shadow box
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: cubit
                                                              .juzStateColor,
                                                          blurRadius: cubit
                                                              .juzStateShadow,
                                                          // changes position of shadow
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  'DONE',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              });
                        }),
                  ),
                ),
              ),
            );
    });
  }
}
