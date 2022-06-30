import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_challenge/pages/home_page/cubit/states.dart';

import '../../../models/user_data.dart';

class HomePageCubit extends Cubit<HomePageStates> {
  HomePageCubit() : super(HomePageInitial());

  static HomePageCubit get(context) => BlocProvider.of(context);

  var juzStateColor = Colors.green;
  double juzStateShadow = 24;

  void onJuzState() {
    emit(HomePageJuzLoading());

    juzStateColor = juzStateColor == Colors.green ? Colors.grey : Colors.green;
    juzStateShadow = juzStateShadow == 24 ? 0 : 24;

    emit(HomePageJuzCompleted());
  }

  var btmSheetUnDoneColor = Colors.black;
  var btmSheetDoneColor = Colors.green;
  double btmSheetDoneShadow = 20;
  double btmSheetUnDoneShadow = 0;

  // List<bool> juzStates = [
  //   true,
  //   true,
  //   true,
  //   false,
  //   false,
  //   false,
  //   false,
  //   false,
  //   false,
  //   false,
  //   false,
  //   false,
  //   false,
  //   false,
  //   false,
  //   false,
  //   false,
  //   false,
  //   false,
  //   false,
  //   false,
  //   false,
  //   false,
  //   false,
  //   false,
  //   false,
  //   false,
  //   false,
  //   false,
  //   false,
  // ];

  String? userUID = FirebaseAuth.instance.currentUser?.uid;
  String? pairUID = '';
  UserData userData = UserData(displayName: '', isJuzDone: {}, pairUID: '');
  UserData pairData = UserData(displayName: '', isJuzDone: {}, pairUID: '');

  getUserDataFromUsersCollection() async {
    emit(HomePageGetUserDataLoading());
    //get collection
    final collection = FirebaseFirestore.instance.collection('users');
    //get document
    final doc = await collection.doc(userUID).get();
    //get data
    final data = doc.data();
    pairUID = data?['pairs'][0];

    print(data!['name']);

    userData = UserData.fromJson(data);
    print('*******Data of' + userData.displayName);
    print('*******PAir of' + userData.pairUID);
    pairData = UserData(
      displayName: '',
      isJuzDone: {},
      pairUID: userData.pairUID,
    );
    print(userData.isJuzDone);

    // mapToListOrderedWithKeys();
    emit(HomePageGetUserDataSuccess(userData: userData));

    //return data
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getDataSnapshot(String uid) {
    return FirebaseFirestore.instance.collection('users').doc(uid).snapshots();
  }

  void printData(UserData data) {
    print('+++++Name+++++' + data.displayName);
    print('+++++Pair+++++' + data.pairUID);
    print('+++++Juz+++++' + data.isJuzDone.toString());
    // print('+++++List+++++' + juzList.toString());
  }

  getPairData() async {
    emit(HomePageGetPairDataLoading());
    //get collection
    final collection = FirebaseFirestore.instance.collection('users');
    //get document

    final doc = await collection.doc(pairUID).get();
    //get data
    final data = doc.data();
    print(data?['name']);
    if (data != null) pairData = UserData.fromJson(data);
    print('*******Data of' + pairData.displayName);
    print(pairData.isJuzDone);

    emit(HomePageGetPairDataSuccess(pairData: pairData));
    //return data
  }

  // List<bool> juzList = [false];
  // mapToListOrderedWithKeys() {
  //   for (var e in userData.isJuzDone.entries) {
  //     juzList.insert(int.parse(e.key), e.value);
  //   }
  // }

  Map<String, dynamic> juzToFirestore = {
    '0': true,
    '1': true,
    '2': true,
    '3': true,
    '4': true,
    '5': true,
    '6': true,
    '7': false,
    '8': false,
    '9': false,
    '10': false,
    '11': false,
    '12': false,
    '13': false,
    '14': false,
    '15': false,
    '16': false,
    '17': false,
    '18': false,
    '19': false,
    '20': false,
    '21': false,
    '22': false,
    '23': false,
    '24': false,
    '25': false,
    '26': false,
    '27': false,
    '28': false,
    '29': false,
  };

  void onButtomJuzState(int index) async {
    emit(HomePageJuzLoading());
    //setState of model controller is enough

    // juzStates[index] = !juzStates[index];
    userData.isJuzDone['$index'] = !userData.isJuzDone['$index'];
    await updateDataToFirestore(index).then((value) {
      emit(HomePageJuzCompleted());
    });
  }

  updateDataToFirestore(int index) async {
    // emit(HomePageUpdateDataLoading());
    FirebaseFirestore.instance.collection('users').doc(userUID).update(
      {
        // 'name': userData.displayName,
        // 'juz_states': userData.isJuzDone[index],
        'juz.$index': userData.isJuzDone['$index'],

        // 'pairs': [pairUID],
      },
    );
    // emit(HomePageUpdateDataSuccess());
  }

  // addDataToFirestore() {
  //   FirebaseFirestore.instance.collection('users').doc(userUID).set(
  //     {
  //       'name': userData.displayName,
  //       'juz': juzToFirestore,
  //       'pairs': [pairUID],
  //     },
  //     SetOptions(merge: true),
  //   );
  // }
}
