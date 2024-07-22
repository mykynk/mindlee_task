import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

double deviceHeight(BuildContext context) => MediaQuery.of(context).size.height;
double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;

double deviceHeightSize(BuildContext context, double size) {
  double height = deviceHeight(context);
  if (height > 1920) {
    return size;
  } else if (height > 1200) {
    return height * size * 0.0008;
  } else {
    return height * size * 0.00123;
  }
}

double deviceWidthSize(BuildContext context, double size) {
  double width = deviceWidth(context);
  if (width > 1920) {
    return size * 1.2;
  } else if (width >= 1200) {
    return width * size * 0.0008;
  } else if (width >= 600) {
    return width * size * 0.00123;
  } else {
    return width * size * 0.0026;
  }
}

double deviceTopPadding(BuildContext context) {
  return kIsWeb
      ? 0
      : MediaQuery.of(context).padding.top +
          (Platform.isAndroid ? deviceHeightSize(context, 10) : 0);
}

double deviceFontSize(BuildContext context, double fontSize) {
  double width = deviceWidth(context);
  if (width >= 1200) {
    return desktopFontSize(context, fontSize);
  } else if (width >= 600) {
    return tabletFontSize(context, fontSize);
  } else {
    return mobileFontSize(context, fontSize);
  }
}

double mobileFontSize(BuildContext context, double fontSize) {
  return (deviceHeight(context) / deviceWidth(context)) * 0.48 * fontSize;
}

double tabletFontSize(BuildContext context, double fontSize) {
  double aspectRatio = deviceHeight(context) / deviceWidth(context);
  return aspectRatio > 1
      ? aspectRatio * 0.48 * fontSize * 1.8
      : (1 / aspectRatio) * 0.48 * fontSize * 2.2;
}

double desktopFontSize(BuildContext context, double fontSize) => fontSize * 1.1;
