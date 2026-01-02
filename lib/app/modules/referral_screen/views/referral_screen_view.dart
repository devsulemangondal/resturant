import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/app/modules/referral_screen/controllers/referral_screen_controller.dart';
import 'package:restaurant/app/widget/global_widgets.dart';
import 'package:restaurant/app/widget/text_widget.dart';
import 'package:restaurant/constant/constant.dart';
import 'package:restaurant/constant/show_toast_dialogue.dart';
import 'package:restaurant/constant_widgets/round_shape_button.dart';
import 'package:restaurant/themes/app_fonts.dart';
import 'package:restaurant/themes/app_theme_data.dart';
import 'package:restaurant/themes/responsive.dart';
import 'package:restaurant/utils/dark_theme_provider.dart';
import 'package:share_plus/share_plus.dart';

class ReferralScreenView extends GetView<ReferralScreenController> {
  const ReferralScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);

    return GetX(
      init: ReferralScreenController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: const Color(0xFFF8FAFF),
          body: controller.isLoading.value
              ? Constant.loader()
              : Column(
                  children: [
                    /// 🔵 HEADER
                    _HeaderSection(controller: controller),

                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          const SizedBox(height: 20),

                          /// 📘 HOW IT WORKS
                          // _HowItWorksCard(),

                          const SizedBox(height: 20),

                          /// 🔗 REFERRAL CODE
                          _ReferralCodeCard(controller: controller),

                          const SizedBox(height: 20),

                          /// 👥 REFERRALS LIST
                          // Container(
                          //   margin: const EdgeInsets.symmetric(
                          //       horizontal: 16, vertical: 6),
                          //   child: Text(
                          //     "Your Refferals (3)",
                          //     style: TextStyle(
                          //         fontSize: 14, color: Color(0xff314158)),
                          //   ),
                          // ),
                          // _ReferralList(),
                          // const SizedBox(height: 30),
                        ],
                      ),
                    )
                  ],
                ),
        );
      },
    );
  }
}

class _HeaderSection extends StatelessWidget {
  final ReferralScreenController controller;
  const _HeaderSection({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: Responsive.width(100, context),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppThemeData.accent300,
              AppThemeData.primary300,
            ],
          ),
        ),
        child: SafeArea(
            child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Color(0xff5952f8),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                          child: Icon(Icons.arrow_back_rounded,
                              color: Colors.white, size: 20)),
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextCustom(
                        title: "Refer and Earn".tr,
                        fontSize: 20,
                        fontFamily: FontFamily.regular,
                        color: AppThemeData.primaryWhite,
                      ),
                      TextCustom(
                        title: "Earn \$50 per referral".tr,
                        fontSize: 14,
                        fontFamily: FontFamily.regular,
                        color: AppThemeData.primaryWhite,
                      ),
                    ],
                  ),
                ],
              ),
              // SizedBox(
              //   height: 16,
              // ),
              // _StatsRow(
              //   controller: controller,
              // )
            ],
          ),
        )));
  }
}

class _StatsRow extends StatelessWidget {
  final ReferralScreenController controller;
  const _StatsRow({required this.controller});

  Widget _stat(String title, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Color(0xff5952f8),
          border: Border.all(color: Colors.white.withOpacity(0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: const TextStyle(fontSize: 12, color: Color(0xffE0E7FF))),
            const SizedBox(height: 6),
            Text(value,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          _stat("Total Earned", "\$450"),
          const SizedBox(width: 10),
          _stat("Referrals", "15"),
          const SizedBox(width: 10),
          _stat("Pending", "\$120"),
        ],
      ),
    );
  }
}

class _HowItWorksCard extends StatelessWidget {
  const _HowItWorksCard();

  Widget _step(int no, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          CircleAvatar(
            radius: 12,
            backgroundColor: const Color(0xFF4F39F6),
            child: Text(
              "$no",
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(text,
                style: const TextStyle(fontSize: 12, color: Color(0xFF45556C))),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6FF),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFC6D2FF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset("assets/icons/ic-reward.svg"),
              SizedBox(
                width: 5,
              ),
              const Text("How It Works",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
            ],
          ),
          const SizedBox(height: 12),
          _step(1, "Share your unique referral code with friends"),
          _step(2, "They sign up and complete their first order"),
          _step(3, "You both earn \$50 in your wallet"),
        ],
      ),
    );
  }
}

class _ReferralCodeCard extends StatelessWidget {
  final ReferralScreenController controller;
  const _ReferralCodeCard({required this.controller});

  @override
  Widget build(BuildContext context) {
    final code = controller.referralModel.value.referralCode ?? "JOHN2025";

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFC6D2FF)),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Your Referral Code",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 18),
            decoration: BoxDecoration(
              color: Color(0xffEFF6FF),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFA3B3FF)),
            ),
            alignment: Alignment.center,
            child: Column(
              children: [
                Text(code,
                    style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4F39F6))),
                // const SizedBox(height: 6),
                // Text("https://zezale.app/ref/$code",
                //     style: const TextStyle(
                //         fontSize: 12, color: Color(0xFF62748E))),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: RoundShapeButton(
                  title: "Copy",
                  titleWidget: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset("assets/icons/ic-copy.svg"),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Copy",
                        style: TextStyle(
                          fontFamily: FontFamily.medium,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff314158),
                        ),
                      )
                    ],
                  ),
                  buttonColor: const Color(0xFFF1F5F9),
                  buttonTextColor: const Color(0xFF1D293D),
                  onTap: () async {
                    await Clipboard.setData(ClipboardData(text: code));
                    ShowToastDialog.toast("Copied");
                  },
                  size: const Size(0, 48),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: GradientRoundShapeButton(
                  titleWidget: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset("assets/icons/ic-share.svg"),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Share",
                        style: TextStyle(
                            fontFamily: FontFamily.medium,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      )
                    ],
                  ),
                  title: "Share",
                  gradientColors: const [Color(0xFF4F39F6), Color(0xFF155DFC)],
                  onTap: () async {
                    await Share.share(
                        "Use my referral code $code and earn rewards!");
                  },
                  size: const Size(0, 48),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ReferralList extends StatelessWidget {
  const _ReferralList();

  Widget _item(String name, String date, String status) {
    final isActive = status == "Active";
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 6))
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: isActive ? Color(0xffB9F8CF) : Color(0xffFFD6A7)),
            child: SvgPicture.asset("assets/icons/ic-person.svg",
                color: isActive
                    ? const Color(0xFF16A34A)
                    : const Color(0xFFF97316)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w600)),
                Text("Joined $date",
                    style: const TextStyle(
                        fontSize: 12, color: Color(0xFF64748B))),
                Text(
                  isActive ? "\$50.00 earned" : "No earnings yet",
                  style: TextStyle(
                      fontSize: 12,
                      color: isActive ? Colors.green : const Color(0xFF64748B)),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color:
                  isActive ? const Color(0xFFD1FAE5) : const Color(0xFFFFEDD5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(status,
                style: TextStyle(
                    fontSize: 12,
                    color: isActive
                        ? const Color(0xFF16A34A)
                        : const Color(0xFFF97316))),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _item("Mike Johnson", "Dec 08, 2025", "Active"),
        _item("Sarah Williams", "Dec 05, 2025", "Active"),
        _item("Tom Anderson", "Dec 10, 2025", "Pending"),
      ],
    );
  }
}
