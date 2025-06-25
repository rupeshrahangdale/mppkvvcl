import 'package:flutter/material.dart';

/// App Colors
class AppColors {
  static const Color primaryBlue = Color(0xFF29166f); // Main brand color
  static const Color secondaryBlue =
      Color(0xFF89B1DA); // Lighter blue for accents
  static const Color background = Color(0xFFF8FBFF);
  static const Color white = Colors.white;
  static const Color greyText = Colors.grey;
  static const Color textBlack = Color(0xFF111111);
  static const Color errorRed = Colors.redAccent; // Error messages
}

/// App Image & Icon Assets
class AppAssets {
  // Logo
  static const String logo = 'assets/images/MPPKVVCL_Logo 1.png';
  static const String logo2 = 'assets/images/logo2.png';

  static const String pandingComplaintIcon =
      'assets/dummy_data/icons8-pending-96.png';
  static const String ComplaintIconIll = 'assets/images/complaint.png';
  static const String myComplaintIcon =
      'assets/dummy_data/my-added-comlaints.png';

  // Icons
  static const String docIcon = 'assets/icons/doc.png';

  // Images
  static const String specialPhoto = 'assets/images/special_photo.jpg';

  // network images
  static const String networkImage1 =
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQCUmFikwu9MBCVCQr3JUNThlf76KURzwR6IA&s';

  // SVGs
  static const String docSVG = 'assets/icons/documents.svg';
}

/// App Strings
class AppStrings {
  static const String appName = 'Scada Remedy';
  static const String appDescription = 'MPPKVVCL Mobile App';
  static const String appVersion = 'v1.0.0';
  static const String appPowerdby = 'Powered by NEXTIN LABS';
  static const String welcomeMessage = 'Welcome';
  static const String loginButton = 'Log In';
  static const String logoutButton = 'Log Out';
  static const String allComplaintsTitle = 'All Complaints';
  static const String PandingComplaints = 'Pending \n Complaints';
  static const String allPandingComplaints = 'All Pending Complaints';
  static const String okay = 'Okay';
  static const String fillAllFields = 'Please fill all the fields before proceeding';



  static const String termsAndConditions = 'Terms and Conditions';
  static const String privacyPolicy = 'Privacy Policy';
  static const String contactUs = 'Contact Us';
  static const String aboutUs = 'About Us';
  static const String noDataFound = 'No Data Found';
  static const String loading = 'Loading...';
  static const String errorOccurred = 'An error occurred. Please try again.';
  static const String permissionRequired = 'Permission Required';
  static const String permissionDescription =
      'To give you the best experience, we need the following permissions:';
  static const String locationPermission = 'Location Access';

  static const String filesPermission = 'Files Access';
  static const String musicPermission = 'Music & Audio';
  static const String locationPermissionDescription =
      'Used to show nearby services, maps, and personalize content based on your area.';
  static const String filesPermissionDescription =
      'Needed to upload/download documents or media files from your storage.';
  static const String musicPermissionDescription =
      'Helps manage audio playback, detect background sounds, and support audio features.';

  static const String getStarted = 'Get Started';
  static const String appPermissionsRequired = 'App Permissions Required';
  static const String appPermissionsDescription =
      'To give you the best experience here\'s why we ask for these permissions';
  static const String appLoginDescription = 'Complaint Management System ';
  static const String username = 'Username';
  static const String password = 'Password';
  static const String enterUsername = 'Enter your username';
  static const String enterPassword = 'Enter your password';
  static const String login = 'Login';
  static const String logout = 'Log Out';
  static const String termsAndConditionsUrl =
      'https://www.mppkvvcl.in/terms-and-conditions';
  static const String privacyPolicyUrl =
      'https://www.mppkvvcl.in/privacy-policy';
  static const String contactUsUrl = 'https://www.mppkvvcl.in/contact-us';
  static const String aboutUsUrl = 'https://www.mppkvvcl.in/about-us';
  static const String errorOccurredMessage =
      'An error occurred. Please try again.';

