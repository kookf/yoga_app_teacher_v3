import 'package:yoga_app/pages/join_class_modules/join_class_view.dart';
import 'package:yoga_app/pages/teacher_login_modules/teacher_register_module/teacher_register_view.dart';

import '../pages/teacher_login_modules/teacher_login_view.dart';
import 'app_pages.dart';
import 'package:get/get.dart';

class AppPages {

  static final routes = [
    GetPage(
      name: AppRoutes.login,
      page: () => LoginView(),
    ),

    GetPage(
      name: AppRoutes.teacherRegister,
      page: () => TeacherRegisterView(),
    ),

    GetPage(
      name: AppRoutes.joinClass,
      page: () => JoinClassView(),
    ),
  ];
}