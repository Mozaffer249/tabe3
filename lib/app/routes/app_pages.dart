import 'package:get/get.dart';
import 'package:tabee3_flutter/app/modules/add_behavior/binding/add_behavior_binding.dart';
import 'package:tabee3_flutter/app/modules/add_behavior/view/add_behavior_view.dart';
import 'package:tabee3_flutter/app/modules/add_question/binding/add_question_binding.dart';
import 'package:tabee3_flutter/app/modules/add_question/view/add_question_view.dart';
import 'package:tabee3_flutter/app/modules/add_test/binding/add_test_binding.dart';
import 'package:tabee3_flutter/app/modules/add_test/view/add_test_view.dart';
import 'package:tabee3_flutter/app/modules/behavior_details/binding/behavior_details_binding.dart';
import 'package:tabee3_flutter/app/modules/behavior_details/view/behavior_details_view.dart';
import 'package:tabee3_flutter/app/modules/behaviors/binding/behavior_binding.dart';
import 'package:tabee3_flutter/app/modules/behaviors/view/bevavior_view.dart';
import 'package:tabee3_flutter/app/modules/lecture_details/binding/lecture_details_binding.dart';
import 'package:tabee3_flutter/app/modules/lecture_details/view/lecture_details_view.dart';
import 'package:tabee3_flutter/app/modules/subject/views/lecture_details.dart';
import 'package:tabee3_flutter/app/modules/multi_message/binding/multi_message_binding.dart';
import 'package:tabee3_flutter/app/modules/student_attendence_report/binding/student_attendence_binding.dart';
import 'package:tabee3_flutter/app/modules/student_attendence_report/view/student_attendence_view.dart';
import 'package:tabee3_flutter/app/modules/test_questions/binding/test_questions_binding.dart';
import 'package:tabee3_flutter/app/modules/test_questions/views/test_question_view.dart';
import 'package:tabee3_flutter/app/modules/tests/binding/tests_bindings.dart';
import 'package:tabee3_flutter/app/modules/tests/views/tests_view.dart';
import '../modules/Announcement_details/bindings/announcement_details_binding.dart';
import '../modules/Announcement_details/views/announcement_details_view.dart';
import '../modules/about/bindings/about_binding.dart';
import '../modules/about/views/about_view.dart';
import '../modules/add_announcement/bindings/add_announcement_binding.dart';
import '../modules/add_announcement/views/add_announcement_view.dart';
import '../modules/add_lecture/bindings/add_lecture_binding.dart';
import '../modules/add_lecture/views/add_lecture_view.dart';
import '../modules/all_subjects/bindings/all_subjects_binding.dart';
import '../modules/all_subjects/views/all_subjects_view.dart';
import '../modules/announcements/bindings/announcements_binding.dart';
import '../modules/announcements/views/announcements_view.dart';
import '../modules/attencance/bindings/attencance_binding.dart';
import '../modules/attencance/views/attencance_view.dart';
import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/auth_view.dart';
import '../modules/chat/bindings/chat_binding.dart';
import '../modules/chat/views/chat_view.dart';
import '../modules/edit_exams_schedule/bindings/edit_exams_schedule_binding.dart';
import '../modules/edit_exams_schedule/views/edit_exams_schedule_view.dart';
import '../modules/end/bindings/end_binding.dart';
import '../modules/end/views/end_view.dart';
import '../modules/exam/bindings/exam_binding.dart';
import '../modules/exam/views/exam_view.dart';
import '../modules/exams_schedule/bindings/exams_schedule_binding.dart';
import '../modules/exams_schedule/views/exams_schedule_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/image_viewer/bindings/image_viewer_binding.dart';
import '../modules/image_viewer/views/image_viewer.dart';
import '../modules/lectures/bindings/lectures_binding.dart';
import '../modules/lectures/views/lectures_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/main_exam/bindings/main_exam_binding.dart';
import '../modules/main_exam/views/main_exam_view.dart';
import '../modules/multi_message/view/multi_message_view.dart';
import '../modules/new_chat/bindings/new_chat_binding.dart';
import '../modules/new_chat/views/new_chat_view.dart';
import '../modules/payment/bindings/payment_binding.dart';
import '../modules/payment/views/payment_view.dart';
import '../modules/privacy_policy/bindings/privacy_policy_binding.dart';
import '../modules/privacy_policy/views/privacy_policy_view.dart';
import '../modules/reset_pasword/bindings/reset_pasword_binding.dart';
import '../modules/reset_pasword/views/reset_pasword_view.dart';
import '../modules/result/bindings/result_binding.dart';
import '../modules/result/views/result_view.dart';
import '../modules/results/bindings/results_binding.dart';
import '../modules/results/views/results_view.dart';
import '../modules/show_tabs/bindings/show_tabs_binding.dart';
import '../modules/show_tabs/views/show_tabs_view.dart';
import '../modules/sign_up/bindings/sign_up_binding.dart';
import '../modules/sign_up/views/sign_up_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/start/bindings/start_binding.dart';
import '../modules/start/views/start_view.dart';
import '../modules/start_chat/bindings/start_chat_binding.dart';
import '../modules/start_chat/views/start_chat_view.dart';
import '../modules/student_statistics/bindings/student_statistics_binding.dart';
import '../modules/student_statistics/views/student_statistics_view.dart';
import '../modules/subject/bindings/subject_binding.dart';
import '../modules/subject/views/subject_view.dart';
import '../modules/subjects_schedule/bindings/subjects_schedule_binding.dart';
import '../modules/subjects_schedule/views/subjects_schedule_view.dart';
import '../modules/submit_attendance/bindings/submit_attendance_binding.dart';
import '../modules/submit_attendance/views/submit_attendance_view.dart';
import '../modules/teacher_subject_schedule/bindings/teahcer_subject_schedule_binding.dart';
import '../modules/teacher_subject_schedule/views/teahcer_subject_schedule_view.dart';
import '../modules/terms_conditions/bindings/terms_conditions_binding.dart';
import '../modules/terms_conditions/views/terms_conditions_view.dart';
import '../modules/verify/bindings/verify_binding.dart';
import '../modules/verify/views/verify_view.dart';
import '../modules/view_attendance/bindings/view_attendance_binding.dart';
import '../modules/view_attendance/views/view_attendance_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();
  static const INITIAL = Routes.SPLASH;
  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.START,
      page: () => StartView(),
      binding: StartBinding(),
    ),
    GetPage(
      name: _Paths.SHOW_TABS,
      page: () => ShowTabsView(),
      binding: ShowTabsBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.RESET_PASWORD,
      page: () => ResetPaswordView(),
      binding: ResetPaswordBinding(),
    ),
    GetPage(
      name: _Paths.VERIFY,
      page: () => VerifyView(),
      binding: VerifyBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_UP,
      page: () => SignUpView(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: _Paths.RESULT,
      page: () => ResultView(),
      binding: ResultBinding(),
    ),
    GetPage(
      name: _Paths.CHAT,
      page: () => ChatView(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: _Paths.START_CHAT,
      page: () => StartChatView(),
      binding: StartChatBinding(),
    ),
    GetPage(
      name: _Paths.SUBJECTS_SCHEDULE,
      page: () => SubjectsScheduleView(),
      binding: SubjectsScheduleBinding(),
    ),
    GetPage(
      name: _Paths.PAYMENT,
      page: () => PaymentView(),
      binding: PaymentBinding(),
    ),
    GetPage(
      name: _Paths.EXAMS_SCHEDULE,
      page: () => ExamsScheduleView(),
      binding: ExamsScheduleBinding(),
    ),
    GetPage(
      name: _Paths.ALL_SUBJECTS,
      page: () => AllSubjectsView(),
      binding: AllSubjectsBinding(),
    ),
    GetPage(
      name: _Paths.END,
      page: () => EndView(),
      binding: EndBinding(),
    ),
    GetPage(
      name: _Paths.SUBJECT,
      page: () => SubjectView(),
      binding: SubjectBinding(),
    ),
    GetPage(
      name: _Paths.AUTH,
      page: () => AuthView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.EXAM,
      page: () => ExamView(),
      binding: ExamBinding(),
    ),
    GetPage(
      name: _Paths.MAIN_EXAM,
      page: () => MainExamView(),
      binding: MainExamBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.ATTENCANCE,
      page: () => AttencanceView(),
      binding: AttencanceBinding(),
    ),
    GetPage(
      name: _Paths.LECTURES,
      page: () => LecturesView(),
      binding: LecturesBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_EXAMS_SCHEDULE,
      page: () => EditExamsScheduleView(),
      binding: EditExamsScheduleBinding(),
    ),
    GetPage(
      name: _Paths.RESULTS,
      page: () => ResultsView(),
      binding: ResultsBinding(),
    ),
    GetPage(
      name: _Paths.ANNOUNCEMENTS,
      page: () => AnnouncementsView(),
      binding: AnnouncementsBinding(),
    ),
    GetPage(
      name: _Paths.TEACHER_SUBJECT_SCHEDULE,
      page: () => TeacherSubjectScheduleView(),
      binding: TeacherSubjectScheduleBinding(),
    ),
    GetPage(
      name: _Paths.STUDENT_STATISTICS,
      page: () => StudentStatisticsView(),
      binding: StudentStatisticsBinding(),
    ),
    GetPage(
      name: _Paths.ADD_LECTURE,
      page: () => AddLectureView(),
      binding: AddLectureBinding(),
    ),
    GetPage(
      name: _Paths.ADD_ANNOUNCEMENT,
      page: () => AddAnnouncementView(),
      binding: AddAnnouncementBinding(),
    ),
    GetPage(
      name: _Paths.NEW_CHAT,
      page: () => NewChatView(),
      binding: NewChatBinding(),
    ),
    GetPage(
      name: _Paths.ANNOUNCEMENT_DETAILS,
      page: () => AnnouncementDetailsView(),
      binding: AnnouncementDetailsBinding(),
    ),
    GetPage(
      name: _Paths.TERMS_CONDITIONS,
      page: () => TermsConditionsView(),
      binding: TermsConditionsBinding(),
    ),
    GetPage(
      name: _Paths.PRIVACY_POLICY,
      page: () => PrivacyPolicyView(),
      binding: PrivacyPolicyBinding(),
    ),
    GetPage(
      name: _Paths.ABOUT,
      page: () => AboutView(),
      binding: AboutBinding(),
    ),
    GetPage(
      name: _Paths.IMAGE_VIEWER,
      page: () => ImageViewer(),
      binding: ImageViewerBinding(),
    ),
    GetPage(
      name: _Paths.VIEW_ATTENDANCE,
      page: () => ViewAttendanceView(),
      binding: ViewAttendanceBinding(),
    ),
    GetPage(
      name: _Paths.SUBMIT_ATTENDANCE,
      page: () => SubmitAttendanceView(),
      binding: SubmitAttendanceBinding(),
    ),
    GetPage(
      name: _Paths.LECTURE_DETAILS,
      page: () => LectureDetails(),
      binding: LectureDetailsBinding(),
    ),
    GetPage(
      name: _Paths.MULTI_MESSAGE,
      page: () => MultiMessageView(),
      binding: MultiMessageBinding(),
    ),
    GetPage(
      name: _Paths.STUDENT_ATTENDENCE_REPORT,
      page: () => StudentAttendenceReporView(),
      binding: StudentAttendenceReportBinding(),
    ),
    GetPage(
      name: _Paths.BEHAVIORS,
      page: () => BehaviorView(),
      binding: BehaviorBinding(),
    ),
    GetPage(
      name: _Paths.ADDBEHAVIOR,
      page: () => AddBehaviorView(),
      binding: AddBehaviorBinding(),
    ),
    GetPage(
      name: _Paths.BEHAVIOR_DETAILS,
      page: () => BehaviorDetailsView(),
      binding: BehaviorDetailsBinding(),
    ),
    GetPage(
      name: _Paths.BEHAVIOR_DETAILS,
      page: () => BehaviorDetailsView(),
      binding: BehaviorDetailsBinding(),
    ),
    GetPage(
      name: _Paths.TESTS,
      page: () => TestView(),
      binding: TestBinding(),
    ),
    GetPage(
      name: _Paths.TEST_QUESTIONS,
      page: () => TestQuestionsView(),
      binding: TestQuestionsBinding(),
    ),
    GetPage(
      name: _Paths.ADD_QUESTION,
      page: () => AddQuestionView(),
      binding: AddQuestionBinding(),
    ),
    GetPage(
      name: _Paths.ADD_TEST,
      page: () => AddTestView(),
      binding: AddTestBinding(),
    ),
    GetPage(
      name: _Paths.LEC_DET,
      page: () => LectureDetailsView(),
      binding: SubjectBinding(),
    ),

  ];
}