  static const String noDataFoundMessage = 'No Data Found';
  static const String loadingMessage = 'Loading...';
  static const String appAuthor = 'MPPKVVCL Team';
  static const String viewAll = 'View All';
  static const String recentComplaints = 'Recent Complaints';

  static const String complaintType = 'Complaint Type';
  static const String complaintCategory = 'Complaint Category';
  static const String complaintCategoryDescription =
      'Choose the category from below options to proceed with your complaint';

  static const String addNewComplaint = 'Add New Complaint';
  static const String addNewComplaintDescription =
      'Add a new complaint to the system';

  static const String allPandingComplaintsDescription =
      'View all pending complaints in the system';

  static const String myComplaint = 'My Added \n Complaints';

  static const String newComplaintRegister = 'Register New Complaint';
  static const String newComplaintRegisterDescription =
      'Register a new complaint in the system';

  static const String complaintHistory = 'Complaint History';
  static const String complaintStatusOpen = 'Open';
  static const String complaintStatusClosed = 'Closed';
  static const String complaintStatusInProgress = 'In Progress';
  static const String complaintStatusResolved = 'Resolved';
  static const String complaintStatusPending = 'Pending';
  static const String complaintStatusRejected = 'Rejected';
  static const String complaintStatusEscalated = 'Escalated';

  static const String changePassword = 'Change Password';
  static const String forgotPassword = 'Forgot Password';
  static const String resetPassword = 'Reset Password';
  static const String oldPassword = 'Old Password';
  static const String newPassword = 'New Password';
  static const String confirmPassword = 'Confirm Password';

  static const String changePasswordSuccess = 'Password changed successfully.';

  static const String changePasswordDescription =
      'Change your password to keep your account secure';
  static const String passwordResetLinkSent =
      'Password reset link has been sent to your email';
  static const String passwordResetError =
      'An error occurred while resetting the password. Please try again.';
  static const String passwordChangeSuccess =
      'Password has been changed successfully.';
  static const String enterNewPassword = 'Enter your new password';
  static const String enterConfirmPassword = 'Enter your confirm password';

  static const String complaintCreated = 'Complaint created successfully'; //
  static const String complaintCreatedDescription =
      'Your complaint has been registered successfully. You can track its status in the app'; //
  // ';
}

/// App Constants
class AppURLs {
  static const String termsAndConditionsUrl =
      'https://www.mppkvvcl.in/terms-and-conditions';
}

// App Dimensions

class AppDimensions {
  static const double defaultPadding = 16.0;
  static const double defaultPaddingHorizontal = 12.0;
  static const double defaultPaddingVertical = 12.0;
  static const double defaultMargin = 16.0;
  static const double defaultMarginHorizontal = 10.0;
  static const double defaultMarginVertical = 10.0;
  static const double borderRadius = 8.0;
  static const double iconSize = 24.0;
  static const double buttonHeight = 48.0;

  static const double textFieldHeight = 56.0;
}

// app media query

class AppMediaQuery {
  static double get screenWidth =>
      MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width;
  static double get screenHeight =>
      MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.height;
  static double get statusBarHeight =>
      MediaQueryData.fromWindow(WidgetsBinding.instance.window).padding.top;
  static double get bottomBarHeight =>
      MediaQueryData.fromWindow(WidgetsBinding.instance.window).padding.bottom;

  static double get appBarHeight => AppBar().preferredSize.height;
}

/// App Text Styles

class AppTextStyles {
  static const TextStyle heading = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: AppColors.textBlack,
  );

  static const TextStyle subHeading = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textBlack,
  );

  static const TextStyle title = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: AppColors.textBlack,
  );

  static const TextStyle subtitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textBlack,
  );

  static const TextStyle body = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.greyText,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textBlack,
  );

  static const TextStyle error = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: Colors.red,
  );
}
