import 'package:flutter/material.dart';

/// Contains useful functions to reduce boilerplate code
class UIHelper {
  // Vertical spacing constants. Adjust to your liking.
  static const double _verticalSpaceSmall = 10.0;
  static const double _verticalSpaceMedium = 20.0;
  static const double _verticalSpaceLarge = 60.0;

  // Vertical spacing constants. Adjust to your liking.
  static const double _horizontalSpaceSmall = 10.0;
  static const double _horizontalSpaceMedium = 20.0;
  static const double _horizontalSpaceLarge = 60.0;

  /// Returns a vertical space with height set to [_verticalSpaceSmall]
  static Widget verticalSpaceSmall() {
    return verticalSpace(_verticalSpaceSmall);
  }

  /// Returns a vertical space with height set to [_verticalSpaceMedium]
  static Widget verticalSpaceMedium() {
    return verticalSpace(_verticalSpaceMedium);
  }

  /// Returns a vertical space with height set to [_verticalSpaceLarge]
  static Widget verticalSpaceLarge() {
    return verticalSpace(_verticalSpaceLarge);
  }

  /// Returns a vertical space equal to the [height] supplied
  static Widget verticalSpace(double height) {
    return Container(height: height);
  }

  /// Returns a vertical space with height set to [_horizontalSpaceSmall]
  static Widget horizontalSpaceSmall() {
    return horizontalSpace(_horizontalSpaceSmall);
  }

  /// Returns a vertical space with height set to [_horizontalSpaceMedium]
  static Widget horizontalSpaceMedium() {
    return horizontalSpace(_horizontalSpaceMedium);
  }

  /// Returns a vertical space with height set to [_horizontalSpaceLarge]
  static Widget horizontalSpaceLarge() {
    return horizontalSpace(_horizontalSpaceLarge);
  }

  /// Returns a vertical space equal to the [width] supplied
  static Widget horizontalSpace(double width) {
    return Container(width: width);
  }
}
