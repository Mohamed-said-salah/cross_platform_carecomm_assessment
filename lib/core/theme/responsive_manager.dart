import 'package:flutter/material.dart';

enum DeviceScreenType {
  mobile,
  tablet,
  desktop,
}

class ResponsiveManager {
  final BuildContext context;

  const ResponsiveManager(this.context);

  /// Returns the current device screen type, which can be
  /// [DeviceScreenType.mobile], [DeviceScreenType.tablet], or
  /// [DeviceScreenType.desktop].
  ///
  /// The determination is based on the width of the screen, with
  /// widths less than 800 being considered mobile, widths less than
  /// 1200 being considered tablet, and all other widths being
  /// considered desktop.
  DeviceScreenType getDeviceType() {
    if (MediaQuery.of(context).size.width < 800) {
      return DeviceScreenType.mobile;
    } else if (MediaQuery.of(context).size.width < 1200) {
      return DeviceScreenType.tablet;
    } else {
      return DeviceScreenType.desktop;
    }
  }

  /// A convenience function for returning a different value based on the
  /// device screen type.
  ///
  /// The [mobile] parameter is required, while the [tablet] and [desktop]
  /// parameters are optional.
  ///
  /// The method will return the value for the current device screen type.
  /// If the value for the current device screen type is null, it will
  /// return the value for the next screen type up. For example, if the
  /// device screen type is [DeviceScreenType.tablet] and the [tablet]
  /// parameter is null, the method will return the value for
  /// [DeviceScreenType.desktop], or the value for
  /// [DeviceScreenType.mobile] if the [desktop] parameter is also null.
  T responsiveValue<T>(T mobile, T? tablet, T? desktop) {
    switch (getDeviceType()) {
      case DeviceScreenType.mobile:
        return mobile;
      case DeviceScreenType.tablet:
        return tablet ?? mobile;
      case DeviceScreenType.desktop:
        return desktop ?? tablet ?? mobile;
    }
  }
}
