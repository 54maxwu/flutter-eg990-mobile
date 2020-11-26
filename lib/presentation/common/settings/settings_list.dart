import 'package:flutter/material.dart';

import 'abstract_section.dart';

class SettingsList extends StatelessWidget {
  final bool primary;
  final bool shrinkWrap;
  final bool addBottomDivider;
  final EdgeInsets sectionPadding;
  final ScrollPhysics physics;
  final List<AbstractSection> sections;
  final Color backgroundColor;
  final Color lightBackgroundColor;
  final Color darkBackgroundColor;

  const SettingsList({
    Key key,
    this.sections,
    this.backgroundColor,
    this.physics,
    this.primary = true,
    this.shrinkWrap = false,
    this.sectionPadding,
    this.addBottomDivider,
    this.lightBackgroundColor,
    this.darkBackgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).brightness == Brightness.light
          ? backgroundColor ?? lightBackgroundColor ?? Colors.transparent
          : backgroundColor ?? darkBackgroundColor ?? Colors.black,
      child: ListView.builder(
        primary: primary,
        physics: physics,
        shrinkWrap: shrinkWrap,
        itemCount: sections.length,
        itemBuilder: (context, index) {
          AbstractSection current = sections[index];
          AbstractSection futureOne;
          try {
            futureOne = sections[index + 1];
          } catch (e) {}

          if (addBottomDivider != null) {
            // Add divider by param
            current.showBottomDivider = addBottomDivider;
          } else if (futureOne != null && futureOne.title != null) {
            // Add divider if title is null
            current.showBottomDivider = false;
          } else {
            current.showBottomDivider = true;
          }

          return Padding(
            padding: sectionPadding ?? EdgeInsets.zero,
            child: current,
          );
        },
      ),
    );
  }
}
