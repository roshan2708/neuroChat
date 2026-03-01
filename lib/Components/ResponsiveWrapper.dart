import 'package:flutter/material.dart';
import '../Core/Constants.dart';

class ResponsiveWrapper extends StatelessWidget {
  final Widget child;
  final double maxWidth;
  final EdgeInsetsGeometry? padding;

  const ResponsiveWrapper({
    super.key,
    required this.child,
    this.maxWidth = AppConstants.maxContentWidth,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= AppConstants.tabletBreakpoint;
    final isTablet = screenWidth >= AppConstants.mobileBreakpoint;

    final horizontalPadding = isDesktop
        ? AppConstants.spaceXXL
        : isTablet
            ? AppConstants.spaceL
            : AppConstants.spaceM;

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Padding(
          padding:
              padding ?? EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: child,
        ),
      ),
    );
  }
}
