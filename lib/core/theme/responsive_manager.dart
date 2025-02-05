import 'package:flutter/material.dart';

enum DeviceScreenType {
  mobile,
  tablet,
  desktop,
}

class ResponsiveManager {
  final BuildContext context;

  const ResponsiveManager(this.context);

  DeviceScreenType getDeviceType() {
    if (MediaQuery.of(context).size.width < 800) {
      return DeviceScreenType.mobile;
    } else if (MediaQuery.of(context).size.width < 1200) {
      return DeviceScreenType.tablet;
    } else {
      return DeviceScreenType.desktop;
    }
  }

  T responsiveValue<T>(T mobile, T tablet, T desktop) {
    switch (getDeviceType()) {
      case DeviceScreenType.mobile:
        return mobile;
      case DeviceScreenType.tablet:
        return tablet;
      case DeviceScreenType.desktop:
        return desktop;
    }
  }
}
