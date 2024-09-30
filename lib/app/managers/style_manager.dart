part of '../app.dart';

class StyleManager {
  // style metrics
  static const Color primaryTextColor = Color(0xFF000000); // Default black color for primary text
  static const Color secondaryTextColor = Color(0xFF888888); // Default gray color for secondary text
  static const Color accentTextColor = Color(0xFF007AFF); // Blue accent color

  static const double fontSizeSmall = 12.0;
  static const double fontSizeMedium = 14.0;
  static const double fontSizeLarge = 16.0;
  static const double fontSizeXLarge = 18.0;
  static const double fontSizeXXLarge = 24.0;
  static const double fontSizeXXXLarge = 32.0;

  static const double letterSpacingNormal = 0.5;
  static const double lineHeight = 1.5;

  // Text Styles
  // Headings
  static TextStyle get h1 => const TextStyle(
    fontSize: fontSizeSmall,
    color: primaryTextColor,
    fontWeight: FontWeight.normal,
  );

  static TextStyle get h2 => const TextStyle(
    fontSize: fontSizeMedium,
    color: primaryTextColor,
    fontWeight: FontWeight.normal,
  );

  static TextStyle get h3 => const TextStyle(
    fontSize: fontSizeLarge,
    color: primaryTextColor,
    fontWeight: FontWeight.bold,
  );

  // Title (e.g., "Phone Number Verified", "Reset Password?")
  static TextStyle get title => const TextStyle(
    fontSize: fontSizeXXXLarge,
    color: primaryTextColor,
    fontWeight: FontWeight.bold,
  );

  // Subtitle (e.g., "Congratulations, your phone number has been verified")
  static TextStyle get subtitle => const TextStyle(
    fontSize: fontSizeMedium,
    color: secondaryTextColor,
    fontWeight: FontWeight.normal,
    letterSpacing: letterSpacingNormal,
  );

  // Button Text (e.g., "Continue", "Reset", "Submit")
  static TextStyle get buttonText => const TextStyle(
    fontSize: fontSizeLarge,
    color: accentTextColor,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.0,
  );

  // Form Field Label (e.g., "Email Address", "Phone Number")
  static TextStyle get formFieldLabel => const TextStyle(
    fontSize: fontSizeMedium,
    color: primaryTextColor,
    fontWeight: FontWeight.w600,
  );

  // Form Field Text (e.g., input fields for text like "Enter your address")
  static TextStyle get formFieldText => const TextStyle(
    fontSize: fontSizeLarge,
    color: primaryTextColor,
    fontWeight: FontWeight.normal,
  );

  // Small Info Text (e.g., "Save shipping address")
  static TextStyle get smallInfoText => const TextStyle(
    fontSize: fontSizeSmall,
    color: secondaryTextColor,
    fontWeight: FontWeight.normal,
    letterSpacing: letterSpacingNormal,
  );

  // Error Message Text (e.g., "Oops! Failed", "Appointment failed")
  static TextStyle get errorMessage => const TextStyle(
    fontSize: fontSizeXLarge,
    color: ColorManager.errorColorLight, // Red error color
    fontWeight: FontWeight.bold,
  );

  // Success Message Text (e.g., "Congratulations!")
  static TextStyle get successMessage => const TextStyle(
    fontSize: fontSizeXLarge,
    color: accentTextColor, // Blue accent color for success
    fontWeight: FontWeight.bold,
  );

  // List Item Text (e.g., "Dr. Jenny Watson", "Muhammad Haris", in review summary)
  static TextStyle get listItemText => const TextStyle(
    fontSize: fontSizeLarge,
    color: primaryTextColor,
    fontWeight: FontWeight.w500,
  );

  // Small Caption Text (e.g., Doctor's title, e.g., "Immunologist" under the name)
  static TextStyle get smallCaptionText => const TextStyle(
    fontSize: fontSizeSmall,
    color: secondaryTextColor,
    fontWeight: FontWeight.normal,
    letterSpacing: 0.25,
  );

  // Pin Entry Text (e.g., "Enter Your PIN")
  static TextStyle get pinEntryText => const TextStyle(
    fontSize: fontSizeXXLarge,
    color: primaryTextColor,
    fontWeight: FontWeight.w600,
  );

  // Date and Time Text (e.g., "Dec 23, 2024", "10:00 AM")
  static TextStyle get dateTimeText => const TextStyle(
    fontSize: fontSizeMedium,
    color: primaryTextColor,
    fontWeight: FontWeight.normal,
  );

  // Reschedule Option Text (e.g., "I'm not available on schedule")
  static TextStyle get rescheduleOptionText => const TextStyle(
    fontSize: fontSizeMedium,
    color: primaryTextColor,
    fontWeight: FontWeight.normal,
  );

  // Review Summary Text (e.g., "Date & Hour", "Package")
  static TextStyle get reviewSummaryText => const TextStyle(
    fontSize: fontSizeMedium,
    color: primaryTextColor,
    fontWeight: FontWeight.w500,
  );

  // Price Text (e.g., "$20", "$50" in Review Summary)
  static TextStyle get priceText => const TextStyle(
    fontSize: fontSizeLarge,
    color: primaryTextColor,
    fontWeight: FontWeight.bold,
  );

  // Footer Navigation Text (e.g., "Home", "Appointments", "Doctors")
  static TextStyle get footerNavText => const TextStyle(
    fontSize: fontSizeMedium,
    color: secondaryTextColor,
    fontWeight: FontWeight.normal,
  );

  // Toolbar Text (e.g., "Health Management")
  static TextStyle get toolbarText => const TextStyle(
    fontSize: fontSizeXXLarge,
    color: primaryTextColor,
    fontWeight: FontWeight.bold,
  );

  // Hint Text (e.g., "Enter your email", "Enter your password")
  static TextStyle get hintText => const TextStyle(
    fontSize: fontSizeMedium,
    color: secondaryTextColor,
    fontWeight: FontWeight.normal,
    fontStyle: FontStyle.italic,
  );

}
