import 'package:caffeine/core/constants/app_image.dart';
import 'package:caffeine/features/onboarding/data/onboarding_model.dart';

class OnboardingData {
  static final List<onboardingData> onboarding = [
  onboardingData(
    headLine: 'Choose and customize your drinks with simplicity',
    suptitle:
        'You want your drink and you want it your way so be bold and customize the way that makes you the happiest!',
    centerImage: AppImages.customizecoffee,
    bottomImage: AppImages.loading1,
  ),
  onboardingData(
    headLine: 'No time to waste when you need your coffee',
    suptitle:
        'We’ve crafted a quick and easy way for you to order your favorite coffee or treats thats fast!',
    centerImage: AppImages.coffeetime,
    bottomImage: AppImages.loading2,
  ),
  onboardingData(
    headLine: 'Who doesn’t love rewards? We LOVE rewards!',
    suptitle:
        'If you’re like us you love getting freebies and rewards! That’s why we have the best reward program in the coffee game!  ',
    centerImage: AppImages.coffeerewards,
    bottomImage: AppImages.loading3,
  ),
];


}