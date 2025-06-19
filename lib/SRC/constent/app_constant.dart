import 'package:flutter/material.dart';

/// App Colors
class AppColors {
  static const Color primaryBlue = Color(0xFF1976D2); // Main brand color
  static const Color secondaryBlue = Color(0xFF89B1DA); // Lighter blue for accents
  static const Color background = Color(0xFFF8FBFF);
  static const Color white = Colors.white;
  static const Color greyText = Colors.grey;
  static const Color textBlack = Color(0xFF111111);

}

/// App Image & Icon Assets
class AppAssets {
  // Logo
  static const String logo = 'assets/images/MPPKVVCL_Logo 1.png';
  static const String pandingComplaintIcon = 'assets/dummy_data/panding complaint.png';
  static const String myComplaintIcon = 'assets/dummy_data/my complaint.png';


  // Icons
  static const String docIcon = 'assets/icons/doc.png';


  // Images
  static const String specialPhoto = 'assets/images/special_photo.jpg';

  // network images
  static const String networkImage1 = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQCUmFikwu9MBCVCQr3JUNThlf76KURzwR6IA&s';

  // SVGs
  static const String docSVG = 'assets/icons/documents.svg';

}

/// App Strings
class AppStrings {
  static const String appName = 'MPPKVVCL';
  static const String appDescription = 'MPPKVVCL Mobile App';
  static const String appVersion = 'v1.0.0';
  static const String appPowerdby = 'Powered by NEXTINLABs';
  static const String welcomeMessage = 'Welcome';
  static const String loginButton = 'Log In';
  static const String logoutButton = 'Log Out';
  static const String allComplaintsTitle = 'All Complaints';
  static const String allPandingComplaints = 'Pending Complaints';
  static const String termsAndConditions = 'Terms and Conditions';
  static const String privacyPolicy = 'Privacy Policy';
  static const String contactUs = 'Contact Us';
  static const String aboutUs = 'About Us';
  static const String noDataFound = 'No Data Found';
  static const String loading = 'Loading...';
  static const String errorOccurred = 'An error occurred. Please try again.';
  static const String permissionRequired = 'Permission Required';
  static const String permissionDescription = 'To give you the best experience, we need the following permissions:';
  static const String locationPermission = 'Location Access';

  static const String filesPermission = 'Files Access';
  static const String musicPermission = 'Music & Audio';
  static const String locationPermissionDescription = 'Used to show nearby services, maps, and personalize content based on your area.';
  static const String filesPermissionDescription = 'Needed to upload/download documents or media files from your storage.';
  static const String musicPermissionDescription = 'Helps manage audio playback, detect background sounds, and support audio features.';

  static const String getStarted = 'Get Started';
  static const String appPermissionsRequired = 'App Permissions Required';
  static const String appPermissionsDescription = 'To give you the best experience, here\'s why we ask for these permissions:';
  static const String username = 'USERNAME';
  static const String password = 'PASSWORD';
  static const String enterUsername = 'Enter your username';
  static const String enterPassword = 'Enter your password';
  static const String login = 'Log In';
  static const String logout = 'Log Out';
  static const String termsAndConditionsUrl = 'https://www.mppkvvcl.in/terms-and-conditions';
  static const String privacyPolicyUrl = 'https://www.mppkvvcl.in/privacy-policy';
  static const String contactUsUrl = 'https://www.mppkvvcl.in/contact-us';
  static const String aboutUsUrl = 'https://www.mppkvvcl.in/about-us';
  static const String errorOccurredMessage = 'An error occurred. Please try again.';

  static const String noDataFoundMessage = 'No Data Found';
  static const String loadingMessage = 'Loading...';
   static const String appAuthor = 'MPPKVVCL Team';
  static const String viewAll = 'View All';
  static const String recentComplaints = 'Recent Complaints';
  static const String totalComplaints = 'Total Complaints';
  static const String openComplaints = 'Open Complaints';
  static const String closedComplaints = 'Closed Complaints';
  static const String complaintDetails = 'Complaint Details';
  static const String complaintStatus = 'Complaint Status';
  static const String complaintDate = 'Complaint Date';
  static const String complaintType = 'Complaint Type';
  static const String complaintDescription = 'Complaint Description';
  static const String complaintResolution = 'Complaint Resolution';
  static const String complaintId = 'Complaint ID';
  static const String complaintLocation = 'Complaint Location';
  static const String complaintCreatedBy = 'Complaint Created By';
  static const String complaintUpdatedBy = 'Complaint Updated By';
  static const String complaintCreatedAt = 'Complaint Created At';
  static const String complaintUpdatedAt = 'Complaint Updated At';
  static const String complaintAssignedTo = 'Complaint Assigned To';
   static const String complaintCategory = 'Complaint Category';
  static const String complaintSubCategory = 'Complaint Sub-Category';
  static const String complaintAttachments = 'Complaint Attachments';
  static const String complaintComments = 'Complaint Comments';
  static const String addNewComplaint  = 'Add New Complaint';

  static const String myComplaint = 'My Complaint';

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
  static const String passwordResetLinkSent = 'Password reset link has been sent to your email.';
  static const String passwordResetError = 'An error occurred while resetting the password. Please try again.';
  static const String passwordChangeSuccess = 'Password has been changed successfully.';
  static const String enterNewPassword = 'Enter your new password';
  static const String enterConfirmPassword = 'Enter your confirm password';











}

/// App Constants
class AppURLs {
  static const String termsAndConditionsUrl = 'https://www.mppkvvcl.in/terms-and-conditions';

}

// App Dimensions

class AppDimensions {
  static const double defaultPadding = 16.0;
  static const double defaultPaddingHorizontal = 12.0;
  static const double defaultPaddingVertical = 12.0;
  static const double defaultMargin = 16.0;
  static const double defaultMarginHorizontal = 10.0;
  static const double defaultMarginVertical = 10.0;
  static const double borderRadius = 12.0;
  static const double iconSize = 24.0;
  static const double buttonHeight = 48.0;

  static const double textFieldHeight = 56.0;
}

// app media query

class AppMediaQuery {
  static double get screenWidth => MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width;
  static double get screenHeight => MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.height;
  static double get statusBarHeight => MediaQueryData.fromWindow(WidgetsBinding.instance.window).padding.top;
  static double get bottomBarHeight => MediaQueryData.fromWindow(WidgetsBinding.instance.window).padding.bottom;


  static double get appBarHeight => AppBar().preferredSize.height;

}


/// App Text Styles


class AppTextStyles {
  static const TextStyle heading = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: AppColors.textBlack,
  );

  static const TextStyle subtitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textBlack,
  );

  static const TextStyle body = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.greyText,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textBlack,
  );

  static const TextStyle error = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: Colors.red,
  );
}
