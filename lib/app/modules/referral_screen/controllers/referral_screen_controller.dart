import 'package:get/get.dart';
import 'package:restaurant/app/models/owner_model.dart';
import 'package:restaurant/app/models/referral_model.dart';
import 'package:restaurant/constant/collection_name.dart';
import 'package:restaurant/constant/constant.dart';
import 'package:restaurant/utils/fire_store_utils.dart';

class ReferralScreenController extends GetxController {
  RxBool isLoading = true.obs;
  Rx<ReferralModel> referralModel = ReferralModel().obs;
  Rx<OwnerModel> ownerModel = OwnerModel().obs;

  @override
  void onInit() {
    getReferralCode();
    super.onInit();
  }

  Future<void> getReferralCode() async {
    try {
      await FireStoreUtils.getReferral().then((value) {
        if (value != null) {
          referralModel.value = value;
          isLoading.value = false;
        } else {
          isLoading.value = false;
        }
      });
    } catch (e) {
      isLoading.value = false;
    }
  }

  Future<void> createReferEarnCode() async {
    isLoading.value = true;
    await FireStoreUtils.fireStore.collection(CollectionName.owner).doc(FireStoreUtils.getCurrentUid()).get().then((value) {
      if (value.exists) {
        ownerModel.value = OwnerModel.fromJson(value.data()!);
      }
    });

    String firstTwoChar = ownerModel.value.slug!.substring(0, 2).toUpperCase();

    ReferralModel referralModel =
        ReferralModel(userId: FireStoreUtils.getCurrentUid(), role: Constant.owner, referralRole: "", referralBy: "", referralCode: Constant.getReferralCode(firstTwoChar));
    await FireStoreUtils.referralAdd(referralModel);
    await getReferralCode();
    isLoading.value = false;
  }
}
