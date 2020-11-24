import 'package:flutter/widgets.dart';

import 'widgets/promo_display.dart';

class PromoRoute extends StatefulWidget {
  @override
  _PromoRouteState createState() => _PromoRouteState();
}

class _PromoRouteState extends State<PromoRoute> {
  @override
  Widget build(BuildContext context) {
    return PromoDisplay();
  }
}
