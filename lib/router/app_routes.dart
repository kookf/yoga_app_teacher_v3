import 'package:yoga_app/pages/teacher_login_modules/teacher_register_module/teacher_register_view.dart';
import '../pages/bottom_nav_moudules/bottom_tab_controller.dart';
import '../pages/classroom_modules/classroom_view.dart';
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
      name: AppRoutes.bottomMain,
      page: () => TabPage(),
    ),

    GetPage(
      name: AppRoutes.teacherRegister,
      page: () => TeacherRegisterView(),
    ),
    GetPage(
      name: AppRoutes.classroom,
      page: () => ClassroomView(),
    ),
  ];
}