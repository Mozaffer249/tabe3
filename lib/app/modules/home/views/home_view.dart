// ignore_for_file: invalid_use_of_protected_member

import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:tabee3_flutter/app/data/common/announcement_card_widget.dart';
import 'package:tabee3_flutter/app/data/common/basic_drawer.dart';
import 'package:tabee3_flutter/app/data/common/constants.dart';
import 'package:tabee3_flutter/app/data/common/subject_card.dart';
import 'package:tabee3_flutter/app/data/models/announcement_model.dart';
import 'package:tabee3_flutter/app/data/models/student_model.dart';
import 'package:tabee3_flutter/app/data/models/subject_model.dart';
import 'package:tabee3_flutter/app/routes/app_pages.dart';
import 'package:tabee3_flutter/app/utils/dialog_utils.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      key: controller.scaffoldKey,
      drawer: BasicDrawer(),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.all(8.0),
          child: RefreshIndicator(
            onRefresh: controller.getAnnouncments,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Container(
                      // height: screenHeight * 0.16,
                      width: screenWidth * 1.00,
                      decoration: BoxDecoration(
                        color: Color(0xff00CDDA),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 196, 194, 194),
                            blurRadius: 8.0,
                            spreadRadius: 1,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: SvgPicture.asset('assets/svg/appbar.svg'),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                      icon: SvgPicture.asset(
                                        'assets/svg/menu.svg',
                                        matchTextDirection: true,
                                      ),
                                      onPressed: () {
                                        controller.scaffoldKey.currentState!.openDrawer();
                                      },
                                      color: Colors.white,
                                    ),
                                    IconButton(
                                      icon: SvgPicture.asset(
                                        'assets/svg/chat.svg',
                                      ),
                                      onPressed: () {
                                      Get.toNamed(Routes.CHAT);
                                      },
                                      color: Colors.white,
                                    ),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          if (controller.authController
                                                  .currentUser!.userType! ==
                                              'P')
                                            buildStudentsPopupMenu()
                                          else
                                            _buildSubjectsPopupMenu(),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Wrap(
                                      children: [
                                        Text(
                                          "welcomeUser".trParams({
                                            'name': controller.authController
                                                    .currentUser!.name ??
                                                '-'
                                          }),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 17.0,
                                            color: Colors.white,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      controller.authController.currentUser!
                                          .schoolName!,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  SingleChildScrollView(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (controller.isLoadingAnnouncments)
                          Container(
                            height: 200,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        else if (controller.announcements.isNotEmpty)
                          Container(
                            child: CarouselSlider.builder(
                              itemCount: controller.announcements.length,
                              itemBuilder: (context, index, _) {
                                final studentAnnouncement =
                                    controller.announcements[index];
                                final announcement = Announcement(
                                  name: studentAnnouncement.title ?? '-',
                                  body: studentAnnouncement.body ?? '-',
                                  date: studentAnnouncement.date ??
                                      DateTime.now(),
                                );
                                return Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                  ),
                                  child: AnnouncementCardWidget(
                                    announcement: announcement,
                                    onTap: () {
                                      Get.toNamed(
                                        Routes.ANNOUNCEMENT_DETAILS,
                                        arguments: announcement,
                                      );
                                    },
                                  ),
                                );
                              },
                              options: CarouselOptions(
                                height: 200,
                                viewportFraction: 1,
                                aspectRatio: 16 / 9,
                                enableInfiniteScroll:
                                    controller.announcements.length == 1
                                        ? false
                                        : true,
                                autoPlay: true,
                              ),
                            ),
                          ),
                        SizedBox(height: 16),
                        if (controller.authController.currentUser!.userType == "P")
                          _buildParentSection()
                        else
                          _buildTeacherSection()
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Column _buildTeacherSection(){
    return Column(
      children: [
        GridView(
          shrinkWrap: true,
          primary: false,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            mainAxisExtent: 100,
            crossAxisSpacing: 16,
          ),
          children: <Widget>[
            _buildDashbaordCard(
              title: "Attendance".tr,
              icon: "assets/images/attencance.png",
              onTap: () {
           Get.toNamed(
                  Routes.ATTENCANCE,
                  arguments: controller.subject.value,
                );
              },
            ),
            _buildDashbaordCard(
              title: "Lectures".tr,
              icon: "assets/images/lectures.png",
              backgroundIconAlignment: Alignment(-1, 1),
              backgroundIcon: 'assets/svg/arc1.svg',
              onTap: () {
                if (controller.subject.value != null) {

                  Get.toNamed(
                    Routes.LECTURES,
                    arguments: controller.subject.value,
                  );
                } else {
                  Get.showSnackbar(GetSnackBar(
                    title: 'Error'.tr,
                    message: 'Please select subject'.tr,
                  ));
                }
              },
            ),
            _buildDashbaordCard(
              title: "Exams schedule".tr,
              icon: "assets/images/time1.png",
              backgroundIconAlignment: Alignment(-1, 1),
              backgroundIcon: 'assets/svg/arc1.svg',
              onTap: () {
               Get.toNamed(Routes.EDIT_EXAMS_SCHEDULE);
              },
            ),
            _buildDashbaordCard(
              title: "Results".tr,
              icon: "assets/images/results.png",
              backgroundIconAlignment: Alignment(1, 1),
              backgroundIcon: 'assets/svg/arc3.svg',
              onTap: () {
                 Get.toNamed(
                  Routes.RESULTS,
                  arguments: controller.subject.value,
                );
              },
            ),
            _buildDashbaordCard(
              title: "Schedule".tr,
              icon: "assets/images/calendar1.png",
              backgroundIconAlignment: Alignment(1, 1),
              backgroundIcon: 'assets/svg/arc3.svg',
              onTap: () {
                 Get.toNamed(Routes.TEACHER_SUBJECT_SCHEDULE);
              },
            ),
            _buildDashbaordCard(
              title: "Announcement control".tr,
              icon: "assets/images/announce.png",
              backgroundIconAlignment: Alignment(1, 1),
              backgroundIcon: 'assets/svg/arc3.svg',
              onTap: () {
               Get.toNamed(
                  Routes.ANNOUNCEMENTS,
                  arguments: controller.subject.value,
                );
              },
            ),
            _buildDashbaordCard(
              title: "Behaviors".tr,
              icon: "assets/images/exam1.png",
              backgroundIconAlignment: Alignment(1, 1),
              backgroundIcon: 'assets/svg/arc3.svg',
              onTap: () {
           Get.toNamed(Routes.BEHAVIORS);
              },
            ),
            _buildDashbaordCard(
              title: "Tests".tr,
              icon: "assets/images/time1.png",
              backgroundIconAlignment: Alignment(1, 1),
              backgroundIcon: 'assets/svg/arc3.svg',
              onTap: () {
                 Get.toNamed(Routes.TESTS);
              },
            ),
          ],
        ),
        SizedBox(height: 24),
      ],
    );
  }

  Column _buildParentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "subjects".tr,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
            Spacer(),
            TextButton(
              onPressed: () =>   Get.toNamed(
                Routes.ALL_SUBJECTS,
                arguments: controller.studentSubjects,
              ),
              child: Text(
                "viewAll".tr,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[400],
                ),
              ),
            ),
            // buildSemester123(),
            SvgPicture.asset('assets/svg/arrow_forward.svg'),
          ],
        ),
        if (controller.isLoadingSubjects)
          Container(
            height: 150,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        else if (controller.studentSubjects.isNotEmpty)
          Container(
            height: 160,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.all(1),
                child: Row(
                  children: controller.studentSubjects
                      .map(
                        (subject) => _buildSubjectCard(
                          "${subject.name}",
                          Color(
                            (math.Random().nextDouble() * 0xFFFFFF).toInt(),
                          ).withOpacity(1.0),
                          () =>  Get.toNamed(
                            Routes.SUBJECT,
                            arguments:[
                               subject,
                               controller.student.value!.classId
                            ] ,
                          ),
                          subject.image!,
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          )
        else
          Container(
            height: 150,
            alignment: Alignment.center,
            child: Text(
              'No Subjects for this student'.tr,
            ),
          ),
        Text(
          "services".tr,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
        ),
        GridView(
          shrinkWrap: true,
          primary: false,
          padding: const EdgeInsets.all(8),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            mainAxisExtent: 100,
          ),
          children: <Widget>[
            _buildDashbaordCard(
              title: "materialTable".tr,
              icon: "assets/images/calendar1.png",
              onTap: () {

                Get.toNamed(Routes.SUBJECTS_SCHEDULE, arguments: controller.student.value,);
              },
            ),
            _buildDashbaordCard(
              title: "results".tr,
              icon: "assets/images/exam1.png",
              backgroundIconAlignment: Alignment(-1, 1),
              backgroundIcon: 'assets/svg/arc1.svg',
              onTap: () {

                Get.toNamed(Routes.RESULT, arguments: controller.student.value,);
              },
            ),
            _buildDashbaordCard(
              title: "examsSchedule".tr,
              icon: "assets/images/time1.png",
              backgroundIconAlignment: Alignment(-1, 1),
              backgroundIcon: 'assets/svg/arc1.svg',
              onTap: () {

                Get.toNamed(
                  Routes.EXAMS_SCHEDULE,
                  arguments: controller.student.value,
                );
              },
            ),
            _buildDashbaordCard(
              title: "Behaviors".tr,
              icon: "assets/images/exam1.png",
              backgroundIconAlignment: Alignment(1, 1),
              backgroundIcon: 'assets/svg/arc3.svg',
              onTap: () {

                Get.toNamed(Routes.BEHAVIORS,arguments: controller.student.value!.studentId!);
              },
            ),
            _buildDashbaordCard(
              title: "Attendence Report".tr,
              icon: "assets/images/exam1.png",
              backgroundIconAlignment: Alignment(1, 1),
              backgroundIcon: 'assets/svg/arc3.svg',
              onTap: () {

                Get.toNamed(Routes.STUDENT_ATTENDENCE_REPORT,arguments: controller.student.value!.studentId);
              },
            ),
            _buildDashbaordCard(
              title: "payment".tr,
              icon: "assets/images/money1.png",
              backgroundIconAlignment: Alignment(1, 1),
              backgroundIcon: 'assets/svg/arc3.svg',
              onTap: () {
                 Get.toNamed(Routes.PAYMENT);
              },
            ),
          ],
        ),
        SizedBox(height: 24),
      ],
    );
  }

  Container _buildDashbaordCard({
    required String title,
    required String icon,
    String backgroundIcon = "assets/svg/subtract_1.svg",
    Alignment? backgroundIconAlignment,
    VoidCallback? onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xff00CDDA),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 196, 194, 194),
            blurRadius: 8.0,
            spreadRadius: 1,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: InkResponse(
        onTap:onTap,
        child: Container(
          child: Stack(
            children: [
              Positioned(
                child: Align(
                  alignment: backgroundIconAlignment ?? Alignment(1, -1),
                  child: Container(
                    child: SvgPicture.asset(
                      backgroundIcon,
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          child: Image.asset(
                            icon,
                            width: 40,
                            height: 40,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubjectCard(
    String name,
    Color color,
    Function() onPressed,
    String image,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: SubjectCard(
        name: name,
        color: color,
        onPressed: onPressed,
        image: image,
      ),
    );
  }

  Widget _buildSubjectsPopupMenu() {
    return PopupMenuButton<Subject>(
      onSelected: (value) {
        controller.selectClass(value);
      },
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: kMainColor,
                width: 5,
              ),
              borderRadius: BorderRadius.circular(
                50,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: controller.subject.value!.image!,
                height: 30,
                width: 30,
                placeholder: (context, url) => Image.asset(
                  'assets/images/loading.gif',
                  fit: BoxFit.cover,
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
          SizedBox(width: 8),
          Text(
            '${controller.subject.value!.name}',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          SizedBox(width: 8),
          SvgPicture.asset(
            'assets/svg/dropdown.svg',
          ),
        ],
      ),
      initialValue: controller.subject.value,
      itemBuilder: (context) => controller.authController.teacherSubjects
          .map(
            (e) => PopupMenuItem(
              value: e,
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: e.image!,
                      height: 30,
                      width: 30,
                      placeholder: (context, url) => Image.asset(
                        'assets/images/loading.gif',
                        fit: BoxFit.cover,
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    '${e.name}',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }

  Widget buildStudentsPopupMenu() {
    return PopupMenuButton<Student>(
      onSelected: (value) {
        controller.selectStudent(value);
      },
      itemBuilder: (context) => controller.students.value
          .map(
            (e) => PopupMenuItem<Student>(
              value: e,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${e.studentName}',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  Text(
                    '${e.studentClass}',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
            ),
          ).toList(),
      child: Row(
        children: [
          if (controller.isLoadingStudents)
            Container(
              height: 24,
              width: 24,
              child: Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
            )
          else
            Text(
              '${controller.student.value!.studentName}',
              style: Get.theme.textTheme.titleLarge!.copyWith(
                color: Colors.white,
              ),
            ),
          SizedBox(width: 10),
          SvgPicture.asset(
            'assets/svg/dropdown.svg',
          ),
        ],
      ),
    );
  }

  Widget buildSubjectsPopupMenu() {
    return PopupMenuButton(
      itemBuilder: (context) => controller.students.value
          .map(
            (e) => PopupMenuItem(
              value: e,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${e.studentName}',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  Text(
                    '${e.studentClass}',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
      icon: SvgPicture.asset(
        'assets/svg/dropdown.svg',
      ),
    );
  }
}
