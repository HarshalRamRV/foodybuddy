// import 'dart:io';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
  
// import 'package:flutter/cupertino.dart';
  
//   class PushNotifications{
//     final FirebaseMessaging _fcm = FirebaseMessaging();
//     final NavigationService _navigationService = loacator<NavigationService>;

//     Future initialise() async{
//       if (Platform.isIOS) {
//       // request permission if we're on android
//       _fcm.requestNotificationPermissions(IosNotficationSetting());
//     }
//       _fcm.configure(
//         onMessage: (Map<String, dynamic> message) async{
//          print('onMessage: $message');
//         },
//          onLaunch: (Map<String, dynamic> message) async{
//          print('onLaunch: $message');
//          _serialiseAndNavigate(message);
         
//         },
//          onResume: (Map<String, dynamic> message) async{
//          print('onMessage: $message');
//          _serialiseAndNavigate(message);
//         }
//       );
//     } 

//     void _serialiseAndNavigate(Map<String, dynamic> message){
//       var notificationDate = message['date'];
//       var view = notificationDate['view'];

//       if(view is null) {

//         if(view == 'create_post'){
//           _navigationService.navigateTo(create_postViewRoute)

//         }
//       }
//     }
//   }