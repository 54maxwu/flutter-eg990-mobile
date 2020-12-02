import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/presentation/app_theme_export.dart';

class SponsorDisplay extends StatefulWidget {
  // final List<Promo> promos;
  // final PromoStore store;
  //
  // SponsorDisplay({
  //   Key key,
  //   @required this.store,
  //   @required this.promos,
  // }) : super(key: key);

  @override
  _SponsorDisplayState createState() => _SponsorDisplayState();
}

class _SponsorDisplayState extends State<SponsorDisplay>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    // Create TabController for getting the index of current tab
    _tabController = TabController(length: 3, vsync: this);
    // _tabController.addListener(() {
    //   setState(() {
    //     _selectedIndex = _tabController.index;
    //   });
    //   debugPrint("Selected Index: " + _tabController.index.toString());
    // });
  }

  @override
  void dispose() {
    // try {
    //   if (_tabController != null) _tabController.dispose();
    // } catch (e) {
    //   MyLogger.debug(
    //     msg:
    //         'dispose games tab controller (${widget.promos.className}) has exception: $e',
    //     tag: "SponsorDisplay",
    //   );
    // }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: Text(localeStr.workInProgress));
  }
}
