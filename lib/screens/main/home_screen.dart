import "package:adamulti_mobile_clone_new/components/home_carousel.dart";
import "package:adamulti_mobile_clone_new/components/layanan_component.dart";
import "package:adamulti_mobile_clone_new/components/main_menu_shimmer.dart";
import "package:adamulti_mobile_clone_new/components/saldo_action_component.dart";
import "package:adamulti_mobile_clone_new/components/saldo_component.dart";
import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/cubit/authenticated_cubit.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:adamulti_mobile_clone_new/model/main_menu_mobile.dart";
import "package:adamulti_mobile_clone_new/services/backoffice_service.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:google_fonts/google_fonts.dart";
import "package:line_icons/line_icons.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:responsive_sizer/responsive_sizer.dart";

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [kMainThemeColor, kSecondaryColor, ],
          stops: [0, 0.2],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )
      ),
      child: SingleChildScrollView(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // ClipPath(
            //   clipper: CurveClipper(),
            //   child: Container(
            //       width: size.width,
            //       height: size.height * 0.3,
            //       decoration: const BoxDecoration(
            //         color: kMainThemeColor,
            //       )),
            // ),
            Column(
              children: [
                SizedBox(
                  height: 26.h,
                ),
                Container(
                  width: 100.w,
                  height: 74.h,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(18),
                      topRight: Radius.circular(18)
                    )
                  ),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      width: 40.w,
                      child: BlocBuilder<AuthenticatedCubit, AuthenticatedState>(
                        builder: (context, state) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.authenticatedUser.idreseller!,
                                style: GoogleFonts.inter(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Text(
                                state.authenticatedUser.nAMARESELLER!,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              )
                            ],
                          );
                        },
                      ),
                    ),
                    Container(
                      width: 28.w,
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                          color: Color(0xff6a89cc),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              bottomLeft: Radius.circular(8))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            LineIcons.userAstronaut,
                            color: Colors.white,
                            size: 36,
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          Flexible(
                            child: Text(
                              "Customer Service",
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 5.h,
                ),
                BlocBuilder<AuthenticatedCubit, AuthenticatedState>(
                  builder: (context, state) {
                    return SaldoComponent(
                      amount: state.authenticatedUser.saldo!,
                    );
                  },
                ),
                SizedBox(
                  height: 2.5.h,
                ),
                Card(
                  surfaceTintColor: Colors.white,
                  color: Colors.white,
                  elevation: 2,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    width: 88.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SaldoActionComponent(
                          icon: Icons.account_balance_wallet_rounded,
                          label: "Top Up",
                          onTapAction: () {
                            context.pushNamed("topup-main");
                          }
                        ),
                        SaldoActionComponent(
                          icon: Icons.send_to_mobile_rounded,
                          label: "Transfer",
                          onTapAction: () {}
                        ),
                        SaldoActionComponent(
                          icon: LineIcons.gifts,
                          label: "Reward",
                          onTapAction: () {}
                        ),
                        SaldoActionComponent(
                          icon: LineIcons.wavyMoneyBill,
                          label: "Komisi ",
                          onTapAction: () {}
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.5.h,
                ),
                Container(
                  padding: const EdgeInsets.all(12),
                  color: Colors.white,
                  width: 100.w,
                  child: FutureBuilder<List<MainMenuMobile>>(
                    future: locator.get<BackOfficeService>().getMainMenuMobile(),
                    builder: (context, snapshot) {
                      if(snapshot.connectionState == ConnectionState.done) {
                        return Wrap(
                          alignment: WrapAlignment.start,
                          spacing: 4.w,
                          runSpacing: 12,
                          children: [
                            for(var i = 0; i < snapshot.data!.length; i++) LayananComponent(
                              imageUrl: "$baseUrlAuth/files/menu-mobile/image/${snapshot.data![i].icon!}", 
                              label: snapshot.data![i].name!, 
                              onTapAction: () {
                                if(snapshot.data![i].type! == "PULSA") {
                                  context.pushNamed("pulsa-and-data");
                                }
                                
                                if(snapshot.data![i].type! == "WEBVIEW") {
                                  context.pushNamed("web-view", extra: {
                                    "title": snapshot.data![i].name,
                                    "operatorId": snapshot.data![i].operatorid
                                  });
                                }

                                if(snapshot.data![i].type == "PLN") {
                                  context.pushNamed("pln-main");
                                }

                                if(snapshot.data![i].type == "SINGLE PPOB") {
                                  context.pushNamed("check-before-transaction", extra: {
                                    "operatorName": snapshot.data![i].name,
                                    "kodeproduk": snapshot.data![i].operatorid
                                  });
                                }

                                if(snapshot.data![i].type == "DOUBLE OPERATOR PPOB") {
                                  context.pushNamed("select-operator-double-ppob", extra: {
                                    "operatorName": snapshot.data![i].name,
                                    "operatorId": snapshot.data![i].operatorid
                                  });
                                }

                                if(snapshot.data![i].type == "TRIPLE OPERATOR PPOB") {
                                  context.pushNamed("select-operator-triple-ppob", extra: {
                                    "operatorName": snapshot.data![i].name,
                                    "operatorId": snapshot.data![i].operatorid
                                  });
                                }

                                if(snapshot.data![i].type == "DOUBLE PRODUCT PPOB") {
                                  context.pushNamed("select-product", extra: {
                                    "operatorName": snapshot.data![i].name,
                                    "operatorId": snapshot.data![i].operatorid
                                  });
                                }

                                if(snapshot.data![i].type == "SELECT OPERATOR THEN PRODUCT") {
                                  context.pushNamed("select-operator", extra: {
                                    "operatorName": snapshot.data![i].operatorid
                                  });
                                }
                              }, 
                              menuColor: HexColor(snapshot.data![i].containercolor!).withOpacity(0.5)
                            )
                          ],
                        );
                      } else {
                        return const MainMenuShimmer(dataLength: 12);
                      }
                    },
                  )
                ),
                SizedBox(
                  height: 5.h,
                ),
                Container(
                  color: Colors.white,
                  child: HomeCarousel(),
                ),
                Container(
                  height: 2.5.h,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 0,
                      color: Colors.white
                    ),
                    color: Colors.white
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
