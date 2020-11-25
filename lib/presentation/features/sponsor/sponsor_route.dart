import 'package:flutter/widgets.dart';

import 'widgets/sponsor_display.dart';

class SponsorRoute extends StatefulWidget {
  @override
  _SponsorRouteState createState() => _SponsorRouteState();
}

class _SponsorRouteState extends State<SponsorRoute> {
  @override
  Widget build(BuildContext context) {
    return SponsorDisplay();
  }
}
