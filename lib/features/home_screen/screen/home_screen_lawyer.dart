import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:justice_link/features/auth/services/auth_service.dart';
import 'package:justice_link/features/case_status/screens/case_status.dart';
import 'package:justice_link/features/contact_us/screens/contact_us_screen.dart';
import 'package:justice_link/features/feedback/screens/feedback_screen.dart';
import 'package:justice_link/features/home_screen/widgets/app_bar_container.dart';
import 'package:justice_link/features/home_screen/widgets/drawer_item.dart';
import 'package:justice_link/features/home_screen/widgets/eServices_lawyer.dart';
import 'package:justice_link/features/home_screen/widgets/key_features_lawyer.dart';
import 'package:justice_link/features/medical_updates/screens/medical_updates.dart';
import 'package:justice_link/features/meetings/screens/meeting_screen.dart';
import 'package:justice_link/features/profile/screens/profile_screen.dart';

class HomeScreenLawyer extends ConsumerStatefulWidget {
  const HomeScreenLawyer({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreenLawyer> createState() => _HomeScreen();
}

// enum DrawerItems { caseStatus, medicalUpdates, needHelp }
class _HomeScreen extends ConsumerState<HomeScreenLawyer> {
  List<String> drawerItems = [
    "Case Status",
    "Medical Updates",
    "Need Help",
    "Meetings Request",
    "Guidelines",
    "Fundamental Rights",
    "Reminders",
    "Contact Us"
  ];
  void logOut(BuildContext context) {
    ref.read(authServiceProvider).logOut(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color(0xFF004D14), size: 30),
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: Color(0xFF046200)),
      ),
      endDrawer: Drawer(
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Color(0xFF098904),
              Color(0xFF004111),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 0.9],
          )),
          child: Column(
            children: [
              SizedBox(
                height: 120,
                child: DrawerHeader(
                  decoration: const BoxDecoration(
                    color: Color(0xFF004D14),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 60,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 12, 117, 9),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: GestureDetector(
                            onTap: () => {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ProfileScreen(),
                                    ),
                                  ),
                                },
                            child: Image.asset("assets/images/profile.png")),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Welcome",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () => {Navigator.pop(context)},
                                child: const RotatedBox(
                                    quarterTurns: 2,
                                    child: Icon(
                                      Icons.arrow_back_ios,
                                      color: Colors.white,
                                      size: 35,
                                    )),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              ListView.builder(
                itemCount: drawerItems.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      if (index == 0) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const CaseStatus(),
                          ),
                        );
                      } else if (index == 1) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const MedicalUpdates(),
                          ),
                        );
                      } else if (index == 3) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const MeetingScreen(),
                          ),
                        );
                      }
                    },
                    child: DrawerItem(
                        icon: "assets/drawer_images/$index.png",
                        text: drawerItems[index]),
                  );
                },
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 50.0),
                child: ElevatedButton(
                  onPressed: () {
                    logOut(context);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Log Out",
                        style: TextStyle(
                            color: Color(0xFF098904),
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                      Image.asset("assets/images/logout.png")
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          const TopBar(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "eServices",
                  style: TextStyle(
                      color: Color(0xFF046200),
                      fontSize: 15,
                      fontWeight: FontWeight.w800),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(top: 12),
                    height: 1.0,
                    // width: double.infinity,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          const EServicesLawyer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Key Features",
                  style: TextStyle(
                      color: Color(0xFF046200),
                      fontSize: 15,
                      fontWeight: FontWeight.w800),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(top: 12),
                    height: 1.0,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          const KeyFeaturesLawyer(),
          Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 19),
            child: Container(
              width: double.infinity,
              height: 66,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 20,
                    spreadRadius: 1)
              ], color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Image.asset("assets/images/reminders.png",
                            height: 25,
                            width: 25,
                            color: const Color.fromARGB(255, 4, 50, 2)),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          "Reminders",
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () => {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const FeedBack(),
                              ),
                            ),
                          },
                          child: Image.asset(
                            "assets/images/feedback.png",
                            height: 25,
                            width: 25,
                            color: const Color.fromARGB(255, 9, 46, 7),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          "Feedback",
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () => {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const ContactUs(),
                              ),
                            ),
                          },
                          child: Image.asset(
                            "assets/images/contact.png",
                            height: 25,
                            width: 25,
                            color: const Color.fromARGB(255, 4, 78, 1),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          "Contact Us",
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Text(
            "All Rights Reserved @ 2023",
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
          ),
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: Image.asset(
                "assets/images/par.png",
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          )
        ],
      ),
    );
  }
}
