import 'dart:io';
import 'package:final_submission/helpers/notification_helper.dart';
import 'package:final_submission/pages/detail_screen.dart';
import 'package:final_submission/providers/scheduling_provider.dart';
import 'package:final_submission/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../themes/dimensions.dart';

class NotificationScreen extends StatefulWidget {
  static const routeName = "/notification-screen";

  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final NotificationHelper _notificationHelper = NotificationHelper();

  @override
  void initState() {
    super.initState();
    _notificationHelper
        .configureSelectNotificationSubject(DetailScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SchedulingProvider>(
        create: (_) => SchedulingProvider(),
        child: Scaffold(
          body: SafeArea(
              child: ListView(scrollDirection: Axis.vertical, children: [
            Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              IconButton(
                padding: const EdgeInsets.all(16.0),
                icon: Icon(
                  Icons.arrow_back_ios_rounded,
                  size: Dimensions.icon_30,
                  color: Colors.black87,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Setting Notification',
                  style: GoogleFonts.comfortaa(
                      textStyle: const TextStyle(
                          color: Colors.black87,
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold)),
                ),
              ),
            ]),
            Material(
                child: ListTile(
              title: const Text("Scheduling Restaurant"),
              trailing: Consumer<SchedulingProvider>(
                  builder: (context, scheduled, _) {
                return Switch.adaptive(
                    value: scheduled.isScheduled,
                    onChanged: (value) async {
                      if (Platform.isIOS) {
                        customDialog(context);
                      } else {
                        scheduled.scheduledRestaurant(value);
                      }
                    });
              }),
            ))
          ])),
        ));
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }
}
