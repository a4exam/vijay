import 'dart:convert';

class AppUrl {
  static const BASE_URL = "https://examopd.com/api/v1";
  static const BASE_URL2 = "https://examopd.com/api";

  /// auth
  static const EMAIL_CHECKER_URL = "$BASE_URL/emailCheckerUrl";
  static const MOBILE_NO_CHECKER_URL = "$BASE_URL/mobileNoCheckerUrl";
  static const SENT_EMAIL_OTP_URL = "$BASE_URL/sentEmailOtp";
  static const OTP_VERIFICATION = "$BASE_URL/verifyOtp";
  static const MOBILE_NO_OTP_VERIFICATION = "$BASE_URL/mobileNoOtpVerification";
  static const SIGN_UP = "$BASE_URL/mobileNoCheckerUrl";
  static const RESIGNATION_URL = "$BASE_URL/submitResignationData";
  static const GET_PROFILE_URL = "$BASE_URL/getProfile";
  static const UPDATE_MOBILE_URL = "$BASE_URL/updateMobileNo";
  static const UPDATE_EMAIL_URL = "$BASE_URL/updateEmail";
  static const FORGOT_PASSWORD_URL = "$BASE_URL/forgotPassword";
  static const UPDATE_PASSWORD_URL = "$BASE_URL/updatePassword";
  static const REQUIREMENT_URL = "$BASE_URL/requirement";
  static const BACKCALL_URL = "$BASE_URL/backcall";
  static const FAQ_URL = "$BASE_URL/faq";
  static const SUBSCRIPTION_URL = "$BASE_URL/subscription";


  static const GETEXAM_URL = "$BASE_URL/exams";
  static const GETSCOREHISTORY_URL = "$BASE_URL/history?user_id=";
  static const GETSCORECARD_URL = "$BASE_URL/score-card?exam_id=";
  static const GETUploadAdmitCard_URL = "$BASE_URL/upload-admit-card";
  static const GETCUTOFF_URL = "$BASE_URL/cutoff?exam_id=";
  static const GETOMRmRESULT_URL = "$BASE_URL/omr-result";
  static const GETEXAMSIFTSETTING_URL = "$BASE_URL/exam-shift-setting?exam_id=";
  static const GETSCORECARDDETAILS_URL = "$BASE_URL/score-card?exam_id=";


  static String LOGIN_URL = '$BASE_URL/login';
  static String IS_USER_NAME_EXIST_URL = '$BASE_URL/isuser';
  static String EXAM_BOARD_NAME = '$BASE_URL/getExamBoardNameAll';
  static String EXAM_CATEGORY_NAME = '$BASE_URL/getExamCategoryAll';
  static String EXAM_NAME = '$BASE_URL/getExamNameAllByBoardId';
  static const PROFILE_IMAGE_URL = '$BASE_URL/profileImage';
  static const EDIT_PROFILE_DETAILS_URL = '$BASE_URL/editProfileDetails';
  /// hero
  static const subjectUrl = '$BASE_URL/getsubjects';
  static const chapterUrl = '$BASE_URL/chapter';
  static const bookUrl = '$BASE_URL/getbooks';
  static const questionTypesUrl = '$BASE_URL/getquestiontypes';
  static const questionUrl = '$BASE_URL/get-questions';
  static const descriptionLikesUrl = '$BASE_URL/descriptionLikes';
  static const allDescriptionUrl = '$BASE_URL/allDescription';
  static const saveUserDescriptionUrl = '$BASE_URL/saveUserDescription';
  static const updateDescriptionUrl = '$BASE_URL/update-description?id=';
  static const deletedescriptionUrl = '$BASE_URL/delete-description';
  static const updatecommentUrl = '$BASE_URL/update-comment';
  static const deletecommentUrl = '$BASE_URL/delete-comment';
  static const userReportUrl = '$BASE_URL/UserReport';
  static const questionReportUrl = '$BASE_URL/QuestionReport';
  static const saveUserAnswerUrl = '$BASE_URL/saveUserAnswer';

  static String heroQuestionsURL(int page) =>
      "$BASE_URL2/getherodata.php?page=$page";
}
