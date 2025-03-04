import 'package:ev_way/app/services/location_service.dart';
import 'package:ev_way/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app/routes/app_pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize services
  await Get.putAsync(() => LocationService().init());

  final authController = Get.put(AuthController());
  runApp(
    GetMaterialApp(
      title: "Ev-Way",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xFFF35F3B),
          primary: Color(0xFFF35F3B),
          primaryContainer: Color(0xFFFFF5F2),
        ),
        textTheme: GoogleFonts.montserratTextTheme(),
      ),
      // initialBinding: BindingsBuilder(() {
      //   Get.put(AuthController());
      // }),
      initialRoute:
          authController.isLoggedIn.value ? Routes.LANDING : Routes.WELCOME,
      getPages: AppPages.routes,
    ),
  );
}

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final isLoggedIn = false.obs;
  final user = Rxn<User>();

  @override
  void onInit() {
    super.onInit();

    // Monitor auth state changes
    // ever(user, _setInitialScreen);

    // Bind auth state to user variable
    user.bindStream(_auth.authStateChanges());

    isLoggedIn.value = _auth.currentUser != null;

    print(_auth.currentUser.toString());

    // Get.snackbar(
    //   'Error',
    //   'Harap login terlebih dahulu',
    //   backgroundColor: Colors.red.withOpacity(0.1),
    //   colorText: Colors.red,
    //   snackPosition: SnackPosition.BOTTOM,
    // );
  }

  // _setInitialScreen(User? user) {

  //   if (user != null) {
  //     // User is logged in
  //     Get.offAllNamed(Routes.LANDING);
  //   } else {
  //     // User is not logged in
  //     Get.offAllNamed(Routes.WELCOME);
  //   }
  // }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
