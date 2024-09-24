import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vcu/models/userdata.dart';
import 'package:vcu/screens/assignment/showassignment.dart';
import 'package:vcu/screens/attendance/attendance.dart';
import 'package:vcu/screens/doubts/doubts.dart';
import 'package:vcu/screens/home_screen/cta/cta_card.dart';
import 'package:vcu/screens/marks/marks.dart';
import 'package:vcu/screens/report/report.dart';
import 'package:vcu/screens/timetable/timetable.dart';

class CTAS extends StatelessWidget {
  CTAS({Key? key, required this.userData}) : super(key: key);
  final UserData userData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          IntrinsicHeight(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: CtaCard(
                    bColor: Color(0xffADA2FF),
                    ctaction: MarksScreen(
                      userData: userData,
                    ),
                    title: 'Marks',
                    icon: Icon(
                      FontAwesomeIcons.chartColumn,
                      size: 50,
                      color: Color(0xffADA2FF),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: CtaCard(
                    bColor: Color(0xffFFAACF),
                    ctaction: DoubtScreen(
                      userData: userData,
                    ),
                    title: 'Ask Doubt',
                    icon: Icon(
                      FontAwesomeIcons.solidCircleQuestion,
                      size: 50,
                      color: Color(0xffFFAACF),
                    ),
                  ),
                ),
              ],
            ),
          ),
          IntrinsicHeight(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: CtaCard(
                    bColor: Color(0xff6F69AC),
                    ctaction: TimetableScreen(
                      userData: userData,
                    ),
                    title: 'Timetable',
                    icon: Icon(
                      FontAwesomeIcons.solidCalendarCheck,
                      size: 50,
                      color: Color(0xff6F69AC),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: CtaCard(
                    bColor: Color(0XFF53BF9D),
                    ctaction: ReportScreen(
                      userData: userData,
                    ),
                    title: 'Report',
                    icon: Icon(
                      FontAwesomeIcons.book,
                      size: 50,
                      color: Color(0XFF53BF9D),
                    ),
                  ),
                ),
              ],
            ),
          ),
          IntrinsicHeight(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: CtaCard(
                    bColor: Color(0XFF3DB2FF),
                    ctaction: ShowAssignment(
                      userData: userData,
                    ),
                    title: 'Assignment',
                    icon: Icon(
                      FontAwesomeIcons.filePdf,
                      size: 50,
                      color: Color(0XFF3DB2FF),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: CtaCard(
                    bColor: Color(0xffFF1700),
                    ctaction: AttendanceScreen(
                      userData: userData,
                    ),
                    title: 'Attendance',
                    icon: Icon(
                      Icons.alarm,
                      size: 50,
                      color: Color(0xffFF1700),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // GridView.count(
          //     shrinkWrap: true,
          //     crossAxisCount: 2,
          //     crossAxisSpacing: 8.0,
          //     mainAxisSpacing: 8.0,
          //     children: List.generate(
          //       ctalist.length,
          //       (index) {
          //         return GestureDetector(
          //           onTap: (){},
          //           child: CtaCard(
          //             action: ctalist[index],
          //           ),
          //         );
          //       },
          //     )),
        ],
      ),
    );
  }
}
