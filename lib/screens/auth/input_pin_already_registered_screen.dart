import "package:adamulti_mobile_clone_new/components/dynamic_size_button_component.dart";
import "package:adamulti_mobile_clone_new/components/dynamic_snackbar.dart";
import "package:adamulti_mobile_clone_new/components/pin_textfield_component.dart";
import "package:adamulti_mobile_clone_new/components/show_loading_submit.dart";
import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/cubit/authenticated_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/user_appid_cubit.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:adamulti_mobile_clone_new/services/auth_service.dart";
import "package:adamulti_mobile_clone_new/services/secure_storage.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:go_router/go_router.dart";
import "package:google_fonts/google_fonts.dart";
import "package:line_icons/line_icons.dart";
import "package:responsive_sizer/responsive_sizer.dart";

class InputPinAlreadyRegisteredScreen extends StatefulWidget {

  const InputPinAlreadyRegisteredScreen({ super.key, required this.idreseller });

  final String idreseller;

  @override
  State<InputPinAlreadyRegisteredScreen> createState() => _InputPinAlreadyRegisteredScreenState();
}

class _InputPinAlreadyRegisteredScreenState extends State<InputPinAlreadyRegisteredScreen> {
  final pinController = TextEditingController();

  @override
  void dispose() {
    pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            LineIcons.angleLeft,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            context.pop();
          },
        ),
        backgroundColor: kMainThemeColor,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: kMainThemeColor,
            systemNavigationBarColor: Colors.white,
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.light,
            systemNavigationBarIconBrightness: Brightness.light,
            systemNavigationBarDividerColor: Colors.white),
        title: Text(
          "PIN Authentikasi",
            style: GoogleFonts.inter(
            fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white
          ),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: 100.w,
              height: 100.h,
              decoration: const BoxDecoration(
                color: kLightBackgroundColor,
                image: DecorationImage(
                  image: AssetImage("assets/pattern-samping.png"),
                  fit: BoxFit.fill
                )
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 64,
                    backgroundColor: kMainThemeColor.withOpacity(0.1),
                    child: CircleAvatar(
                      radius: 56,
                      backgroundColor: kMainThemeColor.withOpacity(0.2),
                      child: const CircleAvatar(
                        backgroundColor: kMainThemeColor,
                        radius: 44,
                        child: Icon(LineIcons.key, size: 64, color: Colors.white,)
                      ),
                    ),
                  ),
                  const SizedBox(height: 30,),
                  Text("Masukkan PIN Anda.", style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600
                  ),),
                  const SizedBox(height: 20,),
                  PinTextFieldComponent(
                    label: "PIN", 
                    hint: "PIN Akun Anda", 
                    controller: pinController
                  ),
                  const SizedBox(height: 30,),
                  DynamicSizeButtonComponent(
                    label: "Masuk", 
                    buttonColor: kMainLightThemeColor, 
                    onPressed: () {
                      showLoadingSubmit(context, "Proses Login ke Applikasi...");

                      final uuid = FirebaseAuth.instance.currentUser!.uid;
                      locator.get<AuthService>().cekPin(uuid, pinController.text).then((cekPinResponse) {
                        if(cekPinResponse.success! == false) {
                          context.pop();
                          showDynamicSnackBar(
                            context, 
                            LineIcons.exclamationTriangle, 
                            "ERROR", 
                            "PIN SALAH!!!", 
                            Colors.red
                          );
                        } else {
                          locator.get<AuthService>().login(widget.idreseller).then((loginResponse) {
                            locator.get<SecureStorageService>().writeSecureData("jwt", loginResponse.token!);
                            locator.get<AuthenticatedCubit>().updateUserState(loginResponse.user!);
                            locator.get<AuthService>().decryptToken(loginResponse.user!.idreseller!, loginResponse.token!).then((decrypt) {
                              locator.get<UserAppidCubit>().updateState(decrypt);
                              context.goNamed("main");
                            }).catchError((e) {
                              context.pop();
                              showDynamicSnackBar(
                                context, 
                                LineIcons.exclamationTriangle, 
                                "ERROR", 
                                e.toString(), 
                                Colors.red
                              );
                            });
                          }).catchError((e) {
                            context.pop();
                            showDynamicSnackBar(
                              context, 
                              LineIcons.exclamationTriangle, 
                              "ERROR", 
                              e.toString(), 
                              Colors.red
                            );
                          });
                        }
                      }).catchError((e) {
                        context.pop();
                        showDynamicSnackBar(
                          context, 
                          LineIcons.exclamationTriangle, 
                          "ERROR", 
                          e.toString(), 
                          Colors.red
                        );
                      });
                    }, 
                    width: 100.w, 
                    height: 50
                  )
                ],
              ),
            ),
          ],
        )
      ),
    );
  }
}