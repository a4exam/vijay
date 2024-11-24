enum ToggleSelection { login, resignation, forgetPassword }

class ToggleUtils {
  static const startResignationPageIndex = 0;
  static const endResignationPageIndex = 4;
  static const startForgotPasswordPageIndex = 5;
  static const endForgotPasswordPageIndex = 6;
  static const startLoginPageIndex = 7;
  static List<PageItem> pageListData = [
    PageItem(
      topTitle: "Create your account",
      topSubTitle: "Sign in-up to enjoy the best managing experience",
    ),
    PageItem(
      topTitle: "Create your account",
      topSubTitle: "Sign in-up to enjoy the best managing experience",
      titleAtToggle: "Enter email & mobile number",
      backButton: true,
    ),
    PageItem(
      topTitle: "Verification your account",
      topSubTitle: "We texted you code to verify your phone number",
      titleAtToggle: "Verification code",
      backButton: true,
    ),
    PageItem(
      topTitle: "Resignation details",
      topSubTitle: "Enter your personal details to access your account",
      titleAtToggle: "Enter resignation details",
      backButton: true,
    ),
    PageItem(
      topTitle: "Create Password",
      topSubTitle:
          "Your password must have at least one symbol & 8 or more characters",
      titleAtToggle: "Create Password",
      backButton: true,
    ),

    /// forgot password
    PageItem(
      topTitle: "Forget Password ?",
      topSubTitle:
          "Your password must have at least one symbol & 8 or more characters",
      titleAtToggle: "Enter user name",
      backButton: true,
    ),
    // PageItem(
    //   topTitle: "Verification your user name",
    //   topSubTitle: "We texted you code to verify your phone number",
    //   titleAtToggle: "Verification code",
    //   backButton: true,
    // ),
    PageItem(
      topTitle: "Re-create Password",
      topSubTitle:
          "Your password must have at least one symbol & 8 or more characters",
      titleAtToggle: "Re-create Password",
      backButton: true,
    ),

    ///loginScreen
    PageItem(
      topTitle: "Go ahead and set up your account",
      topSubTitle: "Enter your login details to access your account",
    ),
  ];
}

class PageItem {
  String topTitle;
  String topSubTitle;
  String titleAtToggle;
  bool backButton;

  PageItem({
    required this.topTitle,
    required this.topSubTitle,
    this.titleAtToggle = "",
    this.backButton = false,
  });
}
